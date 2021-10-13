
import 'package:doorstep_delivery/constants.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:doorstep_delivery/ui/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';

class PasswordUpdatedSuccessfullyRoute extends StatefulWidget {
  
    const PasswordUpdatedSuccessfullyRoute({Key? key}) : super(key: key);
  @override
  _PasswordUpdatedSuccessfullyRouteState createState() => _PasswordUpdatedSuccessfullyRouteState();
}

class _PasswordUpdatedSuccessfullyRouteState extends State<PasswordUpdatedSuccessfullyRoute> {
 
 late double _h;
 late double _w;
 
  @override
  Widget build(BuildContext context) {
    _h = MediaQuery.of(context).size.height;
    _w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
          height: _h,
          color:baseRouteBackgroundColor,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                                  PlayAnimation<double>(
                    tween: Tween(begin: 0.0,end: 1.0),
                    duration:const Duration(seconds: 1),
                    curve: Curves.bounceInOut,
                    builder: (context, child,value) {
                      return Container(
                        width: _w,
                        margin: EdgeInsets.only(left: 15.0,bottom: _h * 0.2,top: 40.0),
                        child: RichText(text:  TextSpan(
                          children: [
                            TextSpan(
                              text: 'Doorstep',
                              style: GoogleFonts.workSans(textStyle: TextStyle(color: brightMainColor,fontSize: 30.0 * value,fontWeight: FontWeight.bold))
                            ),
                             TextSpan(
                              text: '\n \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t Delivery',
                              style: GoogleFonts.italianno(textStyle: TextStyle(color: black,fontSize: 25.0 * value,fontWeight: FontWeight.bold))
                            ),
                          ]
                        )),
                      );
                    }
                  ),



                
                Container(
                  margin:const EdgeInsets.only(top: 50,bottom: 10.0),
                  child:const Icon(Ionicons.md_checkmark_circle_outline, color: brightMainColor,size: 75.0)
                ),

                
                PlayAnimation<double>(
                  tween: Tween(begin: 0.8,end: 1),
                  duration:const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  builder: (context, child,value) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text('Password Reset Success', style: GoogleFonts.workSans(textStyle: TextStyle(color: warmPrimaryColor, fontSize: 18.0 * value,fontWeight: FontWeight.bold,)) ),
                    );
                  }
                ),
              
              

                PlayAnimation<double>(
                  tween: Tween(begin: 0.5,end:1.0),
                  duration:const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  builder: (context, child,value) {
                    return Container(
                      margin:const EdgeInsets.only(bottom: 15.0,),

                      child: Text('You have successfully updated your password.',style: TextStyle(color: silverColor, fontSize: 12.0 * value,fontWeight: FontWeight.bold)),
                    );
                  }
                ),

                const Expanded(child: SizedBox()),
                


                  UtilityWidgets.appButton(title: 'Go to Login',onTap: (){
                    Navigator.pushNamedAndRemoveUntil(context, Constants.LOGIN_ROUTE, (route) => false);
                  }),
                  
                  SizedBox(height: _h * 0.06),

                UtilityWidgets.copyrightWidget(_w),
                  //  InkWell(
                  //    onTap: (){
                  //      Navigator.pushNamedAndRemoveUntil(context, Constants.LOGIN_ROUTE, (route) => false);
                  //    },
                  //    child: Container(
                       
                  //         alignment: Alignment.center,
                  //         padding:const EdgeInsets.symmetric(vertical: 12.0),
                  //         decoration: BoxDecoration(
                  //           color: brightMainColor,
                  //           borderRadius: BorderRadius.circular(5.0),
                       
                  //         ),
                  //         margin:const EdgeInsets.only(bottom: 50.0,left: 20.0, right: 20.0),
                  //          child:const Text('GO TO LOGIN', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.0,color: white )),
                  //        ),
                  //  ),
                     
              ],
            ),
          ),
        ),
    );
  }
}