
import 'package:flutter/material.dart';
import 'EdgeDetectionOpenCV.dart';
import 'package:opencv/opencv.dart';
import 'package:opencv/core/core.dart';
void main() {
  runApp(const MyApp());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   // String platformVersion = OpenCV.platformVersion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              OutlinedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> EdgeDetectionPage()));}, child: Text('Camera')),
              OutlinedButton(onPressed: (){}, child: Text('Gallery')),
              OutlinedButton(onPressed: (){}, child: Text('URL')),
              OutlinedButton(onPressed: (){}, child: Text('Camera')),
              OutlinedButton(onPressed: (){}, child: Text('All Converted Images')),
            ],
          )
        ],
      ),
    );

  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edge Detection App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Edge Detection App'),
    );
  }
}
