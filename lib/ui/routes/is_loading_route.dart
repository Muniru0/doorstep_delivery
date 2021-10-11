


import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';

class IsLoadingRoute extends StatefulWidget {


  const IsLoadingRoute({Key? key}) : super(key: key);
  
  @override
  _IsLoadingRouteState createState() => _IsLoadingRouteState();
}

class _IsLoadingRouteState extends State<IsLoadingRoute> {

 late double _w;
 late double _h;
  @override
  Widget build(BuildContext context) {
    
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;

    return
      Scaffold(
        body: Container(
          width: _w ,
          height: _h ,
          color:goldColor.withOpacity(0.7) ,
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:_h * 0.45),
                  child: const Text('Loading...', style: TextStyle(color: white, fontSize: 12.0, fontWeight: FontWeight.bold))
                ),
                loadingIndicator(valueColor: white),
              ],
            )
          ),
        ),
      )
    ;
  }
}