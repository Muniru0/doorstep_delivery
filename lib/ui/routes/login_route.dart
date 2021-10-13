
import 'package:doorstep_delivery/constants.dart';
import 'package:doorstep_delivery/model_registry.dart';
import 'package:doorstep_delivery/services/models/auth_model.dart';
import 'package:doorstep_delivery/services/models/courier_company_model.dart';
import 'package:doorstep_delivery/services/models/user_model.dart';
import 'package:doorstep_delivery/ui/base_route.dart';
import 'package:doorstep_delivery/ui/routes/home_route.dart';
import 'package:doorstep_delivery/ui/routes/signup_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:doorstep_delivery/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:validators/validators.dart';


class LoginRoute extends StatefulWidget {

  final bool fromOnBoardingRoute;
  const LoginRoute({this.fromOnBoardingRoute = false,Key? key}) : super(key: key);

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  double? _w;
  double? _h;

  bool? emailFieldActive;

  TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    FocusNode emailFocusNode = FocusNode();
    FocusNode passwordFocusNode = FocusNode();

  CustomAnimationControl emailAnimationControl = CustomAnimationControl.play;
  CustomAnimationControl passwordAnimationControl = CustomAnimationControl.playReverseFromEnd;

  String? _emailErrorText;

  String? _passwordErrorText;
  late AuthModel _authModel;
  late UserModel _userModel;
  late CompanyModel _companyModel;
  
  @override
  void initState() {
    
    super.initState();
    emailFieldActive = true;
    _emailErrorText ='';
    _passwordErrorText = '';
    _authModel = register<AuthModel>();
    _userModel = register<UserModel>();
    _companyModel = register<CompanyModel>();
    handleInputFieldsFocus();

  }

