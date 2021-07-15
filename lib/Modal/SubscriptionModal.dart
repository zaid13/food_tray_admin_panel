




  import 'dart:convert';
import 'dart:typed_data';
  import 'package:network_image_to_byte/network_image_to_byte.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
  import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:universal_html/html.dart' as html;


class SubsrciptionModal  {
    SubsrciptionModal(this.queryDocumentSnapshot){
      init();

    }
  final QueryDocumentSnapshot queryDocumentSnapshot;
   String index;


  String date;
  String date1;
  String txt1;
  String txt2;
  String txt3;
  String radio1;
  String radio2;
  String txt6;
  String txt7;
  String name;
  String phone;
  String bank;
  String accountnumber;
  String accountowner;
  String birth;
  String Email;
  String place;
  String cms;
  String datetime;
  String img;


  init(){
  DateTime dt =DateTime.parse(queryDocumentSnapshot.data()['date'].toString().replaceAll('.','-')??Timestamp.fromDate(DateTime.now()) ) ;
  date = DateFormat("yyyy.MM.dd").format(dt);
  dt =((queryDocumentSnapshot.data()['birth']??Timestamp.now()).toDate()??(DateTime.now()) ) ;
  birth = DateFormat("yyyy.MM.dd").format(dt);
  dt =(queryDocumentSnapshot.data()['datetime'].toDate()??(DateTime.now()) ) ;

  datetime = DateFormat("yyyy.MM.dd").format(dt);



  date1 =queryDocumentSnapshot.data()['date1'];
  txt1 = queryDocumentSnapshot.data()['txt1']??"";
  txt2 = queryDocumentSnapshot.data()['txt2']??"";
  txt3 = queryDocumentSnapshot.data()['txt3']??"";
  radio1 = queryDocumentSnapshot.data()['radio1']??"";
  radio2 = queryDocumentSnapshot.data()['radio2']??"";
  txt6 = queryDocumentSnapshot.data()['txt6']??"";
  txt7 = queryDocumentSnapshot.data()['txt7']??"";
  name = queryDocumentSnapshot.data()['name']??"";
  phone = queryDocumentSnapshot.data()['phone']??"";
  bank = queryDocumentSnapshot.data()['bank']??"";
  accountnumber = queryDocumentSnapshot.data()['accountnumber']??"";
  accountowner = queryDocumentSnapshot.data()['accountowner']??"";
  Email = queryDocumentSnapshot.data()['Email']??"";
  place = queryDocumentSnapshot.data()['place']??"";
  cms = queryDocumentSnapshot.data()['cms']??"";
  img = queryDocumentSnapshot.data()['img']??"";
  index =( queryDocumentSnapshot.data()['index']??'_').toString();


  }
  DataRow getDataRow(BuildContext context,Function startLoadinf,Function stoploading ) {
  return DataRow(cells:_SubscriptionTile(context, startLoadinf, stoploading));
  }
  List<DataCell> _SubscriptionTile(context,Function startLoadinf,Function stoploading ) {
  return [
    DataCell(Text(index,style: TextStyle(fontSize: 12,),)),
    DataCell(Text(Email,style: TextStyle(fontSize: 10),)),
    DataCell(Text(place,style: TextStyle(fontSize: 12,),)),
    DataCell(Text(cms,style: TextStyle(fontSize: 12,),)),
    DataCell(Text(date,style: TextStyle(fontSize: 12,),)),
    DataCell(Text(date1,style: TextStyle(fontSize: 12,),)),
    DataCell(Text(txt1,style: TextStyle(fontSize: 12,),)),
    DataCell(Text(txt2,style: TextStyle(fontSize: 12,),)),
    DataCell(Text(txt3,style: TextStyle(fontSize: 12,),)),
    DataCell(Text(radio1,style: TextStyle(fontSize: 12,),)),
    DataCell(Text(radio2,style: TextStyle(fontSize: 12,),)),
    // DataCell(Text(txt6)),,style: TextStyle(fontSize: 12,,
    // DataCell(Text(txt7)),,style: TextStyle(fontSize: 12,,
    DataCell(Text(name,style: TextStyle(fontSize: 12,),)),
    DataCell(Text(phone,style: TextStyle(fontSize: 12,),)),
    DataCell(Text(bank,style: TextStyle(fontSize: 12,),)),
    DataCell(Text(accountnumber,style: TextStyle(fontSize: 10),)),
    DataCell(Text(accountowner,style: TextStyle(fontSize: 10),)),
    DataCell(RaisedButton(
          onPressed: () async {


      downloadImage(img,context,date,txt1,txt3);

    // showToast('Image downloaded.');

    },

          color: Colors.blue,
          child: Text("Download",
              style: TextStyle(color: Colors.white)),
        )),

    DataCell(RaisedButton(
      onPressed: () async {



        try{
          int i = int.parse(index);
          deleteImage(i,context);

        }
        catch(c){

        }

        // showToast('Image downloaded.');

      },

      color: Colors.red,
      child: Text("Delete",
          style: TextStyle(color: Colors.white)),
    )),


    // DataCell(Text(birth)),,style: TextStyle(fontSize: 12,,
    // DataCell(Text(datetime)),,style: TextStyle(fontSize: 12,,
  ];
  }


    Future<void> deleteImage(int index, context) async {
      try {
       QuerySnapshot qs = await FirebaseFirestore.instance.collection('subscription').where('index',isEqualTo: index).get();


       print(qs.docs[0].id);
      await FirebaseFirestore.instance.collection('subscription').doc(qs.docs[0].id).delete();




      } catch (e) {
        print(e);
      }
    }

    Future<void> downloadImage(String imageUrl,context,dt,t1,t2) async {
      try {
        print(imageUrl??"frrrrrrrrrr");
        // first we make a request to the url like you did
        // in the android and ios version

        http.Response   r =   await   http.get(imageUrl,);



        Uint8List data =r.bodyBytes;

        //
        // Alert(
        //   context: context,
        //   buttons: [DialogButton(child: Text(""), onPressed:(){})],
        //   desc: imageUrl
        // ).show();
        // we get the bytes from the body
        // and encode them to base64
        final base64data = base64Encode(data);

        // then we create and AnchorElement with the html package
        final a = html.AnchorElement(href: 'data:image/jpeg;base64,$base64data');

        // set the name of the file we want the image to get
        // downloaded to
        a.download = '${dt}_${t1}_${t2}.jpg';

        // and we click the AnchorElement which downloads the image
        a.click();
        // finally we remove the AnchorElement
        a.remove();
      } catch (e) {
        print(e);
      }
    }


    Future<Uint8List> _networkImageToByte(url) async {
      Uint8List byteImage = await networkImageToByte(url);
      return byteImage;
    }
  }


