import 'package:ceshi/category/search/page/search_page.dart';
import 'package:ceshi/category/sideslip/page/sideslip_home.dart';
import 'package:ceshi/judge/page/judge_page_home.dart';
import 'package:ceshi/pages/copy/copy_home.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

import '../../../provider/home_page.dart';
import '../../download/page/download_page.dart';
import '../../examine/page/examine_page.dart';
import '../../register/register.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, navigatorKey: navGK, home: Skip());
  }
}

//双击返回退出
int _lastClickTime = 0;

class Skip extends StatefulWidget {
  @override
  _SkipState createState() => _SkipState();
}

class _SkipState extends State<Skip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('跳转'),
      ),
      body: WillPopScope(
        onWillPop: _doubleExit,
          child: list()),
    );
  }
}

class list extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
//              onPressed: () => routePush(ExaminePage(),RouterType.material),
              color: Colors.blue,
              child: Text('查看'),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ExaminePage();
              })),
            ),
            FlatButton(
                onPressed: () =>
                    routePush(DownloadPage(), RouterType.cupertino),
                color: Colors.red,
                child: Text('下载')),
            FlatButton(
                onPressed: () => routePush(LoginPage(), RouterType.cupertino),
                color: Colors.orange,
                child: Text('登录')),
            FlatButton(
                onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomePageGuan();
                    })),
                color: Colors.blueAccent,
                child: Text('状态管理')),
            FlatButton(
                onPressed: () => routePush(CopyHome(), RouterType.cupertino),
                color: Colors.orange,
                child: Text('复制')),
            FlatButton(
                onPressed: () =>
                    routePush(JudgePageHome(), RouterType.cupertino),
                color: Colors.greenAccent,
                child: Text('开关')),
            FlatButton(
              child: Text('下拉刷新'),
              color: Colors.red,
              onPressed: () => routePush(SearchPage(), RouterType.cupertino),
            ),
            FlatButton(
              child: Text('侧滑删除'),
              color: Colors.red,
              onPressed: () => routePush(SidesLipHome(), RouterType.cupertino),
            )
          ],
        ),
      ],
    );
  }
}
//双击返回退出
Future<bool> _doubleExit(){
  int nowTime =  DateTime.now().millisecondsSinceEpoch;
  if(_lastClickTime != 0 && nowTime - _lastClickTime > 1500){
    return Future.value(true);
  }else{
    _lastClickTime = DateTime.now().millisecondsSinceEpoch;
    Future.delayed(const Duration(microseconds: 1500),(){
      _lastClickTime = 0;
    });
    return Future.value(false);
  }
}