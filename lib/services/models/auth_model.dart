import 'dart:async';
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
 final String _resetPasswordEmail = "";
  String _regFullname = "";
  String _regPhoneNumber = "";
  String _regEmail = "";
  String _regLocation = "";
  bool _isPhoneVerificationType = true;
  String _regPassword = "";

  bool get getIsBusy => _isBusy;
  void setIsBusy(bool param) {
    _isBusy = param;

    notifyListeners();
  }

  String get getRegPhoneNumber => _regPhoneNumber;
  void setRegPhoneNumber(phoneNumber) {
    _regPhoneNumber = phoneNumber;
    notifyListeners();
  }

  bool get getIsPhoneVerificationType => _isPhoneVerificationType;
  void changeRegVerificationType() {
    _isPhoneVerificationType = !_isPhoneVerificationType;
    print("$_isPhoneVerificationType");
    notifyListeners();
  }

  

  String get getOtpTimer => _otpTimer;
  void startOtpTimer() {
  
          if(timer?.isActive == true){
              timer?.cancel();
          

        }
    timer = Timer.periodic(Duration(seconds: 1), (t) { 
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

  Future<Map<String,dynamic>?> signupUserWithEmailAndPassword(String email, String password, {String fullname = '', String phone = '', String userRole = '',dateOfBirth ='', String gender = '', String townOrCity = '', String address = ''}
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
       ) as Map<String,dynamic>;

      return res;
      
       }catch(e){
         print('$e line 152 auth model');
         return {'result': false, 'desc': "Sorry something went wrong, try again later."};
       }
  }

  String get getRegFullname => _regFullname;
  String get getRegEmail => _regEmail;
  String get getPhoneNumber => _regPhoneNumber;
  String get getRegPassword => _regPassword;
  String get getRegLocation => _regLocation;
  void setRegDetails(
      {String fullname = "",
      String location = "",
      String email = "",
      String phoneNumber = "",
      String password = ""}) {
    if (fullname.isNotEmpty) {
      _regFullname = fullname;
    }
    if (email.isNotEmpty) {
      _regEmail = email;
    }

    if (phoneNumber.isNotEmpty) {
      _regPhoneNumber = phoneNumber;
    }

    if (password.isNotEmpty) {
      _regPassword = password;
    }

    if (location.isNotEmpty) {
      _regLocation = location;
    }


    notifyListeners();
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

  Future<Map?> updateUserPassword({String email = '', String newPassword = ''})async {
    return await _authService.updateUserPassword(email: email,newPassword: newPassword);
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



  
}
