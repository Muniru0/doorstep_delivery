import 'dart:ui';
import 'package:flutter/material.dart';


// app colors
const Color silverColor      = Color(0xFFC0C0C0);
const Color baseRouteBackgroundColor = Color(0xFFf5fafe);
const Color subHeadingsColor  = Color(0xFF7d95af);
const Color fadedHeadingsColor = Color(0xFFb1b6bb);
const Color warmPrimaryColor = Color(0xFF182e65);
const Color goldColor       =  Color(0xFFD4AF37);
const Color black            = Color(0xFF000000);
const Color white            = Color(0xFFFFFFFF);
const Color  errorColor      = Color(0xFFc65149);
const Color brightMainColor  = false ? Color(0xFFcf9a25) : Color(0xFFfab74e);
const Color warmSecondaryColor = Color(0xFFf5fafe);


 // font Sizes
 double headingsSize = 16.0;
 double subHeadingsSize = 13.0;



// loading indicator
 Widget loadingIndicator({width = 30.0,height = 30.0,valueColor = goldColor}){
   return SizedBox(width:width ,height:height ,child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(valueColor)));
 }





