import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_scrollbar_sliver/draggable_scrollbar_sliver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:universal_html/html.dart' as html1;
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as s ;
import 'package:universal_html/html.dart';

import 'Modal/SubscriptionModal.dart';

class ManageScreen extends StatefulWidget {
  String role ;
  ManageScreen(this.role);
  @override
  ManageScreenState createState() => ManageScreenState();
}

class ManageScreenState extends State<ManageScreen> {
  @override
  List<DataRow> rowsList = [];
  List<SubsrciptionModal> subList = [];

  ScrollController scrCtrl = ScrollController();

getManageList(){


  if(widget.role =='1') {
    return FirebaseFirestore.instance
        .collection("subscription").
        where('place',isEqualTo: '흥덕/서원/세종').
    orderBy("datetime", descending: true).
    snapshots();
  }

  if(widget.role =='2') {
    return FirebaseFirestore.instance
        .collection("subscription").
        where('place',isEqualTo: '상당/청원/충북')
    .orderBy("datetime", descending: true).
    snapshots();
  }
  return FirebaseFirestore.instance
      .collection("subscription").
  orderBy("datetime", descending: true).
  snapshots();
  }

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 40,
            width: 200,
            child: FlatButton(
                color: Colors.green,
                onPressed: () {

                  createExcel(subList);
                },
                child: Row(
                  children: [
                    Text(
                      'Export to EXCEL',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Icon(
                      Icons.table_chart_outlined,
                      color: Colors.white,
                    )
                  ],
                )),
          ),
          Expanded(
            child: StreamBuilder(
                stream:getManageList(),
                builder: (context, snapshot) {
                  rowsList = [];

                  if (snapshot.hasData) {
                    QuerySnapshot qs  = snapshot.data;
                    int ctr =1;
                    qs.docs.forEach((element) {
                      rowsList.add(SubsrciptionModal(element).getDataRow(context,(){


                      },(){}));
                      subList.add(SubsrciptionModal(element));
                    ctr++;
                    });

                    return DraggableScrollbar.semicircle(
                      controller: scrCtrl,
                      alwaysVisibleScrollThumb: true,

                      backgroundColor: Colors.deepOrange,

                      child: SingleChildScrollView(
                        controller: scrCtrl,
                        scrollDirection: Axis.vertical,

                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,

                          child: DataTable(


                            columnSpacing: 10.0,
                            dividerThickness: 3,
                            columns: [
                              DataColumn(
                                  label: Text(
                                "번호 ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "아이디 ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold,

                                  ),
                                    overflow: TextOverflow.visible,

                                  )),
                              DataColumn(
                                  label: Text(
                                "가입 지점",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "결제 방식",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "신청서 작성 날짜",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "무료체험",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "어린이집",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "반",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "자녀 이름",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "신입생 여부",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "원내 다자녀 여부",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "신청인 성명",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "휴대폰 번호",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "은행명",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "자동이체 계좌번호",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "예금주",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                "예금주 생년월일 ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    wordSpacing: 10,
                                    fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.visible,

                              )),
                              DataColumn(
                                  label: Text(
                                    "예금주 생년월일 ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        wordSpacing: 10,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.visible,

                                  ))
                              ,
                            ],
                            rows: rowsList,

                          ),
                        ),
                      ),
                    );
                  }
                  else
                  return Container(
                      height: 200,
                      width: 200,
                      child: ModalProgressHUD(
                          inAsyncCall: true, child: Container()));
                }),
          ),
        ],
      ),
    );
  }
}

createExcel(List<SubsrciptionModal> lstSub ) async
{
  //Create a Excel document.
  //Creating a workbook.
  final  s.Workbook workbook = s.Workbook();
  //Accessing via index.
  final s.Worksheet sheet = workbook.worksheets[0];
  // Set the text value

  sheet.getRangeByName('A1').setText('번호');   //number
  sheet.getRangeByName('B1').setText('아이디');   // email
  sheet.getRangeByName('C1').setText('가입 지점');  //date
  sheet.getRangeByName('D1').setText('결제 방식');   //extra or date1
  sheet.getRangeByName('E1').setText('신청서 작성 날짜');
  sheet.getRangeByName('F1').setText('무료체험');
  sheet.getRangeByName('G1').setText('어린이집');
  sheet.getRangeByName('H1').setText('반');
  sheet.getRangeByName('I1').setText('자녀 이름');
  sheet.getRangeByName('J1').setText('신입생 여부');
  sheet.getRangeByName('K1').setText('원내 다자녀 여부');
  sheet.getRangeByName('L1').setText('원내 다자녀 반'); //number class
  sheet.getRangeByName('M1').setText('원내 다자녀 이름'); //child name

  sheet.getRangeByName('N1').setText('신청인 성명');
  sheet.getRangeByName('O1').setText('휴대폰 번호 ');
  sheet.getRangeByName('P1').setText('은행명');
  sheet.getRangeByName('Q1').setText('자동이체 계좌번호');
  sheet.getRangeByName('R1').setText('예금주');
  sheet.getRangeByName('S1').setText('예금주 생년월일 ');

  int ctr = 2;
  lstSub.forEach((element) {

    sheet.getRangeByName('A'+(ctr).toString()).setText(element.index);   //number
    sheet.getRangeByName('B'+(ctr).toString()).setText(element.Email);   // email
    sheet.getRangeByName('C'+(ctr).toString()).setText(element.place);  //date
    sheet.getRangeByName('D'+(ctr).toString()).setText(element.cms);   //extra or date1
    sheet.getRangeByName('E'+(ctr).toString()).setText(element.date);
    sheet.getRangeByName('F'+(ctr).toString()).setText(element.date1);
    sheet.getRangeByName('G'+(ctr).toString()).setText(element.txt1);
    sheet.getRangeByName('H'+(ctr).toString()).setText(element.txt2);
    sheet.getRangeByName('I'+(ctr).toString()).setText(element.txt3);
    sheet.getRangeByName('J'+(ctr).toString()).setText(element.radio1);
    sheet.getRangeByName('K'+(ctr).toString()).setText(element.radio2);
    sheet.getRangeByName('L'+(ctr).toString()).setText(element.txt6); //number class
    sheet.getRangeByName('M'+(ctr).toString()).setText(element.txt7); //child name

    sheet.getRangeByName('N'+(ctr).toString()).setText(element.name);
    sheet.getRangeByName('O'+(ctr).toString()).setText(element.phone);
    sheet.getRangeByName('P'+(ctr).toString()).setText(element.bank);
    sheet.getRangeByName('Q'+(ctr).toString()).setText(element.accountnumber);
    sheet.getRangeByName('R'+(ctr).toString()).setText(element.accountowner);
    sheet.getRangeByName('S'+(ctr).toString()).setText(element.birth);
ctr++;
  });

  //Save and launch the excel.
  final List<int> bytes = workbook.saveAsStream();
  //Dispose the document.
  workbook.dispose();

    AnchorElement(
      href:
      "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
    ..setAttribute("download", "output.xlsx")
    ..click();
}