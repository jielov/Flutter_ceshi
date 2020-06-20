import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter_filereader/flutter_filereader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../page/examine_fltte_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ExaminePage extends StatefulWidget {

  @override
  _ExaminePageState createState() => _ExaminePageState();
}
@override
void initState() {
  PermissionHandler().requestPermissions([PermissionGroup.storage]);
//  super.initState();
}

class _ExaminePageState extends State<ExaminePage> {
  String TaskId;

  Map<String, String> iosfiles = {
    "txt": "assets/files/txt.txt",
//    "txt": "http://barbra-coco.dyndns.org/student/learning_android_studio.pdf",
  };
  Map<String, String> androidfiles = {
    "txt": "assets/files/txt.txt"
//    "txt": "http://barbra-coco.dyndns.org/student/learning_android_studio.pdf",
  };
  Map<String, String>files;

  @override
  void initState() {
    // TODO: implement initState
    if ( Platform.isAndroid ) {
      files = androidfiles;
    } else {
      files = iosfiles;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('查看')
        ),
        body: ListView.builder(
        itemBuilder: (ctx, index) {
          return item(
              files.keys.elementAt(index), files.values.elementAt(index)
          );
    },
    itemCount: files.length,
    ),
    );
  }

  item(String type, String path) {
    return GestureDetector(
      onTap: () {
        onTap(type, path);
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        margin: EdgeInsetsDirectional.only(bottom: 5),
        color: Colors.blue,
        child: Center(
          child: Text(
            type,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
  onTap(String type, String assetPath) async {
    String localPath = await fileLocalName(type, assetPath);
    if (!await File(localPath).exists()) {
      if (!await asset2Local(type, assetPath)) {
        return;
      }
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return ExamineFlttePage(
        filePath: localPath,
      );
    }));
  }

  fileLocalName(String type, String assetPath) async {
    String dic = await _localSavedDir() + "/filereader/files/";
    return dic + base64.encode(utf8.encode(assetPath)) + "." + type;
  }

  fileExists(String type, String assetPath) async {
    String fileName = await fileLocalName(type, assetPath);
    if (await File(fileName).exists()) {
      return true;
    }
    return false;
  }

  asset2Local(String type, String assetPath) async {
    if ( Platform.isAndroid ) {
      if ( await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage) !=
          PermissionStatus.granted ) {
        debugPrint("没有存储权限");
        return false;
      }
    }
     File file = File(await fileLocalName(type, assetPath));
     if (await fileExists(type, assetPath)) {
       await file.delete();
     }
     await file.create(recursive: true);
     //await file.create();
     debugPrint("文件路径->" + file.path);
    ByteData bd = await rootBundle.load(assetPath);
    await file.writeAsBytes(bd.buffer.asUint8List(), flush: true);
     return true;
  }
  _localSavedDir() async {
    Directory dic;
    if (defaultTargetPlatform == TargetPlatform.android) {
      dic = await getExternalStorageDirectory();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      dic = await getApplicationDocumentsDirectory();
    }
    return dic.path;
  }
}