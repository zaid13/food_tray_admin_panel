

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Contants/colors.dart';
import 'Contants/place.dart';
import 'Widgets/TextWidget.dart';

class NoticeScreen extends StatefulWidget {
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<NoticeScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  bool _isloading = false;


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
    Map mp = {"time":Timestamp.now()};
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
