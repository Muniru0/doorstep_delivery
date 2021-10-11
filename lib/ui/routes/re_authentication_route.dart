import 'package:doorstep_delivery/constants.dart';
import 'package:doorstep_delivery/model_registry.dart';
import 'package:doorstep_delivery/services/data_models/user_data_model.dart';
import 'package:doorstep_delivery/services/models/auth_model.dart';
import 'package:doorstep_delivery/services/models/courier_company_model.dart';
import 'package:doorstep_delivery/services/models/user_model.dart';
import 'package:doorstep_delivery/services/utils/local_auth.dart';
import 'package:doorstep_delivery/ui/base_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:doorstep_delivery/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_animations/simple_animations.dart';

class ReAuthRoute extends StatefulWidget {

  const ReAuthRoute({Key? key}): super(key: key);
  @override
  _ReAuthRouteState createState() => _ReAuthRouteState();
}

class _ReAuthRouteState extends State<ReAuthRoute> {
 final TextEditingController _passwordController = TextEditingController();

  late double _w;
  late double _h;
  var showPassword = false;
  var showBlurredOverlay = false;
  bool activateSignInButtons = false;
  String storedPassword = "";
  late  OverlayEntry _overlayEntry;
  late MyUser _user;
  late AuthModel _authModel;
  bool _isPasswordValid = false;
  bool _showBlurredOverlay = false;
  late bool overlayLock;
  final CustomAnimationControl _animControl = CustomAnimationControl.play;
  
  late bool isLoading;

  registerChoice() {
    setState(() {
      showBlurredOverlay = false;
    });
    _overlayEntry.remove();
  }

  @override
  initState() {
    super.initState();

    _user = register<UserModel>().getUser;
    _authModel = register<AuthModel>();
    
    
    isLoading = true;
    overlayLock = false;
    
  }


