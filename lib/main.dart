import 'package:flutter/material.dart';

//初始页
import 'package:ceshi/start/controller/start_controller.dart';
//状态管理Provider
import 'package:provider/provider.dart';
import 'provider/model/procider.dart';
import 'provider/home_page.dart';

main() {
  runApp(
      ChangeNotifierProvider<Counter>.value(
        value: Counter(),
        child: MyApp(),
      )
//  MultiProvider(
//    providers: [
//      ChangeNotifierProvider.value(value: Counter()),
//    ],
//    child: MyApp(),
//  )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
//      title: '滑动删除',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //起始页
      home: StartController(),
      //状态管理Provider
//        home: HomePage(),
    );
  }
}


