

import 'package:doorstep_delivery/services/models/user_model.dart';
import 'package:doorstep_delivery/ui/base_route.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatefulWidget {
  

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {

 late double _w;
 late double _h;
 String imagePath = 'assets/images/thumb_curved_screen_corner_image.png';

  @override
  Widget build(BuildContext context) {
    _w =MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return BaseView<UserModel>(
        child: SizedBox(
          width: _w,
          height: _h,
          child:
           Stack(
            children: [
                Positioned(
                  top: 0.0,
                  right:-1.0,
                  child: 
                   SizedBox(
                    width:100.0,
                    height:100.0,
                    child: 
                    Image.asset(imagePath),)),

      Positioned(
        bottom:50.0,
        child: InkWell(onTap: (){
              setState(() => imagePath = imagePath == 'assets/images/thumb_curved_screen_corner_image.png' ? 'assets/images/curved_screen_corner_image.png' : 'assets/images/thumb_curved_screen_corner_image.png');
        },child: Text('Tap'),),
      ),

            ],  
          )),
     
      );
  }
}