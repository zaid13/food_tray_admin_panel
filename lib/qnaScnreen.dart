import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_scrollbar_sliver/draggable_scrollbar_sliver.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'Modal/QuestionModal.dart';

class QNAScreen extends StatefulWidget {
  String role;
  QNAScreen(this.role);
  @override
  _QNAScreenState createState() => _QNAScreenState();
}

class _QNAScreenState extends State<QNAScreen> {
  List<DataRow> rowsList = [];

  ScrollController scrCtrl = ScrollController();

  getQA(){


    if(widget.role =='super'){
      return FirebaseFirestore.instance
          .collection("QA")
          .orderBy("time", descending: true)
          .snapshots();
    }




      return  FirebaseFirestore.instance
        .collection("QA")
        .where('place', isEqualTo: widget.role)

        .orderBy("time", descending: true)

        .snapshots();




  }
  @override
  Widget build(BuildContext context) {
    // getfuture(data) async {
    //   QuerySnapshot qs = data;
    //   for (int i = 0; i < qs.docs.length; i++) {
    //     QuerySnapshot data;
    //     if (widget.role == 1 || widget.role == 2) {
    //       data = await FirebaseFirestore.instance
    //           .collection("subscription")
    //           .where("Email", isEqualTo: qs.docs[i].data()["Email"])
    //           .where('place', isEqualTo: widget.role)
    //           .orderBy("datetime", descending: true)
    //           .get();
    //     } else {
    //       data = await FirebaseFirestore.instance
    //           .collection("subscription")
    //           .where("Email", isEqualTo: qs.docs[i].data()["Email"])
    //           .orderBy("datetime", descending: true)
    //           .get();
    //     }
    //
    //     print(data.docs.length);
    //     if (data.docs.length > 0) {
    //       rowsList.add(QuestionModal(qs.docs[i], data.docs.first)
    //           .getDataRow(context, () {}, () {}));
    //     } else {
    //       rowsList.add(QuestionModal(qs.docs[i], null)
    //           .getDataRow(context, () {}, () {}));
    //     }
    //   }
    //
    //   return "data";
    // }

    return Container(
      child: StreamBuilder(
          stream: getQA(),
          builder: (context, snapshot) {
            QuerySnapshot qs = snapshot.data;

            rowsList = [];

            if (snapshot.hasData)
            {
              for (int i = 0; i < qs.docs.length; i++) {


                rowsList.add(QuestionModal(qs.docs[i], null)
                    .getDataRow(context, () {}, () {}));
              }
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
                      columnSpacing: 15.0,
                      dividerThickness: 3,
                      columns: [
                        DataColumn(
                            label: Text(
                          "문의 날짜, 시간 ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              wordSpacing: 10,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.visible,
                        )),
                        DataColumn(
                            label: Text(
                          "어린이집 ",
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
                          "문의",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              wordSpacing: 10,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.visible,
                        )),
                        DataColumn(
                            label: Text(
                          "내 답변",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              wordSpacing: 10,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.visible,
                        )),
                        DataColumn(
                            label: Text(
                          "댓글",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              wordSpacing: 10,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.visible,
                        )),
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
                  child:
                      ModalProgressHUD(inAsyncCall: true, child: Container()));
          }),
    );
  }
}
