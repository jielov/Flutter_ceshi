import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/procider.dart';
import 'second_page.dart';

class HomePageGuan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('状态管理'),
        actions: <Widget>[
          FlatButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SecondPage();
                  })),
              child: Text('下一页'))
        ],
      ),
      body: Center(
        child: Text("${Provider.of<Counter>(context).count}"),
        //用Provider.of<Counter>(context).count获取_count的值，
        // Provider.of<T>(context)相当于Provider去查找它管理的Counter()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<Counter>(context).increment();
          //用Provider.of<Counter>(context).increment();
          // 调用Counter()中的increment()方法
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
