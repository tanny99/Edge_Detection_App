import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:edge_detection_app/Image_Converter.dart';
void main(){
  runApp(GalleryImagePicker());
}

class GalleryImagePicker extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        appBar: AppBar(
          title: const Text('Edge Detection App'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),

        ),
        body: ListView(

              children: [
                SizedBox(height: 20,),
                Center(child: Text('Hi there, Press this button to pick an image.')),
                SizedBox(height: 10,),

                ElevatedButton(
                    onPressed: () async {
                      image = await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        //update UI
                      });
                    },
                    child: Text("Pick Image")
                ),
                SizedBox(height: 10,),
                image == null?Text(' '):Center(child: Text('Your picked image- ')),
                SizedBox(height: 10,),
                image == null?Container():
                Image.file(File(image!.path)),
                SizedBox(height: 10,),
                image == null?Text(' '):Center(child: Text('Image after applying Edge Detection algorithm- ')),
                SizedBox(height: 10,),
                image == null?Container():ImageConverterPage(file:File(image!.path) )


              ],)

    );
  }
}