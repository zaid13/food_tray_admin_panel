

import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Contants/colors.dart';
import 'Contants/place.dart';
import 'Widgets/TextWidget.dart';

class NoticeScreen extends StatefulWidget {
  String role ;
  NoticeScreen(this.role);
  @override
  _NoticeScreen createState() => _NoticeScreen();
}

class _NoticeScreen extends State<NoticeScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  bool _isloading = false;

  String url ='';

  List placeList = [1,2];



  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<PlatformFile> _paths;
  String _extension;

  bool _multiPick = false;
  String _directoryPath;
  String _fileName;

  bool _loadingPath = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();




  @override
  void initState() {
    // TODO: implement initState

  if(widget.role=='1')
  placeList = [1];
  else if(widget.role =='2')
    placeList = [2];

print(placeList);

  }



  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: ['jpg', 'png', ],
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      print(_paths.first.extension);
      _fileName =
      _paths != null ? _paths.map((e) => e.name).toString() : '...';
    });

  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: _isloading,
        child:Material(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: '식판스토리 공지사항',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: blackColor,
                      ),
                      left: width * 0.08,
                      top: height * 0.001,
                    ),
                    Column(
                      children: [
                        url==null?Container():
                        Container(
                            width: 100,
                            height: 100,
                            child: Image(image:NetworkImage(url))),
                        Container(
                          // margin: EdgeInsets.only(left: 100),
                          color: Colors.blue,
                          child: GestureDetector(
                              onTap: () async {

                                // _openFileExplorer();


                                FilePickerResult result = await FilePicker.platform.pickFiles(
                                  allowedExtensions: ['png','Png','PNg','PNG','jpg','JPEG','Jpeg','gpeg']
                                );

                                if (result != null) {
                                  Uint8List fileBytes = result.files.first.bytes;
                                  String fileName = result.files.first.name;

                                  String name  = DateTime.now().millisecondsSinceEpoch.toString();
                                  // Upload file
                              TaskSnapshot taskSnapshot    =await FirebaseStorage.instance.ref('notice/$name/$fileName').putData(fileBytes);
                              print('taskSnapshot.bytesTransferred');
                              print(taskSnapshot.bytesTransferred);

                                  String URL = await taskSnapshot.ref.getDownloadURL();

                                  setState(()  {
url = URL;
                                    });





                                }

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("사진 업로드",
                                 style: TextStyle(
                                   color: Colors.white
                                 ),),
                              )),
                        ),

                      ],
                    ),
                    Container(
                      height: 3,
                      width: 2,

                    )
                    
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.08,
                    right: width * 0.08,
                    top: width * 0.02,
                  ),
                  child: FormBuilder(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: '제목 ',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: lightBlackColor,
                          ),
                        ),
                        FormBuilderTextField(
                          name: 'notice',
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "제목  . . .",

                            hintStyle: TextStyle(
                              color: grayColor,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            border: OutlineInputBorder(),
                            // labelText: '이메일을 입력해주세요.',
                          ),
                          validator:  FormBuilderValidators.compose([

                            FormBuilderValidators.required(context,errorText: '이 필드는 필수입니다'),

                            // FormBuilderValidators.(context),
                          ]),
                        ),
                        SizedBox(height: 10),
                        TextWidget(
                          text: '지점 선택  ',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: lightBlackColor,
                          ),
                        ),
                        FormBuilderDropdown(

                          name: 'place',
                          items: placeList.map((place) =>
                              DropdownMenuItem(

                                  child: Text(mpObj[place.toString()] ,style: TextStyle(color: Colors.black),),
                                  value: place.toString())).toList(),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: FormBuilderValidators.compose([

                            FormBuilderValidators.required(context,errorText: '이 필드는 필수입니다'),


                          ]),
                        ),
                        TextWidget(
                          text: '내용',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: lightBlackColor,
                          ),
                        ),

                        Container(
                          width: width * 0.8,
                          height: 200,
                          child: FormBuilderTextField(
                            name: 'text',
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            minLines: null,
                            maxLines: null,  // If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered.
                            expands: true,
                            style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 1.2,
                              color: Colors.black
                            ),
                            decoration: InputDecoration(
                              hintText: "내용. . .",

                              hintStyle: TextStyle(
                                color: grayColor,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),


                              border: OutlineInputBorder(),
                              // labelText: '이메일을 입력해주세요.',
                            ),
                            validator:  FormBuilderValidators.compose([

                              FormBuilderValidators.required(context,errorText: '이 필드는 필수입니다'),

                              // FormBuilderValidators.(context),
                            ]),
                          ),
                        ),


                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            formKey.currentState.save();
                            if(formKey.currentState.validate()){
                              ADD_Notice(formKey.currentState.value);
                            }



                          },
                          child: Container(
                            height: height * 0.08,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: greenColor,
                                width: 2.0,
                              ),
                            ),
                            child: Center(
                              child: TextWidget(
                                text: '확인',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: greenColor,
                                ),
                                top: height * 0.02,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ) ;
  }
  ADD_Notice(data)async{
    setState(() {

      _isloading = true;
    });
    Map mp = {"time":Timestamp.now(),'url':url};
    mp.addAll(data);

    DocumentReference ds = await FirebaseFirestore.instance.collection('notice').add(Map.from(mp));



    setState(() {
      _isloading = false;

    });

    showpopup(ds, data) ;

  }
  showpopup(res,data){
    if(res==null)
    {
      Alert(
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: "USER LOGIN FAILED",
        buttons: [

          DialogButton(
            child: Text(
              "ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      return;
    }



    Alert(
      context: context,
      type: AlertType.success,
      title: "SUCCESS",
      desc: "NOTICE ADDED",

      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {

            Navigator.pop(context);
            formKey.currentState.reset();

          },

          width: 120,
        )
      ],
    ).show();

    // Manage_Employee
  }
}
