


import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep_delivery/services/firebase_storage_uploader.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:doorstep_delivery/ui/utils/helper_functions.dart/functions.dart';
import 'package:doorstep_delivery/ui/utils/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:simple_animations/simple_animations.dart';



class TestRoute extends StatefulWidget {
  const TestRoute({ Key? key }) : super(key: key);

  @override
  _TestRouteState createState() => _TestRouteState();
}

class _TestRouteState extends State<TestRoute> {


  static http.Client httpClient = http.Client();

  String imagePath = 'https://firebasestorage.googleapis.com/v0/b/doorsteppay-50730.appspot.com/o/user_avatars%2Fthumb_1633985501008_385cdff8-6af3-4909-812e-78d50ad501ef282297304922382690.jpg?alt=media&token=f774c831-ac63-454a-a2aa-f3c968bcb336';
  File? mfile;

  double? value = 0.0;
late double _w;
late double _h;
  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 300.0),
    
        width: 300,
        height: 500,
        color: white,
        child: Center(
          child: true ? 
          
             PlayAnimation<double>(
                         tween: Tween(begin: 0.0,end: 1.0),
                         builder: (context, child,value) {
                           return Material(
                              elevation: 35.0 * value,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                              color: Color(0xFFf7f7f9).withOpacity(0.93),
                              child: Container(
                                padding: EdgeInsets.only(top: 15.0),
                                child: Column(
                                  children: [
                                     Container(
                                          width: 50,
                                          height: 5,
                                          margin: EdgeInsets.only(bottom:10),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF999ab7),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                    Container(
                                      
                                        width: _w ,
                                        height:  _h * 0.2 ,
                                      padding: EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                                      ),
                                      child: Container()
                                    
                                        ),
                                  ],
                                ),
                              ),
                                  );
                         }
                       )
                    
          : Column(
            children: [
               const  SizedBox(height: 250),
                Stack(
                  clipBehavior: Clip.none,
                             children: [
                               Material(
                                 shape: const CircleBorder(),
                                elevation: 17.0,
                                child:  Container(
                                  width: 95,
                                  height: 95,
                                padding:const EdgeInsets.all(7.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFC0C0C0).withOpacity(0.5),
                                ),
                                child: Icon(FontAwesome.user_circle,
                                color: Colors.black.withOpacity(0.2),
                                  size: 65.0 ),
                                ),
                                      ),
                         
                                    Positioned(
                                      bottom:7.0,
                                      right: 0.0,
                                      child: Container(
                                       padding:const EdgeInsets.all(1.0),
                                      decoration:const BoxDecoration(
                                          color: white,
                                         shape: BoxShape.circle,
                                        ),
                                       child: Container(
                                      padding:const EdgeInsets.all(5.0),
                                      alignment: Alignment.center,
                                      decoration:const BoxDecoration(
                                          color: brightMainColor,
                                         shape: BoxShape.circle,
                                        ),
                                                                    
                                      child:const Icon(Feather.edit_2,size: 15.0,color:white)
                                                                    ),
                                                                  ),
                                    ),
                               
                             ],
                           ),
                         
                      const  SizedBox(height: 250),    
            //  const SizedBox(height: 200),
            //   ClipRRect(borderRadius:BorderRadius.circular(50.0) ,child: SizedBox(width: 70,height: 70.0,child:imagePath.isEmpty ?loadingIndicator() : Image.network(imagePath,fit:BoxFit.cover,))),

            //   const SizedBox(height: 50),
            //   ClipRRect(borderRadius:BorderRadius.circular(50.0) ,child: SizedBox(width: 150,height: 150.0,child:mfile == null ?loadingIndicator() : Image.file(mfile!,fit:BoxFit.cover,))),

            //   const SizedBox(height: 50),

            //    const SizedBox(height: 50),
            //   ClipRRect(borderRadius:BorderRadius.circular(50.0) ,child: SizedBox(width: 50,height: 50.0,child:mfile == null ?loadingIndicator() : Image.file(mfile!,fit:BoxFit.cover,))),
            //  const SizedBox(height: 50),

              InkWell(onTap: ()async{
                  
                return;
                var url = 'https://firebasestorage.googleapis.com/v0/b/doorsteppay-50730.appspot.com/o/user_avatars%2Fthumb_1633985501008_385cdff8-6af3-4909-812e-78d50ad501ef282297304922382690.jpg?alt=media&token=f774c831-ac63-454a-a2aa-f3c968bcb336';

               var murl = url.split('%2F').join('kjfalk');


                 var decoded = Uri.decodeQueryComponent(murl);
                 decoded = decoded.split('kjfalk').join('%2F');
               myPrint(decoded,heading: 'Decoded back to url');


              var encoded = Uri.encodeQueryComponent(decoded);
               myPrint(encoded,heading: 'encoded into a literal string.');

                return;
                 String imageAsString = '';
                try{
                XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
                
                File fileToBeUploaded = File(file!.path);
                setState(() {
                  mfile = fileToBeUploaded;
                });
                //return;
              var time = DateTime.now().millisecondsSinceEpoch;
              String fileName = "${time}_${file.name}";
              TaskSnapshot task =   await FirebaseStorage.instance.ref('user_avatars/$fileName').putFile(fileToBeUploaded);
           
           if(task.state ==TaskState.success){
            myPrint(file.name,heading: 'Original name of file');
           var res = await  task.ref.getDownloadURL(); 
           await Future.delayed(const Duration(seconds: 3));
              String downloadUrl = res.split(fileName).join("thumb_$fileName");
            //  String downloadUrl = await FirebaseStorage.instance.ref('user_avatars/thumb_$fileName').getDownloadURL();
             
             setState(() {
               
              imagePath = downloadUrl;


             });
              myPrint(downloadUrl);
             return;
             myPrint('Upload success');
             Directory appDocDir = await getApplicationDocumentsDirectory();
             File dFile = File("${appDocDir.path}/downloaded_file${p.extension(file.path)}");
 TaskSnapshot downloadTask = await FirebaseStorage.instance.ref().writeToFile(dFile);

            if(downloadTask.state == TaskState.success){
             myPrint(dFile.length(),heading: '${dFile.path} Length of the thumbnail');
             print('');
             var fileBytes = await dFile.readAsBytes(); 
            }
           }else{
             print('error uploading file');
           }
                var bytes = await file.readAsBytes();
             var le =  await file.length();
             myPrint(le/1024,heading: 'file size');
          //    File fi = File([], 'assets/images/parcel_icon.png');
          // var m =   await file.readAsBytes();
          //       imageAsString = base64Encode(m);
           
               await FirebaseFirestore.instance.doc('test/image').set({'image_data':imageAsString});
               DocumentSnapshot res =     await FirebaseFirestore.instance.doc('test/image').get();
                  if(res.exists){
                    myPrint((res.data() as Map<String,dynamic>)['image_data'],heading:'Image Data from Firestore');
                  }

                }on PlatformException catch(e){
                  myPrint(e,heading:"${e.code} error picking file");
    
                }
              try{
       // var res =  await  FirebaseFirestore.instance.doc('test/image_test').set({'image_data': imageAsString});
             
              print('done successfully');
              }on FirebaseException catch(e){
                myPrint(e,heading: e.code);
              }
            
              },child: Container(color: black,child: const Text('pick image',style: TextStyle(color: white)))),
           
           
            ],
          )
        ,
        )
      ),
    );
  }
}