  void handleInputFieldsFocus(){
      emailFocusNode.addListener(() { 
        setState(() {

        
      if(emailFocusNode.hasFocus){
       emailAnimationControl = CustomAnimationControl.play;
      } else{
        emailAnimationControl = CustomAnimationControl.playReverseFromEnd;
      }
     });

    });

     passwordFocusNode.addListener(() { 
       setState((){
        if(passwordFocusNode.hasFocus){
         passwordAnimationControl = CustomAnimationControl.play;
       }else{
        passwordAnimationControl = CustomAnimationControl.playReverseFromEnd;
      }
       });
    });
  
  }
  
  
  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return  
      BaseView<AuthModel>(
        isBlankBaseRoute: true,
              child: SizedBox(
        width: _w,
        height: _h,

        child: ListView(
                shrinkWrap: true,
                children: [
                InkWell(onTap: (){
                        if(Navigator.canPop(context)){
              Navigator.pop(context);
                        }
                    
                     
                      },
                          child: Container(
                          width: _w,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: _h! * 0.05,left: 20.0),
                      
                        child:const Icon(Ionicons.ios_arrow_back,
                         color: goldColor,
                          size: 17.0 ),
                        ),
                      ),
              

                  Container(
                  margin: EdgeInsets.only(top: _h! * 0.03),
                  padding:const EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFC0C0C0).withOpacity(0.5),
                  ),
                  child: Icon(AntDesign.user,
                   color: Colors.black.withOpacity(0.2),
                    size: 70.0 ),
                  ),

                  Container(
                    width: _w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: _h! * 0.02),
                    child: Text("Welcome", style: GoogleFonts.montserrat(textStyle:const TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)))
                  ),
                  Container(
                    width: _w,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10.0, bottom:65.0),
                    child: const Text("Sign to Continue", style: TextStyle(color: Color(0xFFcdcece), fontSize: 14.0))
                  ),

          CustomAnimation<double>(
                        duration:const Duration(milliseconds: 500),
                        tween: Tween(begin: 0.0,end: 1.0),
                        curve: Curves.easeInOut,
                        control: emailAnimationControl,
                        builder: (context, snapshot,animValue) {
                          return Container(
               height: 60.0,
               width: _w,

                  padding:const EdgeInsets.symmetric(horizontal: 30.0),
                    decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Material(
                          elevation: animValue * 20  ,
                          shadowColor: Colors.white,
                     borderRadius: BorderRadius.circular(7.0),
                          child: Container(
                            padding:const EdgeInsets.all(7.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:const EdgeInsets.only(left: 20.0,bottom: 5.0),
                                  child:const Text('EMAIL', style: TextStyle(color: black,fontWeight: FontWeight.bold, fontSize: 12.0)),
                                ),

                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 7.0),
                                      child:const Icon(Feather.mail, color: brightMainColor,size: 14.0),
                                    ),

                                      Container(
                                  width: _w! * 0.7,
                                   padding:const EdgeInsets.only(right: 15.0), child: TextField(
                                    keyboardType: TextInputType.name ,
                                    controller: emailController,
                                   focusNode: emailFocusNode,
                                   textAlign: TextAlign.start,
                                   autofocus: true,
                                   
                                    style:const TextStyle(
                                      color: black,
                                      fontSize: 14.0,
                                      fontWeight : FontWeight.bold,
                                    ),
                                   cursorColor: warmPrimaryColor,
                                    decoration:const InputDecoration.collapsed(
                                      hintText: 'email',
                                      hintStyle: TextStyle(
                                        color: silverColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                    onChanged: (String fullname){

                                    },
                                  ),
                                ),
              
                                  ],
                                ),
                              ],
                            ),
                          ),
                    )
                  );
                        }
                      ),

                      Container(
                        margin:const EdgeInsets.only(left: 10.0),
                        child: Text(_emailErrorText!, style:const TextStyle(color: errorColor, fontSize: 15.0))
                      ),
       
                 
              CustomAnimation<double>(
                        duration:const Duration(milliseconds: 500),
                        tween: Tween(begin: 0.0,end: 1.0),
                        curve: Curves.easeInOut,
                        control: passwordAnimationControl,
                        builder: (context, snapshot,animValue) {
                          return Container(
               height: 60.0,
               width: _w,
                  margin: const EdgeInsets.only(top: 40.0),
                  padding:const EdgeInsets.symmetric(horizontal: 30.0),
                    decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Material(
                          elevation: animValue * 20  ,
                          shadowColor: Colors.white,
                     borderRadius: BorderRadius.circular(7.0),
                          child: Container(
                            padding:const EdgeInsets.all(7.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:const EdgeInsets.only(left: 20.0,bottom: 5.0),
                                  child:const Text('PASSWORD', style: TextStyle(color: black,fontWeight: FontWeight.bold, fontSize: 12.0)),
                                ),

                                Row(
                                  children: [
                                    Container(
                                      margin:const EdgeInsets.only(right: 7.0),
                                      child:const Icon(Feather.lock, color:brightMainColor,size: 14.0),
                                    ),

                                      Container(
                                  width: _w! * 0.7,
                                   padding:const EdgeInsets.only(right: 15.0), child: TextField(
                                    keyboardType: TextInputType.name ,
                                    controller: passwordController,
                                   focusNode: passwordFocusNode,
                                   textAlign: TextAlign.start,
                                 
                                   obscureText: true,
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 14.0,
                                      fontWeight : FontWeight.bold,
                                    ),
                                   cursorColor: warmPrimaryColor,
                                    decoration:const InputDecoration.collapsed(
                                      hintText: 'password',
                                      hintStyle: TextStyle(
                                        color: silverColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                    onChanged: (String fullname){

                                    },
                                  ),
                                ),
              

                                  ],
                                ),
                              ],
                            ),
                          ),
                    )
                  );
                        }
                      ),
              Container(
                        margin:const EdgeInsets.only(left: 10.0,bottom: 20.0),
                        child: Text(_passwordErrorText!, style: const TextStyle(color: errorColor, fontSize: 15.0))
                      ),

              

                 InkWell(
                   onTap: (){
                     Navigator.pushNamed(context, Constants.FORGOT_PASSWORD_ROUTE);
                   },child: Container(margin: EdgeInsets.only(top:5.0,left: _w! * 0.6),alignment: Alignment.centerLeft , child: const Text('Forgot Password?', style: TextStyle(color:brightMainColor, fontSize: 14.0)))),

                 Container(
                   margin: EdgeInsets.only(top:_w! * 0.09),
                   padding: EdgeInsets.only(left: _w! * 0.6,right: 20.0,),
                   child: Material(
                           borderRadius: BorderRadius.circular(25.0),
                           shadowColor:const Color(0xFFf7c357),
                            elevation: 10.0,
                           child:
                  
                      InkWell(
                       onTap: ()async{
                   
                             if(!validateInputFields()){return;}
                   
                             UtilityWidgets.requestProcessingDialog(context,title: 'Signing...');
                           
                           Map _authResult = await  _authModel.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim(),);
                                 
                             
                                 
                             Navigator.pop(context);
                             
                               // if there was a success response
                             if(_authResult['result']){
                   
                               // check if the user obj is not null,
                               // then refresh the user and company models
                               if(_authResult['user_obj'] != null){
                   
                   
                           // refresh the user model before                
                           _userModel.refreshUserModel(user:_authResult['user_obj'] );
                             
                             // if the user has not yet verified his phone let him verify it. 
                             if(!_authResult['phone_verification']){
                          Map<String,dynamic> res = await  _authModel.sendOTPCode(phoneNumber: _userModel.getUser.phoneNumber) ;
                        if(!res['result']){
                        UtilityWidgets.requestErrorDialog(context,title: 'Sending Code',desc: res['desc'],cancelAction: (){
                          Navigator.pop(context);
                        } );
                   
                      Navigator.pushNamed(context, Constants.OTP_VERIFICATION_ROUTE);
                      return;
                        }
                                 
                                }
                                  
                            // update the company model
                           if(_authResult['company_obj'] != null){
                           
                                   _companyModel.refreshCompanyModel(company: _authResult['company_obj']);
                        Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => HomeRoute()), (route) => false);
                              return;
                              
                         
                   
                                  }
                                  // send them to the appropriate screen if they dont have a company yet.
                     else{
                   
                                  var route = Constants.UNKNOWN_ROUTE;
                                     // send the user to the appropriate screen 
                              // depending on their roles 
                              if(_userModel.getUser.userRole == Constants.COURIER_SERVICE_DIRECTOR_ROLE ){
                               route = Constants.WELCOME_ROUTE;
                              }else {
                              route =  Constants.WAITING_DIRECTOR_AUTHORIZATION_ROUTE;
                   
                                     }
                                
                                Navigator.pushNamed(context,route);
                                return;
                              }
                        }
                        
                        return;
                        }
                       
                        UtilityWidgets.requestErrorDialog(context,title: 'Sign-In',desc: _authResult['desc'], cancelAction: (){
                          Navigator.pop(context);
                        },cancelText: 'Ok');
                   
                              },
                       child:
                                Container(
                                 width: 130,
                                 height:50 ,
                                 alignment: Alignment.center,
                                 padding:const EdgeInsets.symmetric(vertical: 10.0,horizontal: 8.0),
                                 decoration: BoxDecoration(
                                   border: Border.all(width: 1.0,color:const Color(0xFFf7c357)),
                                   borderRadius:  BorderRadius.circular(25),
                                   gradient:const LinearGradient(
                      colors: [Color(0xFFf7c357),Color(0xFFfea23c)],
                      stops: [0.1,0.9],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                                   ),
                                 ),
                                 child: SizedBox(
                                   width: 130.0,
                                   height: 50.0,
                                   child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text( 'Login',style:  TextStyle(color: white,fontSize: 12.5,fontWeight: FontWeight.bold)),
                        const  SizedBox(width: 10.0),
                       MirrorAnimation<double>(
                        tween: Tween(begin: 0.0,end:10.0),
                        duration:const Duration(seconds: 1),
                        curve: Curves.easeInOut,
                         builder: (context, child,value) {
                           return Transform.translate(offset: Offset(value,0.0),child: const Icon(Feather.arrow_right,color: white,size: 15.0,));
                         }
                       ),
                      ],
                                   ),
                                 ),
                               ),
                            
                   
                     ),
                   
                                
                 
                   ),
                 ), 
        
      
                 const  SizedBox(height: 80.0,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          const  Text("Don't have account?",  style: TextStyle(
                        color: Color(0xFF898989) ,
                        fontSize: 14.0,
                      ),
                  ),
                  
                  InkWell(onTap: (){
                  
                    if(Navigator.canPop(context)){
                      if(widget.fromOnBoardingRoute){
                         Navigator.pushNamed(context, Constants.SIGNUP_ROUTE);
                         return;
                      }
                           Navigator.pop(context);
                    }else{
                   Navigator.push(context, CupertinoPageRoute(builder:(context)=> const SignUpRoute()));
                    }
                 
                  
                  },child:const Text(" Sign up", style: TextStyle(color: brightMainColor, fontSize: 14.0),)),
                ],
              ),






             const SizedBox(height: 150.0),

                ],
              ),
            
              
         
          
        ),
      )
      
    ;

  }

