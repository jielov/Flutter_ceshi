import 'package:flutter/material.dart';
import '../../qiege.dart';
import '../view/skip_down_time.dart';
import '../../pages/home/page/home_page.dart';

 class StartController extends StatefulWidget {
   StartController({Key key}) : super(key: key);

   @override
   _StartControllerState createState() => _StartControllerState();
 }

 class _StartControllerState extends State<StartController> with SingleTickerProviderStateMixin{

   AnimationController _con;
   Animation _animation;

   @override
   void initState() {
     // TODO: implement initState
     super.initState();
     _con = AnimationController(vsync: this, duration: Duration(milliseconds:3000));
     _animation = Tween(begin: 0.0, end:1.0).animate(_con);
    
     _animation.addStatusListener((status){
       if(status == AnimationStatus.completed)
       {
         Navigator.of(context).pushAndRemoveUntil(
           MaterialPageRoute(builder: (context)=> HomePage()),
           (route) => route == null);
       }
     });
     _con.forward();
   }
   @override
   void dispose() {
     // TODO: implement dispose
     super.dispose();
     _con.dispose();
   }
   @override
   Widget build(BuildContext context) {
     return FadeTransition(
       opacity: _animation,
       child: Image.network("http://pic2.sc.chinaz.com/files/pic/pic9/202004/zzpic24682.jpg",
       scale: 2,
       fit: BoxFit.cover,)
       );
   }
 }

