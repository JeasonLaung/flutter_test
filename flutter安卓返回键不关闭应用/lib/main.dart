import 'dart:convert';

import 'package:apptest/test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const backToDesktopChannel =
  const MethodChannel('com.example.platform_channel');//1
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        // 参数
        String ag = json.encode(settings.arguments);
        Map params = json.decode(ag ?? '{}');
        if(settings.name == '/test') {
          return MaterialPageRoute(builder: (context) => TestPage(arguments: params));
        }
      },
      // routes: {
      //   '/test': (_) {
      //     return TestPage();
      //   }
      // },
      title: "Flutter Demo",
      home: WillPopScope(
        child: MyHome(),
        onWillPop: () async{
          bool result = await backToDesktopChannel.invokeMethod('backToDesktop');
          if(result == true) {
            return false;
          } else {
            return true;
          }
        },
      ),
    );
  }


}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int count = 0;
  static const platformChannel =
  const MethodChannel('com.example.platform_channel');//1
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("首页返回键不退出，退至后台运行"),
        ),
        body: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              Text('当前count值：$count'),
              RaisedButton(
                child: Text("+1"),
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
              ),
            ],
          )
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.pushNamed(context, '/test');
          },
        )
    );
  }

}