dynamic validateInputFields(){

        _emailErrorText = '';
        _passwordErrorText = '';
        if(!isEmail(emailController.text)){
        
          _emailErrorText = 'Please provide a valid email.';
        }

        if(!isLength(passwordController.text, 8)){
       
          _passwordErrorText = 'Please password must be atleast 8 characters long.';
        }

        if(_emailErrorText!.isNotEmpty || _passwordErrorText!.isNotEmpty){
       
            setState((){});
          return false;
        }

      

        return true;
}
Widget inputField({icon, title = '',hint = '',positionedHeight = 0.45, textFieldController, isActive = false,focusNode}){
  return   
  Positioned(
           top: _h! * positionedHeight  ,
                    child: CustomAnimation<double>(
                      duration:const Duration(milliseconds: 500),
                      tween: Tween(begin: 0.0,end: 1.0),
                      curve: Curves.easeInOut,
                      control: isActive ? CustomAnimationControl.play : CustomAnimationControl.playReverseFromEnd ,
                      builder: (context, snapshot,animValue) {
                    return Container(
                    height: 60.0,
                    width: _w,
                    padding:const EdgeInsets.symmetric(horizontal: 30.0),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Material(
                        elevation: animValue * 20  ,
                        shadowColor: Colors.white,
                   borderRadius: BorderRadius.circular(7.0),
                        child: Container(
                          padding:const EdgeInsets.all(7.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:const EdgeInsets.only(left: 20.0,bottom: 5.0),
                                child: Text(title, style:const TextStyle(color: Color(0xFFb1b6bb),fontWeight: FontWeight.bold, fontSize: 12.0)),
                              ),

                              Row(
                                children: [
                                  Container(
                                    margin:const EdgeInsets.only(right: 7.0),
                                    child:const Icon(Feather.mail, color: Color(0xFF02ba76),size: 14.0),
                                  ),

                                    Container(
                                width: _w! * 0.7,
                                 padding:const EdgeInsets.only(right: 15.0), child: TextField(
                                  keyboardType: TextInputType.name ,
                                  controller: textFieldController,
                                 focusNode: focusNode,
                                 textAlign: TextAlign.start,
                                 autofocus: hint == 'email',
                                 
                                  style:const TextStyle(
                                    color: black,
                                    fontSize: 12.0,
                                    fontWeight : FontWeight.bold,
                                  ),
                                 cursorColor: warmPrimaryColor,
                                  decoration: InputDecoration.collapsed(
                                    hintText: hint,
                                    hintStyle:const TextStyle(
                                      color: Color(0xFFd7e0ef),
                                      fontSize: 13,
                                    ),
                                  ),
                                  onChanged: (String fullname){

                                  },
                                ),
                              ),
            


                                  // Container(
                                  //   child: Text(hint, style: TextStyle(color: Color(0xFF02ba76) )),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                  )
                );
                      }
                    ),
         );
            
       
}


}











// class LoginRoute extends StatefulWidget{

// @override
//   _LoginRouteState createState() => _LoginRouteState();
// }

// class _LoginRouteState extends State<LoginRoute>{

//   TextEditingController _emailController = TextEditingController();
//   RegExp  alphaNumericFilter = RegExp("r[A-Z/0-9/a-z/@{1}/.]\w+");
//   OverlayEntry _overlayEntry;
//   CustomAnimationControl _animControl = CustomAnimationControl.PLAY;
//   bool _showBlurredOverlay = false;
//   @override
//   Widget build(BuildContext context) {
//     return BaseView<RegistrationModel>(
//      showBlurredOverlay: _showBlurredOverlay,
//      screenTitle : "Register",
//       child:Container(
//        // margin: EdgeInsets.only(top: 30.0),
//         padding: EdgeInsets.only(right: 20.0,left: 20.0,top: 30.0),
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(bottom: 15.0),
//               child: Text("ENTER YOUR PHONE NUMBER", style: TextStyle(fontSize: 22.0, color: warmPrimaryColor,fontWeight: FontWeight.w900,)),
//             ),
//             Container(
//               margin:EdgeInsets.only(bottom: 50.0),
//               width: 180.0,
//               child: Text("Use the phone to register or login to 4pay",textAlign: TextAlign.center, style: TextStyle(color: warmPrimaryColor.withOpacity(0.2),fontSize:12.0,fontWeight: FontWeight.w900, )),
//             ),

//             fadedCustomTextField(_emailController,onChanged:(String email){
//       if(alphaNumericFilter.allMatches(email).length == email.length){

//       }
//             }, hint: "Enter your phone number here", symbol: ""),

//             Container(
//               child: UtilityWidgets.customConfirmationButton(context,(){
//        _overlayEntry = UtilityWidgets.verifyPhonePrompt(context,_overlayEntry,_animControl,cancelOnTap: (){
//          setState((){
//            _showBlurredOverlay = false;
//          });
//         _overlayEntry.remove();
//        }, confirmOnTap: (){
//          setState((){
//            _showBlurredOverlay = false;
//          });
//          _overlayEntry.remove();
//        });

//               },confirmationText: "NEXT",isDisabled: false, isLong: true),
//             ),
//           ],
//         ),
//       ) ,
//     );
//   }

// static fadedCustomTextField(controller, {FocusNode focusNode,void Function (String text) onChanged,isErrorBorder = false,symbol="₵",width = 250.0, marginTop:0.0, marginBottom: 15.0 , hint='', vertPad: 10.0, horizPad: 10.0}){

// return        Container(
//                         padding: EdgeInsets.symmetric(vertical: vertPad,horizontal: horizPad),
//                         margin: EdgeInsets.only(bottom: marginBottom,top: marginTop ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                          border: Border.all(width: 0.5, color:isErrorBorder ? errorColor: Color(0xFF182e65).withOpacity(0.2)),
//                         ),
//                       child: Row(

//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(right: 10.0),
//                           child: Text(symbol, style: TextStyle(color: warmPrimaryColor, fontWeight: FontWeight.bold                                     )),
//                           ),

//                        Container(
//                             width: width,
//                             padding: EdgeInsets.only(right: 15.0), child: TextField(
//                               keyboardType: TextInputType.phone,
//                               controller: controller,
//                              focusNode: focusNode,
//                              textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: warmPrimaryColor,
//                                 fontWeight : FontWeight.bold,
//                               ),
//                               autofocus: true,
//                               //cursorColor: Color(0xFF636B85),
//                               cursorColor: warmPrimaryColor,
//                               decoration: InputDecoration.collapsed(
//                                 hintText: hint,
//                                 hintStyle: TextStyle(
//                                   color: Color(0xFFd7e0ef),
//                                   fontSize: 13,
//                                 ),
//                               ),
//                               onChanged: onChanged,
//                             ),
//                           )

//                         ]
//                       ),

//                         );

//   }

// }


// class LoginRoute extends StatefulWidget {
//   @override
//   _LoginRouteState createState() => _LoginRouteState();
// }

// class _LoginRouteState extends State<LoginRoute> {
//   TextEditingController _textFieldController = TextEditingController();

//   var validationError = "";
//   bool _showBlurredOverlay = false;
//   UserModel _userModel!;
//   bool isPasswordValid = false;
//   TextEditingController _passwordController = TextEditingController();
//   bool _credentialValid = false;

//   @override
//   initState() {
//     super.initState();
//     _userModel! = locator<UserModel>();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BaseView<UserModel>(
//       showBlurredOverlay: _showBlurredOverlay,
//       screenTitle: "Login",
//       showSettingsIcon: false,
//       isBackIconVisible: false,
//       child: Container(
//         // margin: EdgeInsets.only(top: 30.0),
//         padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 30.0),
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(bottom: 15.0),
//               child: Text("ENTER YOUR LOGIN CREDENTIALS",
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     color: warmPrimaryColor,
//                     fontWeight: FontWeight.w900,
//                   )),
//             ),
//             Container(
//               margin: EdgeInsets.only(bottom: 30.0),
//               width: 240.0,
//               child: Text("Use your email to login to 4pay",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: subHeadingsColor,
//                     fontSize: 12.0,
//                     fontWeight: FontWeight.w900,
//                   )),
//             ),
//             UtilityWidgets.broadCustomTextField(_textFieldController,
//                 textAlign: TextAlign.center, onChanged: (String value) {
//               value = value.trim();
//               if (value.isEmpty) {
//                 if (!_credentialValid) return;
//                 setState(() => _credentialValid = false);
//                 return;
//               }

//               // if (filterDigitsOnly(value) && value.length == 10) {
//               //   if (_credentialValid) return;
//               //   print("phone Number is valid");
//               //   setState(() => _credentialValid = true);
//               // } else
//                if (isEmail(value)) {
//                 if (_credentialValid) return;
//                 print("email is valid");
//                 setState(() => _credentialValid = true);
//               } else {
//                 if (!_credentialValid) return;

//                 print("credential not valid");
//                 setState(() => _credentialValid = false);
//               }
//             }, hint: "Enter your Email", symbol: ""),
//             Container(
//                 child: UtilityWidgets.fadedCustomTextField(_passwordController,
//                     obscureText: true, onChanged: (String password) {
//               setState(() {
//                 if (filterDigitsOnly(password) && password.length == 6) {
//                   if (isPasswordValid) return;
//                   print("password");
//                   isPasswordValid = true;
//                 } else {
//                   if (!isPasswordValid) return;
//                   print("password is invalid.");
//                   isPasswordValid = false;
//                 }
//               });
//             },
//                     hint: "Enter password",
//                     symbol: "",
//                     vertPad: 13.0,
//                     horizPad: 13.0)),
//             Container(
//               margin: EdgeInsets.only(top: 10.0),
//               child: UtilityWidgets.customConfirmationButton(context, () async {
//                 // if (filterDigitsOnly(_textFieldController.text.trim())) {
//                 //   if (_textFieldController.text.trim().length != 10) {
//                 //     if (validationError == "Invalid phone Number length.")
//                 //       return;
//                 //     setState(
//                 //         () => validationError = "Invalid phone Number length.");
//                 //   } else {
//                 //     if (validationError.isEmpty) return;
//                 //     setState(() => validationError = "");
//                 //   }
//                 // } else
//                  if (filterEmail(_textFieldController.text.trim())) {
//                   if (_textFieldController.text.trim().length != 10) {
//                     if (validationError == "Invalid email  length.") return;
//                     setState(() => validationError = "Invalid email length.");
//                   } else {
//                     if (validationError.isEmpty) return;
//                     setState(() => validationError = "");
//                   }
//                 }

//                 if (!_credentialValid) return;
//                 UtilityWidgets.requestProcessingDialog(context,
//                   );
//                 var res;
//                 if (isEmail(_textFieldController.text.trim())) {
//                   res = await _userModel!.signInWithEmailAndPassword(
//                       email: _textFieldController.text.trim(),
//                       password: _passwordController.text.trim());
//                 }else{
//                   return;
//                 }
                
                 
//                 if (Navigator.canPop(context)) {
//                   Navigator.pop(context);
//                 }
//                 if (!res["result"]) {
//                   UtilityWidgets.requestErrorDialog(context,
//                       title: "SignIn", desc: res["desc"], cancelAction: () {
//                     Navigator.pop(context);
//                   });
//                   return;
//                 }

//                 Navigator.pushNamedAndRemoveUntil(
//                     context, Constants.HOME_ROUTE, (route) => false);
//               },
//                   confirmationText: "LOGIN",
//                   isLong: true,
//                   isDisabled: !(_credentialValid && isPasswordValid)),
//             ),
//             Container(
//                 margin: EdgeInsets.only(top: 30.0),
//                 child: InkWell(
//                     onTap: () {
//                       if (Navigator.canPop(context)) {
//                         Navigator.pop(context);
//                       } else {
//                         Navigator.pushNamed(
//                             context, Constants.REGISTRATION_ROUTE);
//                       }
//                     },
//                     child: Navigator.canPop(context)
//                         ? Text(" Back",
//                             style: TextStyle(
//                                 color: goldColor,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w900,
//                                 decoration: TextDecoration.underline))
//                         : Text("Register",
//                             style: TextStyle(
//                                 color: goldColor,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w900,
//                                 decoration: TextDecoration.underline)))),
//           ],
//         ),
//       ),
//     );
//   }

//   static fadedCustomTextField(controller,
//       {FocusNode focusNode,
//       void Function(String text) onChanged,
//       isErrorBorder = false,
//       symbol = "₵",
//       width = 250.0,
//       marginTop: 0.0,
//       marginBottom: 15.0,
//       hint = '',
//       vertPad: 10.0,
//       horizPad: 10.0}) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: vertPad, horizontal: horizPad),
//       margin: EdgeInsets.only(bottom: marginBottom, top: marginTop),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         border: Border.all(
//             width: 0.5,
//             color: isErrorBorder
//                 ? errorColor
//                 : Color(0xFF182e65).withOpacity(0.2)),
//       ),
//       child: Row(children: [
//         Container(
//           width: width,
//           // padding: EdgeInsets.only(right: 15.0)

//           // ,
//           child: TextField(
//             keyboardType: TextInputType.phone,
//             controller: controller,
//             focusNode: focusNode,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: warmPrimaryColor,
//               fontWeight: FontWeight.bold,
//             ),
//             autofocus: true,
//             //cursorColor: Color(0xFF636B85),
//             cursorColor: warmPrimaryColor,
//             decoration: InputDecoration.collapsed(
//               hintText: hint,
//               hintStyle: TextStyle(
//                 color: Color(0xFFd7e0ef),
//                 fontSize: 13,
//               ),
//             ),
//             onChanged: onChanged,
//           ),
//         )
//       ]),
//     );
//   }
// }


