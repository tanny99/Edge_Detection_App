
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:opencv/opencv.dart';
import 'package:opencv/core/core.dart';


class ImageConverterPage extends StatefulWidget {
  ImageConverterPage({required this.file});
  File file;
  @override
  _ImageConverterPageState createState() => _ImageConverterPageState(file: file);
}

class _ImageConverterPageState extends State<ImageConverterPage> {
  File file;
  _ImageConverterPageState({required this.file});
  String _platformVersion = 'Unknown';
  dynamic res;
  Image image = Image.asset('assets/temp.png');
  Image imageNew = Image.asset('assets/temp.png');

  bool preloaded = false;
  bool loaded = false;


  @override
  void initState() {
    super.initState();
    initPlatformState();
    loadImage();
    runAFunction();
  }

  Future loadImage() async {
    setState(() {
      image = Image.file(file);
      preloaded = true;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      print('debug 3');
      platformVersion = await OpenCV.platformVersion;
      print('debug 2');
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      print(platformVersion);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> runAFunction() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      res = await ImgProc.canny(await file.readAsBytes(), 50, 200);
      res = await ImgProc.houghLines(await res, threshold: 300, lineColor: "#ff0000");
      setState(() {
        imageNew = Image.memory(res);
        loaded = true;
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      print('debug1');
      print(platformVersion);
    }

    if (!mounted) return;
  }


  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        loaded ? imageNew : Container()

      ],
    );
  }
}