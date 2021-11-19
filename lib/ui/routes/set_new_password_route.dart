

import 'package:doorstep_delivery/constants/constants.dart';
import 'package:doorstep_delivery/model_registry.dart';
import 'package:doorstep_delivery/services/models/auth_model.dart';
import 'package:doorstep_delivery/services/models/courier_company_model.dart';
import 'package:doorstep_delivery/services/models/user_model.dart';
import 'package:doorstep_delivery/ui/base_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:doorstep_delivery/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:validators/validators.dart';


class SetNewPasswordRoute extends StatefulWidget {

    const SetNewPasswordRoute({Key? key}) : super(key: key);

  @override
  _SetNewPasswordRouteState createState() => _SetNewPasswordRouteState();

}

class _SetNewPasswordRouteState extends State<SetNewPasswordRoute> {
 


  bool confirmButtonActivation = false;
  late AuthModel _authModel;
  late UserModel _userModel;
  late String phoneNumber;


  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  late bool activateSignInButtons ;
  late bool _passwordVisibility;
  late bool _confirmPasswordVisibility;

  late String validationError;


 @override 
 initState(){
   super.initState();
   _authModel = register<AuthModel>();
   _userModel = register<UserModel>();
    activateSignInButtons = false;
    _passwordVisibility = false;
    _confirmPasswordVisibility = false;
    validationError = '';
    phoneNumber = 'Phone unavailable';
   
   if(_userModel.getUser.phoneNumber.isNotEmpty){
   phoneNumber = formatPhoneNumber(_userModel.getUser.phoneNumber);
   }
    
   
 }

