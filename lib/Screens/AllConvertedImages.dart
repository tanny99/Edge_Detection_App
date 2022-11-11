import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
class AllConvertedImages extends StatefulWidget {
  const AllConvertedImages({Key? key}) : super(key: key);

  @override
  State<AllConvertedImages> createState() => _AllConvertedImagesState();
}

class _AllConvertedImagesState extends State<AllConvertedImages> {
  @override
  static Future<List<Map<String, dynamic>>> fetchImages(
      String uniqueUserId) async {
    List<Map<String, dynamic>> files = [];
    final ListResult result = await FirebaseStorage.instance
        .ref()
        .child('images')
        .child(uniqueUserId)
        .list();
    final List<Reference> allFiles = result.items;
    print(allFiles.length);

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      print('result is $fileUrl');

      files.add({
        'url': fileUrl,
        'path': file.fullPath,
      });
    });

    return files;
  }
  @override
  void initState() {
    // TODO: implement initState
    fetchImages("https://console.firebase.google.com/project/edgedetectionapp/storage/edgedetectionapp.appspot.com/files");
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edge Detection App'),),
      body: ListView(
        children: [
          Column()
        ],
      ),
    );
  }
}
