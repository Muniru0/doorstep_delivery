
import 'package:doorstep_delivery/constants.dart';
import 'package:doorstep_delivery/model_registry.dart';
import 'package:doorstep_delivery/services/models/auth_model.dart';
import 'package:doorstep_delivery/services/models/courier_company_model.dart';
import 'package:doorstep_delivery/services/models/user_model.dart';
import 'package:doorstep_delivery/ui/base_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:doorstep_delivery/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:validators/validators.dart';


class OTPVerificationRoute extends StatefulWidget {

  final bool hasCustomerAfterVerificationAction;
  final VoidCallback? customerAfterVerificationAction;
  const OTPVerificationRoute({this.hasCustomerAfterVerificationAction = false, this.customerAfterVerificationAction,Key? key}) : super(key: key);
  
 
  @override
  _OTPVerificationRouteState createState() => _OTPVerificationRouteState();
}

class _OTPVerificationRouteState extends State<OTPVerificationRoute> {
 
final TextEditingController _otpController = TextEditingController();

 bool confirmButtonActivation = false;
 late AuthModel _authModel;
 late UserModel _userModel;
 late String phoneNumber;


 @override 
 initState(){
   super.initState();
   _authModel = register<AuthModel>();
   _userModel = register<UserModel>();
    phoneNumber = 'Phone unavailable';
   
   if(_userModel.getUser.phoneNumber.isNotEmpty){
   phoneNumber = formatPhoneNumber(_userModel.getUser.phoneNumber);
   }
    
   
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
           child:Text("Please verify the OTP code", style: TextStyle(color: warmPrimaryColor,fontSize: headingsSize, fontWeight: FontWeight.bold)
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
    ScopedModelDescendant<AuthModel>(
    
      builder: (context, child,model) {
        return Text(model.getOtpTimer == '00:01' ? '' : model.getOtpTimer, style:const TextStyle(color:warmPrimaryColor, fontSize: 13.0, fontWeight: FontWeight.bold)); 
        
      }
    ),
   Container(
     margin: const EdgeInsets.only(bottom: 15.0),
     child: UtilityWidgets.fadedCustomTextField(_otpController,onChanged:(String otpCode){

    
      if(isNumeric(otpCode) && otpCode.length == 6){
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
     margin:const EdgeInsets.only(bottom: 30.0),
     child: UtilityWidgets.customConfirmationButton(
       context,()async{
             if(_otpController.text.trim().length != 6){
               return;
             }
            UtilityWidgets.requestProcessingDialog(context);
         var res = await _authModel.verifyOTP(phoneNumber:_userModel.getUser.phoneNumber.trim(),otp:_otpController.text.trim(),firebaseUid: _userModel.getUser.firebaseUid,flag: Constants.IS_CUSTOMER_PHONE_VERIFICATION);
         
         
           if(Navigator.canPop(context)){
              Navigator.pop(context);
           }
           if(!res["result"]){
                 UtilityWidgets.requestErrorDialog(context, title: "Verification",desc: res['desc'],cancelAction: (){
                      if(Navigator.canPop(context)){
                            Navigator.pop(context);
                        }
                 });

                return;
           }

           
     
     // automatically send email verification once the otp has being verified
       _authModel.sendEmailVerification();

      String userRole = _userModel.getUser.userRole;


      // link is false then that means the email has already being verified.
        if(userRole == Constants.COURIER_SERVICE_DIRECTOR_ROLE){
            Navigator.pushNamedAndRemoveUntil(context, Constants.WELCOME_ROUTE, (route) => false);
            return;
        }
          UtilityWidgets.transactionProcessingDialog(context,title:'Checking company information');
     res = await register<CompanyModel>().getCompanyStaff(userRole: _userModel.getUser.userRole,firebaseUid: _userModel.getUser.firebaseUid);

        // remove the request processing dialog 
        Navigator.pop(context);

       if(!res['result']){
         UtilityWidgets.requestErrorDialog(context,title:'Request ',desc: 'Error, processing request tap okay to proceed.',cancelAction: (){
           Navigator.pop(context);
           Navigator.pushNamedAndRemoveUntil(context, Constants.WAITING_DIRECTOR_AUTHORIZATION_ROUTE, (route) => false);
         },cancelText: 'Ok');
       }

       if(res['data'] == null){
         UtilityWidgets.getToast('Company information not found. Please ask the director to add your information.',duration:'2',);
        
         Navigator.pushNamedAndRemoveUntil(context,Constants.WAITING_DIRECTOR_AUTHORIZATION_ROUTE,(route) => false);
         return;

       }

      String route = Constants.UNKNOWN_ROUTE;
       if(userRole == Constants.COURIER_SERVICE_BRANCH_MANAGER_ROLE){
         route = Constants.COURIER_SERVICE_BRANCH_MANAGER_HOME_ROUTE;
       }else{
         route = Constants.COURIER_SERVICE_BRANCH_OFFICE_PERSONEL_HOME_ROUTE;
       }

       Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);


       },confirmationText: "VERIFY", isLong: true, isDisabled: !confirmButtonActivation
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

       
         var res = await _authModel.sendOTPCode(phoneNumber:_userModel.getUser.phoneNumber);
        
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
        const Text("Send OTP Again", style: TextStyle(color: primaryColor,fontSize: 13, fontWeight: FontWeight.w900,decoration: TextDecoration.underline)),
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

