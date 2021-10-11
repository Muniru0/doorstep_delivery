

import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_animations/simple_animations.dart';

class TestRoute extends StatefulWidget {
  const TestRoute({ Key? key }) : super(key: key);

  @override
  _TestRouteState createState() => _TestRouteState();
}

class _TestRouteState extends State<TestRoute> {




  String imagePath = 'assets/images/parcel_icon.png';
  @override
  Widget build(BuildContext context) {
    return Container(

      width: 300,
      height: 700,
      color: white,
      child: Center(
        child: Column(
          children: [
           const SizedBox(height: 200),
            Image.asset(imagePath,fit:BoxFit.cover,),

           const SizedBox(height: 50),
            InkWell(onTap: ()async{
              XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
              setState(() {
              imagePath =   file!.path;
              });
          String imageAsString = await file!.readAsString();
            },child: const Text('pick image')),
          ],
        )
      ,
      )
    );
  }
}