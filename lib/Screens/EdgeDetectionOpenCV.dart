
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:opencv/opencv.dart';
import 'package:opencv/core/core.dart';

void main() {
  runApp( EdgeDetectionPage());
}

class EdgeDetectionPage extends StatefulWidget {
  @override
  _EdgeDetectionPageState createState() => _EdgeDetectionPageState();
}

class _EdgeDetectionPageState extends State<EdgeDetectionPage> {
  String _platformVersion = 'Unknown';
  dynamic res;
  Image image = Image.asset('assets/temp.png');
  Image imageNew = Image.asset('assets/temp.png');
  late File file;
  bool preloaded = false;
  bool loaded = false;

  List<String> urls = [
    "https://i.pinimg.com/564x/54/e2/ae/54e2aeefa75d031813ec56f6b3efc9ad.jpg",
    "https://raw.githubusercontent.com/opencv/opencv/master/samples/data/sudoku.png",
    "https://raw.githubusercontent.com/opencv/opencv/master/samples/data/left.jpg",
    "https://raw.githubusercontent.com/opencv/opencv/master/samples/data/left01.jpg",
    "https://raw.githubusercontent.com/opencv/opencv/master/samples/data/right01.jpg",
    "https://raw.githubusercontent.com/opencv/opencv/master/samples/data/smarties.png",
  ];
  int urlIndex = 0;


  @override
  void initState() {
    super.initState();
    loadImage();
    initPlatformState();
  }

  Future loadImage() async {
    file = await DefaultCacheManager().getSingleFile(urls[urlIndex]);

    if (urlIndex >= urls.length - 1) {
      urlIndex = 0;
    } else
      urlIndex++;
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
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              loadImage();
            },
            child: Icon(Icons.refresh),
          ),
          body: ListView(
            children: <Widget>[
              Center(
                child: Text('Running on: $_platformVersion\n'),
              ),
              Text("Before"),
              preloaded
                  ? image
                  : Text("There might be an error in loading your asset."),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlinedButton(
                    onPressed: () {
                      runAFunction();
                    },
                    child: Text('Run'),
                  ),
                ],
              ),
              Text("After"),
              loaded ? imageNew : Container()
            ],
          )),
    );
  }
}