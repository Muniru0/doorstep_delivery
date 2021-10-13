import 'dart:async';
import 'dart:io';
import 'package:doorstep_delivery/ui/utils/helper_functions.dart/functions.dart';
import  'package:flutter/services.dart';
import 'package:doorstep_delivery/model_registry.dart';
import 'package:doorstep_delivery/services/auth_service.dart';
import 'package:doorstep_delivery/services/data_models/company_data_model.dart';
import 'package:doorstep_delivery/services/models/base_model.dart';
import 'package:doorstep_delivery/services/models/courier_company_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthModel extends BaseModel {
  bool _isBusy = false;
  final AuthService _authService = AuthService();
  
  final String _userPassword = "";

  String _otpTimer = "";
  Timer? timer ;


  bool get getIsBusy => _isBusy;
  void setIsBusy(bool param) {
    _isBusy = param;

    notifyListeners();
  }  

  String get getOtpTimer => _otpTimer;
  void startOtpTimer() {
  
          if(timer?.isActive == true){
              timer?.cancel();
          

        }
    timer = Timer.periodic(const Duration(seconds: 1), (t) { 
      var sec = "0";
      var min = "0";
            if((60 - (t.tick % 60)) < 10){
              sec = '0${60 - (t.tick % 60)}';
              }else{
             sec = '${60 - (t.tick % 60)}';
             }
              if(t.tick < 60){
                  min = '01';
              }else{
                min = '00';
              }
  
         _otpTimer = "$min:$sec";
            if(t.tick >= 119){
              t.cancel();
             
            }
         notifyListeners();
    });
   
 
  }

  cancelTimer() {
    if (timer != null) {
      timer?.cancel();
    
    } else {
      print("timer is cancelled.");
    }
  }

 Future<Map<String,dynamic>> sendOTPCode({String phoneNumber = ''}) async {


    if(phoneNumber.isEmpty){
      return {'result': false, 'desc': 'Phone number is empty'};

    }

  
    Map<String,dynamic> res = await _authService.sendOTP(phoneNumber:phoneNumber);

      if(res['result']){
       
         startOtpTimer();
      }
    return res;

  }

  Future<Map> verifyOTP({String phoneNumber = '', String otp ='',firebaseUid,flag}) async {
    return await _authService.verifyOTP(phoneNumber:phoneNumber,otp: otp,firebaseUid: firebaseUid,flag: flag);
  }

  String get getUserPassword => _userPassword;

  // Future<Map> storeLoginCredentials(String email,String password) async{
  // var res = await _authService.storeLoginCredentials(email,password);
  //   _userPassword = password;

  //   notifyListeners();
  //   return res;
  // }

  Future<Map<String,dynamic>> signupUserWithEmailAndPassword(String email, String password, {String fullname = '', String phone = '', String userRole = '',dateOfBirth ='', String gender = '', String townOrCity = '', String address = '', required File avatar}
      ) async {


        try{
    Map<String,dynamic> res =  await _authService.signupUserWithEmailAndPassword(
        email: email,
        password: password,
        fullname: fullname,
        userRole: userRole,
        gender: gender,
        address: address,
        dateOfBirth: dateOfBirth,
        townOrCity: townOrCity,
        phoneNumber: phone,
        userAvatarFile: avatar,
       );

      myPrint(res,heading: 'results from signup');
      return res;
      
       }on PlatformException catch(e){
         print('$e line 152 auth model');
         myPrint(e.message,heading: e.code);
         return {'result': false, 'desc': "Sorry something went wrong, try again later."};
       }
  }

  


  Future<Map> isEmailVerified()async  {
    
    return  await _authService.isEmailVerified();
   

  }

  Future<Map> sendEmailVerificationLink() async {
    try {
      return await _authService.sendEmailVerificationLink();
    } catch (e) {
      return {
        "result": false,
        "desc": "Unexpected Error, please restart the app and try again."
      };
    }
  }


  Future<Map> sendPasswordResetLink(email) async {
   
    return await _authService.sendPasswordResetLink(email);
  }




  Future<Map> sendEmailVerification() async{
  return await _authService.sendEmailVerificationLink();
  }

  Future<Map> signInWithEmailAndPassword({String email = '', String password = ''}) async{

    return await _authService.signInWithEmailAndPassword(email: email, password:password);

    
  }

  Future<Map?> updateUserPassword({ String newPassword = '', String phoneNumber = '', String firebaseUid = '', String code = ''})async {
  
    return await _authService.updateUserPassword(newPassword: newPassword,phoneNumber: phoneNumber,firebaseUid: firebaseUid,code: code);
  
  }

  confirmUserPassword(String password ) async{
    return await _authService.confirmUserPassword(password);
  }


  Future<Map<String,dynamic>> signOut() async{
    return await _authService.signOut();
  }

Future<Map<String,dynamic>>  reauthenticateUserWithPassword(String email ,String password, String userRole, {String companyDocID = ''}) async{

  try{

    var res = await _authService.reauthenticateUserWithPassword( password,userRole,companyDocID: companyDocID);



      if(res['result']){
         if(res['data'] is Company){
           register<CompanyModel>().refreshCompanyModel(company:res['data']);
         }
      }
      return res;
  }catch(e){
    print('$e');
    return {'result':false, 'desc': 'Unexpected error , please try again.'};
  }
}

Future<Map<String,dynamic>> reauthenticateWithBiometrics({String userRole = '',String companyDocID = ''}) async{

  var res =  await _authService.reauthenticateWithBiometrics(userRole: userRole,companyDocID: companyDocID );

      if(res['result']){
         if(res['data'] is Company){
           register<CompanyModel>().refreshCompanyModel(company:res['data']);
         }
      }
  return res;
}

  Future<Map<String,dynamic>> signOutCompletely() async{

    return await _authService.signOutCompletely();
  }

  Future<Map<String,dynamic>> sendCodeToRestPassword({String phoneNumber = ''}) async{

    var res = await _authService.sendOtpToResetPassword(phoneNumber: phoneNumber);

      if(res['result']){
       
         startOtpTimer();
      }

      return res;
  }



  
}
