import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/procider.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var counter = Provider.of<Counter>(context).count;
    return Scaffold(
      appBar: AppBar(
        title: Text("状态管理2"),
      ),
      body: Center(
        child: Text("${counter}"),
//        child: Text("${Provider.of<Counter>(context).count}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<Counter>(context).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
