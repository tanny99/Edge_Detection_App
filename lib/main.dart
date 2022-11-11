import 'package:flutter/material.dart';
import 'Screens/EdgeDetectionOpenCV.dart';
import 'package:opencv/opencv.dart';
import 'package:camera/camera.dart';
import 'package:opencv/core/core.dart';
import 'Screens/Gallery_ImagePicker.dart';
import 'Screens/AllConvertedImages.dart';
import 'Screens/Camera_ImageSelectionScreen.dart';
late final firstCamera;
Future<void>CameraSetup()async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  firstCamera = cameras.first;



}
void main() {
  CameraSetup();
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
              SizedBox(height: 20,),
              OutlinedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> CameraImageSelection(camera: firstCamera)));}, child: Text('Camera')),
              SizedBox(height: 10,),
              OutlinedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> GalleryImagePicker()));}, child: Text('Gallery')),
              SizedBox(height: 10,),
              OutlinedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> EdgeDetectionPage()));}, child: Text('URL')),
              SizedBox(height: 10,),
              //OutlinedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> AllConvertedImages()));}, child: Text('All Converted Images')),
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
