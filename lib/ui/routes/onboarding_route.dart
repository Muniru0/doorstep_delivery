
import 'package:doorstep_delivery/constants.dart';
import 'package:doorstep_delivery/ui/routes/login_route.dart';
import 'package:doorstep_delivery/ui/routes/signup_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:doorstep_delivery/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'dart:io';
import 'package:simple_animations/simple_animations.dart';




class OnboardingRoute extends StatefulWidget {


  const OnboardingRoute({Key? key}) : super(key: key);

  @override
  _OnboardingRouteState createState() => _OnboardingRouteState();
}

class _OnboardingRouteState extends State<OnboardingRoute> {
  int slideIndex = 0;
 late PageController controller;
  Route _createRoute(firstRoute, secondRoute) {
    return PageRouteBuilder(
      transitionDuration:const Duration(milliseconds: 350),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          secondRoute,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) =>
          Stack(
        children: <Widget>[
          SlideTransition(
            position:  Tween<Offset>(
              begin: const Offset(0.0, 0.0),
              end: const Offset(-1.0, 0.0),
            ).animate(animation),
            child: firstRoute,
          ),
          SlideTransition(
            position:  Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: secondRoute,
          )
        ],
      ),
    );
  }

  // Widget _buildPageIndicator(bool isCurrentPage) {
  //   return Container(
  //     margin:const EdgeInsets.symmetric(horizontal: 2.0),
  //     height: isCurrentPage ? 10.0 : 6.0,
  //     width: isCurrentPage ? 10.0 : 6.0,
  //     decoration: BoxDecoration(
  //       color: isCurrentPage ? brightMainColor : Colors.grey[300],
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //   );
  // }



  @override
  void initState() {
    super.initState();

    controller = PageController();
  }

 late double _w;
 late double _h;

  @override
  Widget build(BuildContext context) {
    _h = MediaQuery.of(context).size.height;
    _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:baseRouteBackgroundColor,
      body: SizedBox(
        height: _h,
        child: Stack(
          children: [
            
               PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    slideIndex = index;
                  });
                },
                children: <Widget>[
                  onBoardingWidget(
                      iconPath: Constants.PARCEL_ICON ,
                      title: "Manage your courier business.",
                      desc: "Like never before with outmost convenience."),
                  onBoardingWidget(
                      iconPath: Constants.PHONE_WITH_WALLET_ICON,
                      title: "Get real-time update of all parcel transfers",
                      desc:
                          "Get real time update of all parcel transfers in all branches of your business across the nation from the comfort of your mobile phone."),
                  onBoardingWidget(
                      iconPath: Constants.MAGNIFYING_GLASS_ICON ,
                      title: "Search through the archives of all branches",
                      desc:
                          "Search through all parcel transfers in all branches of your business anytime and anywhere."),
                  onBoardingWidget(
                      iconPath: Constants.SECURED_TRANSACTIONS_ICON,
                      title: "Enjoy convenience with security",
                      desc:
                          "With industry standard secured servers and technology our platform is convenient,safe and secured."),
                  onBoardingWidget(
                      iconPath: Constants.WALLET_AND_CARD_ILLUSTRATION,
                      title: "Increase the prospects of your business",
                      desc:
                          "With our easy to use platform, you are assured of a consistent growth through out your company."),
                  onBoardingWidget(
                      iconPath: Constants.PHONE_WITH_WALLET_ICON,
                      title: "All from your mobile phone",
                      desc:
                          "Enjoy the remarkable growth of your income right from your phone. Manage your business like never before"),
                ],
              ),
            
            Positioned(
              bottom: 30.0,
              child: slideIndex == 5
                  ? Container()
                  : 
                       Column(
                        children: [
                          Container(
                            margin:const EdgeInsets.only(bottom: 35.0),
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  width: _w,
                                  alignment: Alignment.center,
                                  padding:
                                     const EdgeInsets.symmetric(horizontal: 140.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      buildIndicator(active: slideIndex == 0),
                                      buildIndicator(active: slideIndex == 1),
                                      buildIndicator(active: slideIndex == 2),
                                      buildIndicator(active: slideIndex == 3),
                                      buildIndicator(active: slideIndex == 4),
                                      buildIndicator(active: slideIndex == 5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                          Container(
                            width: _w,
                            alignment: Alignment.center,
                            margin:const EdgeInsets.only(top: 10.0),
                            padding:const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: UtilityWidgets.customCancelButton(
                                          context, () {
                                  Navigator.push(context, CupertinoPageRoute(builder: (context)=> SignUpRoute(fromOnBoardingRoute: true,)));
                                  }, cancelText: "REGISTER")),
                                  Container(
                                      child: UtilityWidgets
                                          .customConfirmationButton(context,
                                              () {
                                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> const LoginRoute(fromOnBoardingRoute: true,)));
                                  }, confirmationText: "LOGIN")),
                                ]),
                          ),
                    
                        ],
                      ),
                    
            ),
          ],
        ),
      ),
      bottomSheet: slideIndex != 5
          ? null
          : 
         
          InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(_createRoute(widget, SignUpRoute()));
              },
              child: Container(
                height: Platform.isIOS ? 70 : 60,
                color: primaryColor,
                alignment: Alignment.center,
                child: const Text(
                  "GET STARTED NOW",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
   
    );
  }

  buildIndicator({bool active = false}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 5.0,
          height: 5.0,
          decoration:const BoxDecoration(
            color: warmPrimaryColor,
            shape: BoxShape.circle,
          ),
        ),
        Visibility(
          visible: active,
          child: PlayAnimation<double>(
              duration:const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              tween: (0.0).tweenTo(40.0),
              builder: (context, child, value) {
                return Opacity(
                  opacity: value / 40.0,
                  child: Card(
                    child: Container(
                      width: 14.0,
                      height: 14.0,
                      decoration:const BoxDecoration(shape: BoxShape.circle),
                    ),
                    elevation: value,
                    shadowColor: white,
                    shape:const CircleBorder(),
                  ),
                );
              }),
        ),

       
      ],
    );
  }

  onBoardingWidget({iconPath = "", title = "", desc = ""}) {
    return 
    Container(
      alignment: Alignment.center,
      child: Column(children: [
      const  Expanded(child: SizedBox()),
        Container(
          width: 360.0,
          alignment: Alignment.center,
          height: 150.0,
          child: Image.asset(iconPath, fit: BoxFit.cover),
        ),
        Container(
          width: _w,
          padding:const EdgeInsets.symmetric(horizontal: 20.0),
          margin:const EdgeInsets.only(bottom: 40.0, top: 40.0),
          child: Text(title,
              textAlign: TextAlign.center,
              style:const TextStyle(
                  color: true ? primaryColor :warmPrimaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ),
        Container(
            width: 360,
            padding:const EdgeInsets.symmetric(horizontal: 20.0),
            margin: EdgeInsets.only(bottom: _h * 0.4),
            child: Text(desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: warmPrimaryColor.withOpacity(0.9), fontSize: 13.0))),
      ]),
    );
  
  }


}