 @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
 
    
    return BaseView<AuthModel>(
     
      isBlankBaseRoute: true,
      child: Container(
      
        padding: const EdgeInsets.only(top: 30.0, left: 20.0,right: 20.0),
        margin: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
         Container(
           margin:const EdgeInsets.only(bottom: 10.0),
           child:Text("Set New Password", style: TextStyle(color: warmPrimaryColor,fontSize: headingsSize, fontWeight: FontWeight.bold)
         ),
         ),
   Container(
     margin:const EdgeInsets.only(bottom:30.0),
     width: 220.0,
     child: 
         RichText(
           textAlign: TextAlign.center,
           
           text: TextSpan(
             text : "A verification code has been sent to ", 
            style:TextStyle(height: 1.5,color: subHeadingsColor, fontSize: subHeadingsSize, ),
            children: [
              TextSpan(
                text: phoneNumber,
                 style:TextStyle(fontWeight: FontWeight.bold,color: warmPrimaryColor, fontSize: subHeadingsSize )
              ),
            ]
           ),
         ),
      
   

   ),
   SizedBox(
     height: 15.0,
     child: Text(validationError,style:const TextStyle(color:errorColor,fontSize: 12,fontWeight: FontWeight.bold)),
   ),
    ScopedModelDescendant<AuthModel>(
    
      builder: (context, child,model) {
        return Text(model.getOtpTimer == '00:01' ? '' : model.getOtpTimer, style:const TextStyle(color:warmPrimaryColor, fontSize: 13.0, fontWeight: FontWeight.bold)); 
        
      }
    ),
   Container(
     margin: const EdgeInsets.only(bottom: 15.0),
     child: UtilityWidgets.fadedCustomTextField(_otpController,onChanged:(String otpCode){

    
      if(isNumeric(otpCode)){
        setState((){
          confirmButtonActivation = true;
        });
      }else{
        if(confirmButtonActivation){
        setState((){
          confirmButtonActivation = false;
        });
        }
      }

     },hint: "Enter the verification code", symbol: "")
   ),
  Container(
         margin:const EdgeInsets.only(bottom: 20.0),
         child:
          
          UtilityWidgets.broadCustomTextField(_passwordController,symbol: '',hint: "New password", obscureText: !_passwordVisibility,enableTrailingIcon: true,iconAction: (){
            setState(() {
                _passwordVisibility = !_passwordVisibility;
            });
          },trailingIcon: !_passwordVisibility ? Feather.eye_off : Feather.eye,onChanged: (String passwordCredential){
           

           


          },),
   ),
  
      Container(
         margin:const EdgeInsets.only(bottom: 20.0),
         child:
          
          UtilityWidgets.broadCustomTextField(_confirmPasswordController,symbol: '',hint: "Confirm password",obscureText: !_confirmPasswordVisibility,enableTrailingIcon: true,iconAction: (){
            setState(() {
              _confirmPasswordVisibility = !_confirmPasswordVisibility;
            });
          },trailingIcon: !_confirmPasswordVisibility ? Feather.eye_off : Feather.eye, onChanged: (String confirmPassword){
                       
              
                 },),
   ),
  
  
  
   Container(
     margin:const EdgeInsets.only(bottom: 30.0),
     child: UtilityWidgets.customConfirmationButton(
       context,()async{

             if(_otpController.text.trim().length != 6){
               setState(() {
                 validationError  = 'Invalid verification code';
               });
               return;
             }
            if(_passwordController.text.trim() != _confirmPasswordController.text.trim() ){

                  setState(() {
                  validationError = 'Password and confirm password not the same.';
                });
              return; 
            } 

              if( _passwordController.text.trim().length < 8 ){
                setState(() {
                  validationError = 'Password invalid.(must be atleast eight characters)';
                });
              return; 
              }

            UtilityWidgets.requestProcessingDialog(context);
         var res = await _authModel.updateUserPassword(phoneNumber:_userModel.getUser.phoneNumber.trim(),code:_otpController.text.trim(),firebaseUid: _userModel.getUser.firebaseUid,newPassword:_passwordController.text.trim());
         
         
           if(Navigator.canPop(context)){
              Navigator.pop(context);
           }
           if(!res!["result"]){
                 UtilityWidgets.requestErrorDialog(context, title: "Password Update ",desc: res['desc'],cancelAction: (){
                      if(Navigator.canPop(context)){
                            Navigator.pop(context);
                        }
                 });

                return;
           }


    
          Navigator.pushNamedAndRemoveUntil(context, Constants.PASSWORD_UPDATED_SUCCESSFULLY_ROUTE, (route) => false);
                          

          
          },confirmationText: "Update Password", isLong: true, 
     )
   ),
   InkWell(
     splashColor: Colors.grey.withOpacity(0.09),
     onTap: ()async{

          if(!isNumeric(_userModel.getUser.phoneNumber) || !isLength(_userModel.getUser.phoneNumber,10)){

              UtilityWidgets.requestErrorDialog(context,title: 'Invalid phone number.',cancelAction: (){
                Navigator.pop(context);
              });
              return;
          }
       
        UtilityWidgets.requestProcessingDialog(context,title: 'Sending OTP Code');

       
         var res = await _authModel.sendCodeToRestPassword(phoneNumber:_userModel.getUser.phoneNumber);
        
           if(Navigator.canPop(context)){
              Navigator.pop(context);
           }
           if(!res["result"]){
                 UtilityWidgets.requestErrorDialog(context, title: "Sending OTP",desc: res['desc'],cancelAction: (){
                  
                   Navigator.pop(context);


                 });

                return;
           }
     },
        child: 
        const Text("Send OTP Again", style: TextStyle(color: goldColor,fontSize: 13, fontWeight: FontWeight.w900,decoration: TextDecoration.underline)),
   ),

          
                   
                          ],),
                        ),
                      );
                    }
                  
                    void removeTextFieldFocus(){
                       if(FocusScope.of(context).hasFocus){
                          FocusScope.of(context).unfocus();
                       }
                    }
                  
String formatPhoneNumber(String phoneNumber) {
   
    if(!isLength(phoneNumber,10)){
    return phoneNumber;
   }

   var firstPart = phoneNumber.substring(0,3);
   var secondPart = phoneNumber.substring(3,6);
   var thirdPart = phoneNumber.substring(6,10);
   return "$firstPart-$secondPart-$thirdPart";
}
}

