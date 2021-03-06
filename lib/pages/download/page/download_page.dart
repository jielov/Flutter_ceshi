import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

import '../../examine/page/examine_fltte_page.dart';
import 'systemdownfilepackage.dart';
class DownloadPage extends StatefulWidget {
  String title;
  final String url;//下载地址
  final String fileName;//文件名
  final String fileHouZhui;//后缀
  final String isSystemDown;//是否使用调用系统的下载器，true是，false否 使用flutter的下载器
  ValueChanged<int> progressValueChanged;
  DownloadPage({Key key,this.isSystemDown,this.title,this.url,this.progressValueChanged,this.fileHouZhui:".apk",this.fileName:"test"}) : super(key: key);

  @override
  _DownloadPageState createState() => _DownloadPageState();
}


class _DownloadPageState extends State<DownloadPage> {

  ProgressDialog pro;
  String _locaPath = "";
  String _url = "http://enos.itcollege.ee/~jpoial/allalaadimised/reading/Android-Programming-Cookbook.pdf";
  ReceivePort _port = ReceivePort();
//  初始化
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.url != null && widget.url != ""){
      _url = widget.url;
    }
    WidgetsFlutterBinding.ensureInitialized();
    //初始化FlutterDownloader
    FlutterDownloader.initialize().then((v){
      init();
    });
  }

  init() async{
    if(await _checkPermission()){
//      获取路径
      _locaPath = await _findLocalPath();
//      初始化进度条
      IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
      _port.listen((dynamic data){
        String id = data[0];
        DownloadTaskStatus status = data[1];
        print(data[2].toString());
        if(status.value.toString() == "2"){
          print("下载中");
          pro.update(progress: 0.0,message: "下载中");
        }
        if(status.value.toString() == "3"){
          print("下载完成");
          pro.update(progress: 0.0,message: "下载完成");
          showDialogCum(id);
        }
      });
      FlutterDownloader.registerCallback(downloadCallback);
    }else{
      Toast.show("没有权限，请打开存储权限！", context);
    }
  }

  showDialogCum(teskId){
    showCupertinoDialog<int>(context: context, builder: (cxt){
      return CupertinoAlertDialog(
        title: Text("下载完成"),
        content: Text("立即打开"),
        actions: <Widget>[
          CupertinoDialogAction(
            child:Text("取消"),
            onPressed:(){
              Navigator.pop(cxt,1);
            },
          ),
          CupertinoDialogAction(
            child: Text('确定'),
            onPressed: (){
             _openDownloadedFile(teskId);
            },
          )
        ],
      );
    });
  }
//  销毁
  @override
  void dispose() {
    // TODO: implement dispose
    IsolateNameServer.removePortNameMapping("downloader_send_port");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
//    pro =  ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: false);
//    pro.update(progress:0.0, message: "下载中...");

    return Scaffold(
      appBar: AppBar(
        title:Text('下载')
      ),
      body: Container(
        child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 200,
                    color: Colors.blue,
                    child: Text('Flutter Fly是什么？'),

                  ),
                  RaisedButton(
                    child: Text("点我下载文件"),
                    onPressed: () {
                      // 执行下载操作\
                      _doDownload();
                    },
                  ),
                  RaisedButton(
                    child: Text("点我下载文件-Ota_update插件"),
                    onPressed: () {
                      //下载
                      SystemDownFilePackage(context: context,url: _url,fileName: "apk.apk",onChanged: (v){});
                    },
                  ),
                ],
              ),
            )),
    );
  }
  //文件下载
  _doDownload(){
//    pro.show();
    _downloadFile(
      downloadUrl: _url,
      savePath: _locaPath,
    );
  }
// 判断是否拿到权限
  Future<bool> _checkPermission() async{
    if(Theme.of(context).platform == TargetPlatform.android){
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if(permission != PermissionStatus.granted){
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler()
            .requestPermissions([PermissionGroup.storage]);
        if(permissions[PermissionGroup.storage] == PermissionStatus.granted){
          return true;
        }
      }else{
        return true;
      }
    }else{
      return true;
    }
    return false;
  }
// 获取存储路径
Future<String> _findLocalPath() async{
  // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
  // 如果是android，使用getExternalStorageDirectory
  // 如果是iOS，使用getApplicationSupportDirectory
  // androidPath 用于存储安卓段的路径
  String androidPath = "";
  final directory = Theme.of(context).platform == TargetPlatform.android
    ? await getExternalStorageDirectory().then((f){
      print(f.path);
      androidPath = f.path + "/download";
  })
      : await getApplicationDocumentsDirectory();
  //判断androidPath是否为空 为空返回ios的路径 否则 返回android的路径
  if(androidPath != ""){
    final savedDir = Directory(androidPath);
    // 判断下载路径是否存在
    bool heasExisted = await savedDir.exists();
    // 不存在就新建路径
    if(!heasExisted){
      savedDir.create();
    }
    return androidPath;
  }else{
    return directory.path;
  }
}
  // 根据 downloadUrl 和 savePath 下载文件
  _downloadFile({downloadUrl, savePath}) async{
    debugPrint("下载路径" + savePath);
    await FlutterDownloader.enqueue(
        url: downloadUrl,
        savedDir: savePath,
        showNotification: true,
        openFileFromNotification: true
    );
  }
  // 根据taskId打开下载文件
  Future<bool> _openDownloadedFile(taskId) {
    return FlutterDownloader.open(taskId: taskId);
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }
}