 @override
  void dispose() {
   _passwordController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;

    return BaseView<UserModel>(
      isBlankBaseRoute: true,
      child:Container(
              padding: EdgeInsets.only(top: _h * 0.07, left: 20.0, right: 20.0),
              child: Column(
                children: [

                  PlayAnimation<double>(
                    tween: Tween(begin: 0.0,end: 1.0),
                    duration:const Duration(seconds: 1),
                    curve: Curves.bounceInOut,
                    builder: (context, child,value) {
                      return Container(
                        width: _w,
                        margin:const EdgeInsets.only(left: 15.0),
                        child: RichText(text:  TextSpan(
                          children: [
                            TextSpan(
                              text: 'Doorstep',
                              style: TextStyle(color: brightMainColor,fontSize: 30.0 * value,fontWeight: FontWeight.bold)
                            ),
                             TextSpan(
                              text: '\n \t\t\t\t\t\t\t\t Delivery',
                              style: TextStyle(color: black,fontSize: 25.0 * value,fontWeight: FontWeight.bold)
                            ),
                          ]
                        )),
                      );
                    }
                  ),


                  // Container(
                  // margin: EdgeInsets.only(top: _h * 0.1),
                  // child: Icon(MaterialIcons.delivery_dining,
                  //  color: Colors.black.withOpacity(0.2),
                  //   size: 70.0 ),
                  // ),

                    Container(
                  margin: EdgeInsets.only(top: _h * 0.1),
                  padding:const EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFC0C0C0).withOpacity(0.5),
                  ),
                  child:const Icon(MaterialIcons.delivery_dining,
                   color: black ,
                    size: 70.0 ),
                  ),

                  Container(
                    width: _w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: _h * 0.02),
                    child:const Text("Welcome Back", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0))
                  ),
                  


                  
                  Container(
                    margin:const EdgeInsets.only(bottom: 10.0),
                    child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                      var firstName = "";
                      if (_user.fullname != null) {
                        if (_user.fullname!.contains(" ")) {
                          var splitName =
                              _user.fullname!.split(" ");
                          firstName = splitName[0];
                        }
                      }

                      return
                       Container(
                    width: _w,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10.0, bottom:15.0),
                    child: Text(firstName, style:const TextStyle(
                                color: warmPrimaryColor,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold)
                    )
                  );
                
                    }),
                  ),
                  Container(
                      margin:const EdgeInsets.only(bottom: 25.0),
                      child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                          return Text(
                            "${_user.phoneNumber.substring(0, 3)}-${_user.phoneNumber.substring(3, 6)}-${_user.phoneNumber.substring(6, 10)}",
                            style:const TextStyle(color: Color(0xFFcdcece), fontSize: 14.0) );
                      })),
               
               
                  Container(
                    child: UtilityWidgets.broadCustomTextField(
                      _passwordController,
                      obscureText: true,
                      onChanged: (String password) {
                        if (
                            password.length >= 8) {
                          if (_isPasswordValid == true) return;
                          setState(() => _isPasswordValid = true);
                        } else {
                          if (!_isPasswordValid) return;
                          setState(() => _isPasswordValid = false);
                        }
                      },
                      hint: "password must be atleast 8 characters",
                      symbol: "",
                    ),
                  ),
                 
                  Container(
                      margin:const EdgeInsets.only(bottom: 30.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Constants.FORGOT_PASSWORD_ROUTE);
                          },
                          child:const Text("forgot Password",
                              style: TextStyle(
                                  color: goldColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.underline)))),
                  Container(
                      margin:const EdgeInsets.only(bottom: 10.0),
                      child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                        return UtilityWidgets.customConfirmationButton(context,
                            () async {
                          if (!_isPasswordValid) return;
                          UtilityWidgets.transactionProcessingDialog(context,
                              title: "Signing In");
                             
                       
                          var res = await _authModel.reauthenticateUserWithPassword(_user.email,_passwordController.text,_user.userRole,companyDocID:register<CompanyModel>().getCompany.companyFirestoreID);
                         
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }

                         if(res['result']){
       
                    
                    if(res['data'] == null){
                      
                              Navigator.pushNamedAndRemoveUntil(context, Constants.WAITING_DIRECTOR_AUTHORIZATION_ROUTE, (route) => false);
                              return;
                    }

                        Navigator.pushNamedAndRemoveUntil(context, Constants.HOME_ROUTE, (route) => false);
   

         }
    
      UtilityWidgets.requestErrorDialog(context,title: 'Sign-In ',desc: res['desc'],cancelAction: (){
        Navigator.pop(context);
      });

           
                        },
                            confirmationText: "SIGN IN",
                            isLong: true,
                            isDisabled: !_isPasswordValid);
                      })),
                  // Container(
                  //     margin:const EdgeInsets.only(bottom: 25.0),
                  //     child: customConfirmationButton()),
                  Container(
                      margin:const EdgeInsets.only(bottom: 30.0),
                      child: InkWell(
                          onTap: () {
                            if(overlayLock){
                              return;
                            }
                            setState(() => _showBlurredOverlay = true);
                            _overlayEntry = UtilityWidgets.confirmationOverlay(
                                context, _animControl,
                                desc:
                                    "Are you sure you want to SignOut Completely ?\n\t\t This will make your next login lasts longer  than usual.",
                                confirmAction: () async {
                              setState((){
                                 _showBlurredOverlay = false;
                                 overlayLock = false;
                                 });
                              _overlayEntry.remove();
                              UtilityWidgets.requestProcessingDialog(context,
                                  title: "Signing Out...");
                              await Future.delayed(const Duration(seconds: 1));
                            var res =   await _authModel.signOutCompletely();
                             if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            if(!res['result']){
                          
                              UtilityWidgets.requestErrorDialog(context,title:'Sign-out',desc:res['desc'],cancelAction: (){
                                Navigator.pop(context);
                              });
                              return;
                            }
                             
                             Future.delayed(const Duration(seconds: 2));
                                Navigator.pushNamedAndRemoveUntil(context,
                                    Constants.LOGIN_ROUTE, (route) => false);
                            
                            }, cancelAction: () {
                              removeOverlay();
                            },
                                confirmationText: "SIGN OUT",
                                cancelText: "CANCEL");

                            Overlay.of(context)!.insert(_overlayEntry);
                            setState(() {
                              overlayLock = true;
                            });
                          },
                          child:const Text("Sign Out",
                              style: TextStyle(
                                  color: goldColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.underline)))),
                
               const Expanded(child: SizedBox()),
                UtilityWidgets.copyrightWidget(_w)
                
                ],
              ),
            ),
    );
  }

  fadedCustomTextField() {
    return Container(
      padding:const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      //   margin: EdgeInsets.only(bottom: 15.0 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border:
            Border.all(width: 0.5, color:const Color(0xFF182e65).withOpacity(0.2)),
      ),
      child: Row(children: [
        Container(
          width: 250,
          padding: const EdgeInsets.only(right: 15.0),
          margin:const EdgeInsets.only(left: 25.0),
          child: TextField(
            keyboardType: TextInputType.phone,
            controller: _passwordController,
            obscureText: !showPassword,

            textAlign: TextAlign.center,
            style:const TextStyle(
              color:  warmPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 19.0,
            ),
            autofocus: true,
            //cursorColor: Color(0xFF636B85),
            cursorColor: warmPrimaryColor,
            decoration: const InputDecoration.collapsed(
              hintText: "Enter your password",
              hintStyle: TextStyle(
                color: Color(0xFFd7e0ef),
                fontSize: 13,
              ),
            ),
            onChanged: (String password) {
              if (password.length >= 8) {
                if (activateSignInButtons) return;
                setState(() {
                  activateSignInButtons = true;
                });
              } else {
                if (!activateSignInButtons) return;

                setState(() {
                  activateSignInButtons = false;
                });
              }
            },
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          child:
             Icon(Feather.eye,
                color: !showPassword
                    ? const Color(0xFF182e65).withOpacity(0.2)
                    : goldColor,
                size: 17),
          
        ),
      ]),
    );
  }

  customConfirmationButton() {
    return InkWell(
      onTap: () async {
        var res = await requestLocalAuth(msg: "Scan to unlock your account.");
       
        if (!res["result"] ) {
          if(res['desc'].isEmpty){
            return;
          }
          UtilityWidgets.requestErrorDialog(context,
              title: "Biometrics", desc: res["desc"], cancelAction: () {
            Navigator.pop(context);
          });
          return;
        }
         
        UtilityWidgets.requestProcessingDialog(context, title: "Signing in...");
         res  = await _authModel.reauthenticateWithBiometrics(userRole: _user.userRole,companyDocID: register<CompanyModel>().getCompany.companyFirestoreID);
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
     

      
      if(res['result']){
       
          
          if(res['data'] == null){
            
                  Navigator.pushNamedAndRemoveUntil(context, Constants.WAITING_DIRECTOR_AUTHORIZATION_ROUTE, (route) => false);
                  return ;
          }

          Navigator.pushNamedAndRemoveUntil(context, Constants.HOME_ROUTE, (route) => false);
                   
         

      }
    
      UtilityWidgets.requestErrorDialog(context,title: 'Sign-In ',desc: res['desc'],cancelAction: (){
        Navigator.pop(context);
      });
          
      },
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        elevation: 30.0,
        shadowColor:const Color(0xFFFFFFFF),
        child: Container(
          width: _w * 0.92,
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: brightMainColor.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(5.0),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin:const EdgeInsets.only(right: 15.0),
                  child:const Text("Fingerprint",
                      style: TextStyle(
                          color: warmPrimaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.0))),
               Icon(Ionicons.ios_finger_print,
                    color: warmPrimaryColor.withOpacity(0.9)),
              
            ],
          ),
        ),
      ),
    );
  }

  void removeOverlay() {
   
    setState(() {
       _showBlurredOverlay = false;
       overlayLock = false;
    
    });
    _overlayEntry.remove();
  }


}
