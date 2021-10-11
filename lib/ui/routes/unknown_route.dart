
import 'package:doorstep_delivery/services/models/user_model.dart';
import 'package:doorstep_delivery/ui/base_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:doorstep_delivery/ui/utils/widgets.dart';
import 'package:flutter/material.dart';



class UnknownRoute extends StatefulWidget {
  
 final String error;
  const UnknownRoute({this.error = '',Key? key}) : super(key: key);

  @override
  _UnknownRouteState createState() => _UnknownRouteState();
}

class _UnknownRouteState extends State<UnknownRoute> {
  
 late double _w;
 late double _h;

  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return BaseView<UserModel>(
      screenTitle: "Unknown",
      child: SizedBox(
        width: _w,
        height: _h * 0.9,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
                   const Text("404",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold)),
             
             
              Container(
                  margin: const EdgeInsets.only(top: 15.0, bottom: 25.0),
                  child: widget.error != null
                      ? Text("Account Locked",
                          style: TextStyle(
                              color: warmPrimaryColor.withOpacity(0.9),
                              fontSize: 15.0))
                      : Text("Not Familiar ?",
                          style: TextStyle(
                              color: primaryColor.withOpacity(0.9),
                              fontSize: 15.0))),
              Container(
                  width: _w,
                  padding:const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.center,
                  child: widget.error != null
                      ? Text(widget.error,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: warmPrimaryColor.withOpacity(0.3),
                              fontSize: 12.0))
                      : Text(
                          "Oops!!!, sorry for not being able to find your request page. Please contact admin for further assistance.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: warmPrimaryColor.withOpacity(0.3),
                              fontSize: 12.0))),
              Container(
                  margin:const EdgeInsets.only(top: 30.0),
                  child: UtilityWidgets.customConfirmationButton(context, () {
                    Navigator.pop(context);
                  }, confirmationText: "BACK", isLong: true)),
            
            ]),
      ),
    );
  }
}
