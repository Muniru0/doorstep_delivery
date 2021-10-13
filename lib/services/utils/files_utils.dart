
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep_delivery/ui/utils/helper_functions.dart/functions.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future<Map<String,dynamic>> getImage(ImageSource source)async{

    try{
    
    XFile? file = await ImagePicker().pickImage(source: source);

      return {'result': true, 'data': file};

    }on PlatformException catch(e){

      myPrint(e,heading: '${e.code} line 15 files_utils.dart');
      return {'result': false,'desc': e.message};

    }

}