import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as fc;
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';



class FirebaseFileUploader {

  fs.FirebaseStorage _firebaseStorage = fs.FirebaseStorage.instance;

  Future<Map> uploadFile(File file, {remoteDir = ''}) async {
    try {
      var remoteFilePath = '$remoteDir/${basename(file.path)}';

     

    fs.UploadTask  _uploadTask =
          _firebaseStorage.ref('$remoteFilePath').putFile(file);

      // Storage tasks function as a Delegating Future so we can await them.
      await _uploadTask;

      String downloadUrl =
          await _firebaseStorage.ref('$remoteFilePath').getDownloadURL();
      print('This is the downloadUrl($downloadUrl)');
      return {'result': true, 'desc': downloadUrl};
      
    } on fc.FirebaseException catch (e) {
      print(e.code);
      print(e);
      if (e.code == 'object-not-found') {
        return {
          'result': false,
          'desc': 'Unexpectedly losing access to file. please try again.'
        };
      }
      if (e.code == 'cancelled') {
        return {'result': false, 'desc': 'The upload was cancelled.'};
      }
      if (e.code == 'permission-denied') {
        return {'result': false, 'desc': 'Sorry upload failed.'};
      }
    }
    return {'result': false, 'desc': 'An unexpected error occured.'};
  }

  Future<Map> moveFile(File? file) async {
    String docDir = (await getApplicationDocumentsDirectory()).path;

    final File movedImage = await file!.copy(
        '$docDir/${DateTime.now().millisecondsSinceEpoch}${extension(file.path)}');
    if (movedImage != null) {
      print(movedImage.path);

      print('---------------------------- yes moved us');
      return {'result': true, 'desc': movedImage};
    } else {
      print(movedImage.path);
      return {'result': false, 'desc': 'Error moving image.'};
    }
  }
}
