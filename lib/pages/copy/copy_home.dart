import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyHome extends StatefulWidget {
  @override
  _CopyHomeState createState() => _CopyHomeState();
}

class _CopyHomeState extends State<CopyHome> {
  String li = "人生如梦";
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key:key,
      appBar: AppBar(
        title: Text("复制功能"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Text('$li'+'2'),
              FlatButton(
                  onPressed: (){
                    Clipboard.setData(ClipboardData(text: li));
                  },
                  child: Text('222')),
              GestureDetector(
                child: Text(li),
                onLongPress: (){
                  Clipboard.setData(ClipboardData(text: li));
                  key.currentState.showSnackBar(SnackBar(content: Text('复制成功')));
                },
              ),
            TextField(
              decoration: InputDecoration(
                hintText: 'aa'
              ),
            )
          ],
        ),
      ),
    );
  }
}
