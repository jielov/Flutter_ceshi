import 'package:flutter/material.dart';


class Qiege extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '贝塞尔曲线切割',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurveRffld(),
    );
  }
}

class CurveRffld extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
      title: Text("贝塞尔曲线切割"),
      ),
      body:Column(
        children: <Widget>[
          ClipPath(
            clipper:BottomClipper(),
            child: Container(
              color: Colors.red,
              height: 200,
            ),
          ),
        ],
      )
    );
  }
}

class BottomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    //曲线路径
    var path = Path();
//    path.lineTo(0, 0); //第1个点
//    path.lineTo(0, size.height-50.0); //第2个点
//    var firstControlPoint = Offset(size.width/2, size.height);
//    var firstEdnPoint = Offset(size.width, size.height-50.0);
//    path.quadraticBezierTo(
//        firstControlPoint.dx,
//        firstControlPoint.dy,
//        firstEdnPoint.dx,
//        firstEdnPoint.dy
//    );
//    path.lineTo(size.width, size.height-50.0); //第3个点
//    path.lineTo(size.width, 0); //第4个点

    //波浪曲线路径
    path.lineTo(0, 0); //第1个点
    path.lineTo(0, size.height - 40.0); //第2个点
    var firstControlPoint = Offset(size.width/4, size.height); //第一段曲线控制点
    var firstEndPoint = Offset(size.width/2.25, size.height-30); //第一段曲线结束点
    path.quadraticBezierTo( //形成曲线
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEndPoint.dx,
        firstEndPoint.dy);

    var secondControlPoint = Offset(size.width/4*3, size.height-90); //第二段曲线控制点
    var secondEndPoint = Offset(size.width, size.height-40); //第二段曲线结束点
    path.quadraticBezierTo( //形成曲线
        secondControlPoint.dx,
        secondControlPoint.dy,
        secondEndPoint.dx,
        secondEndPoint.dy);

    path.lineTo(size.width, size.height-40);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
