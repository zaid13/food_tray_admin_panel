


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
class QuestionModal{

  QuestionModal(this.queryDocumentSnapshot,this.SubqueryDocumentSnapshot){
    this.docid = queryDocumentSnapshot.id;
    init(queryDocumentSnapshot.data());

  }
  final QueryDocumentSnapshot queryDocumentSnapshot;
  final QueryDocumentSnapshot  SubqueryDocumentSnapshot;
  String docid;
  String txt1;
  String txt2;
  String txt3;
  String question;

  TextEditingController answerCtrl;

  String Email;
  String time;





  init(data){



    this.question = data['question']??"";
    this.answerCtrl =TextEditingController(text:  data['answer']??'');
    this.Email =data['Email']??'';
    DateTime dt =(data['time'].toDate()??DateTime.now() ) ;
    time = DateFormat("yyyy.MM.dd. HH:mm").format(dt);

    txt1 = data['txt1'] ?? "_";
    txt2 = data['txt2'] ?? "_";
    txt3 = data['txt3'] ?? "_";

  }





  DataRow getDataRow(BuildContext context,Function startLoadinf,Function stoploading) {
    return DataRow(cells:_SubscriptionTile(context, startLoadinf, stoploading));
  }
  List<DataCell> _SubscriptionTile(context,Function startLoadinf,Function stoploading) {
    return [
      DataCell(Text(time,style: TextStyle(fontSize: 12,),)),

      DataCell(Text(txt1,style: TextStyle(fontSize: 12,),)),
      DataCell(Text(txt2,style: TextStyle(fontSize: 12,),)),
      DataCell(Text(txt3,style: TextStyle(fontSize: 12,),)),


      DataCell(Text(question,style: TextStyle(fontSize: 12,),)),
      DataCell(Container(
        width: 300,
        height: 100,
        child: TextField(
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,

          // expands: true,
          minLines: 2,
          maxLines: 5,
          controller:answerCtrl ,style: TextStyle(fontSize: 12,),),
      )),

      DataCell(RaisedButton(
        onPressed: () async {


          UpdateAnser(context);

          // showToast('Image downloaded.');

        },

        color: Colors.blue,
        child: Text("UPDATE",
            style: TextStyle(color: Colors.white)),
      )),
    ];
  }

  Future<void>UpdateAnser(context) async {
    try {
      FirebaseFirestore.instance
          .collection("QA").doc(docid).update({"answer":answerCtrl.text});

    } catch (e) {
      print(e);
    }
  }
}