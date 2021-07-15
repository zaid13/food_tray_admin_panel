import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_tray_web_admin/LoginScreen.dart';
import 'package:food_tray_web_admin/enum.dart';
import 'package:food_tray_web_admin/qnaScnreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'manage_screen.dart';
import 'notice_screen.dart';

Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(name: "",options: FirebaseOptions(
  //     apiKey: "AIzaSyBE3U8TFJClpEPKUlUGPrCe5JKaXJo1WpA",
  //     authDomain: "food-tray-app.firebaseapp.com",
  //     projectId: "food-tray-app",
  //     storageBucket: "food-tray-app.appspot.com",
  //     messagingSenderId: "274613031721",
  //     appId: "1:274613031721:web:6c9ae78ffd4bcf1d59dd38",
  //     measurementId: "G-MEZHPWL6W6",
  //
  //
  //
  //
  // ));
  // //
await  Firebase.initializeApp().then((value) {
  runApp(MyApp());
});
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '식판스토리',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginInScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String role ;

  MyHomePage(this.role,{Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  ScreenEnum _screenEnum =ScreenEnum.MANAGE;
  @override
  Widget build(BuildContext context) {
    //print(widget.role);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width *0.1,
              child: Column(

children: [
  Expanded(child: FlatButton(
      color: Colors.grey,
      onPressed: (){_buttonPressed(ScreenEnum.MANAGE);},

              splashColor: Colors.blueAccent,
      child: Container(
    child: Center(
      child: Text("신청서 관리 ",style: TextStyle(color: Colors.black),),
    ),
)
  )
  ),
  

  Expanded(child: FlatButton(
      color: Colors.grey,
    onPressed: (){_buttonPressed(ScreenEnum.QNA);},
splashColor: Colors.blueAccent,
      child: Container(
    child: Center(
      child: Text("1:1 문의",style: TextStyle(color: Colors.black),),
    ),
))),
  Expanded(child: FlatButton(
      color: Colors.grey,
      onPressed: (){_buttonPressed(ScreenEnum.NOTICE);},
      splashColor: Colors.blueAccent,
      child: Container(
        child: Center(
          child: Text("공지사항",style: TextStyle(color: Colors.black),),
        ),
      ))),


],
              ),
            ),
            _screenEnum==ScreenEnum.NOTICE? Expanded(child: NoticeScreen(widget.role)):_screenEnum==ScreenEnum.QNA?Expanded( child: QNAScreen(widget.role)):Expanded(child: ManageScreen(widget.role)),

          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer
      // for build methods.
    );
  }
  _buttonPressed(o){
    if ( o==ScreenEnum.MANAGE &&   _screenEnum!=ScreenEnum.MANAGE){
      setState(() {
        _screenEnum=ScreenEnum.MANAGE;
      });
    }
    else if ( o==ScreenEnum.QNA &&   _screenEnum!=ScreenEnum.QNA){
      setState(() {
        _screenEnum=ScreenEnum.QNA;
      });
    }
    else if ( o==ScreenEnum.NOTICE &&   _screenEnum!=ScreenEnum.NOTICE){
      setState(() {
        _screenEnum=ScreenEnum.NOTICE;
      });
    }


  }
}
