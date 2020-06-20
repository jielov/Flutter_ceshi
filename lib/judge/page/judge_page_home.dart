import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JudgePageHome extends StatefulWidget {
  @override
  _JudgePageHomeState createState() => _JudgePageHomeState();
}

class _JudgePageHomeState extends State<JudgePageHome> {
  bool _switchSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('锁屏密码'),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('锁屏密码',
                    style: TextStyle(
                        fontSize: 18
                    )),
                Text('开启后通过授权查看',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black26
                    ))
              ],
            ),
            CupertinoSwitch(
                value: _switchSelected,
                activeColor: Colors.redAccent,
                onChanged: (value){
                  setState(() {
                    this._switchSelected = value;
                  });
                })
          ],
        ),
      ),
    );
  }
}
