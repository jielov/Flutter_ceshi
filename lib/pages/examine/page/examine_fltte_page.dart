import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_filereader/flutter_filereader.dart';


class ExamineFlttePage extends StatefulWidget {

  final String filePath;
  ExamineFlttePage({Key: Key, this.filePath});
  @override
  _ExamineFlttePageState createState() => _ExamineFlttePageState();
}

class _ExamineFlttePageState extends State<ExamineFlttePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('查看')
      ),
      body: Container(
        color: Colors.blue,
        child: FileReaderView(
          filePath: widget.filePath,
        ),
      ),
    );
  }
}
