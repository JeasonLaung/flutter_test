import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  final Map<String,dynamic> arguments;
  TestPage({this.arguments});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int pageNum = 0;
  @override
  void initState() {
    // print('这里是${widget.arguments is Map<String,dynamic>}');
    // print(widget.arguments['page_num']);
    if(widget.arguments!=null) {
      pageNum = widget.arguments['page_num'];
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('测试$pageNum'),),
      body: Center(
        child: Text('除首页外的页面均返回键均为返回上一页'),
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.of(context).pushNamed('/test',arguments: {
              'page_num': pageNum + 1
            });
          },
        )
    );
  }
}
