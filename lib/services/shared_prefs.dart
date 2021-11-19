
import 'dart:async';
import 'package:doorstep_delivery/constants/constants.dart';
import 'package:doorstep_delivery/services/auth_service.dart';
import 'package:doorstep_delivery/services/data_models/branch_delivery_personel_data_model.dart';
import 'package:doorstep_delivery/services/data_models/company_data_model.dart';
import 'package:doorstep_delivery/services/data_models/user_data_model.dart';
import 'package:doorstep_delivery/ui/utils/helper_functions.dart/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:validators/sanitizers.dart';
class SharedPref {

  static const String LOGIN_CREDENTIALS = "loginCrendentials";
  static const String SESSION_STATE = "auth_states.";
  static const String ACCOUNT_VERIFICATION = "account_verification";
  static const String SESSION_VALID = "session_valid";

  static Future<Map<String,dynamic>> storeDeliveryPersonel(DeliveryPersonel deliveryPersonel)async{
      try{

      
      SharedPreferences _spf = await SharedPreferences.getInstance();
      deliveryPersonel.toMap().forEach((key, value) { 

        if(value is int){
          _spf.setInt(key, value);
        }else if(value is bool){
          _spf.setBool(key, value);
        }else if(value is double){
          _spf.setDouble(key, value);
        }else{
          _spf.setString(key, value);
        }
        
      });
      }catch(e){

      }
     
return {'result': true};
  }


  static Future<Map<String,dynamic>> getDeliveryPersonel({SharedPreferences? spfInstance})async{
      try{

        
           spfInstance ?? await SharedPreferences.getInstance();
    
      
      Map<String,dynamic> _deliveryPersonelMap = DeliveryPersonel().toMap();
      
      _deliveryPersonelMap.forEach((key, value) { 

      
       _deliveryPersonelMap[key] =spfInstance!.get(key) ?? _deliveryPersonelMap[key];
       if(spfInstance.get(key) is bool){
         myPrint('$key: ${spfInstance.get(key)}');

       }
      });

        myPrint(_deliveryPersonelMap,heading: 'delivery personel info map');
      return {'result':true,'data':DeliveryPersonel.fromMap(_deliveryPersonelMap)};

      }catch(e){
           print('$e shared prefs .dart line 64');
        return {'result':false, 'desc': 'Unexpected error occured,please try again later.'};
      }
     

  }


  
  static Future<Map<String,dynamic>> getCompany({SharedPreferences? spfInstance})async{
      try{

        if(spfInstance == null){
           spfInstance = await SharedPreferences.getInstance();
        }
      
      Map<String,dynamic> _companyMap =   Company().toMap();
      
    _companyMap.forEach((key, value) { 

      
       _companyMap[key] = spfInstance!.get(key) ?? _companyMap[key];
       
      });
     
      return {'result':true,'data':Company.fromMap(_companyMap)};

      }catch(e){
              print('$e line 89 shared prefs.dart');
        return {'result':false, 'desc': 'Unexpected error occured,please try again later.'};
      }
     

  }


 

  static Future<Map> updateSettings(Map settings) async {
    try {
      SharedPreferences _i = await SharedPreferences.getInstance();

      if (settings.length > 0) {
        settings.forEach((key, value) {
          if (value is bool) {
            _i.setBool(key, value);
          }

          if (value is String) {
            _i.setString(key, value);
          }

          if (value is int) {
            _i.setInt(key, value);
          }
        });
      }

      return {"result": true, "desc": ""};
    } catch (e) {
      print(e);
      return {
        "result": false,
        "desc": "Unexpected error occured,while updating settings."
      };
    }
  }


  static Future<Map> addCompany(Company _company) async {
    try {
      SharedPreferences _i = await SharedPreferences.getInstance();

      Map<String,dynamic> _companyMap = _company.toMap();

      if (_companyMap.isNotEmpty) {
        _companyMap.forEach((key, value) {
          if (value is bool) {
            _i.setBool(key, value);
          }

          if (value is String) {
            _i.setString(key, value);
          }

          if (value is int) {
            _i.setInt(key, value);
          }
        });
      }else{
        return  {'result': true,'data':''};
      }

      return {"result": true, "data": "success"};
    } catch (e) {
      print(e);
      return {
        "result": false,
        "desc": "Unexpected error occured,while updating settings."
      };
    }
  }
 
  
  
  static Future<Map<String,dynamic>> storeValue(Map<String,dynamic> map)async{
    
    try {
      SharedPreferences _i = await SharedPreferences.getInstance();

          map.forEach((key, value) { 


          if (value is bool) {
            _i.setBool(key, value);
          }

          if (value is String) {
            _i.setString(key, value);
          }

          if (value is int) {
            _i.setInt(key, value);
          }

          });
     

        
      

      return {"result": true, "data": "success"};
    } catch (e) {
      print('$e shared prefs line 188');
      return {
        "result": false,
        "desc": "Unexpected error occured,while updating settings."
      };
    }
  }


  static Future<Map<String,dynamic>> getValue(key) async {
    try {
      SharedPreferences _i = await SharedPreferences.getInstance();

      return {"result": true, "desc": _i.get(key)};
    } on PlatformException catch (e) {
      print(e.code);
      print(e.message);
      return {"result": false, "desc": "Error Reading value."};
    }
  }

  
  static Future<Map<String,dynamic>> getValues(Set keys,{sharedPrefInstance}) async {
    try {

       SharedPreferences _i;
      if(sharedPrefInstance != null){
        _i = sharedPrefInstance;
      }else{
        _i = await SharedPreferences.getInstance();
      }
      

      Map resultantMap = {};

      keys.forEach((key) {
        resultantMap.putIfAbsent(key, () {
       
          return  _i.get(key);
          
         
        });
      });

     
      return {"result": true, "desc": resultantMap};
    } catch (e) {
      print("$e shared prefs 356");
     
      return {"result": false, "desc": "Unexpected error, please try again."};
    }
  }


  // initialize user 
  static Future<Map<String,dynamic>> initializeUser() async{

    try{

    
       
       
        // get the shared prefs instance
        SharedPreferences spfInstance = await SharedPreferences.getInstance();

        // get the stored user in the SharedPrefs
         Map<String,dynamic> deliveryPersonelMap =  await getDeliveryPersonel(spfInstance: spfInstance);



        // declare and initialize the resultant map
        Map<String,dynamic> resultantMap = {'result': true,'delivery_personel_obj':DeliveryPersonel(),'company_obj':Company(),'firebase_user': null,'phone_verification': false};

        // get the current firebase user
        User? _user = AuthService().getCurrentUser();
        
        
        // get show onboarding value
        Map<String,dynamic> showOnboardingMap = await getValue('show_onboarding');
        resultantMap['show_onboarding'] = !showOnboardingMap['result'] || showOnboardingMap['desc'] == null ? true : false;
      
      // if the user's info can be found inside the local storage
      if(deliveryPersonelMap['result']){
          
            // add the firebase user info
           resultantMap['firebase_user'] = _user; 

            // add the user info stored locally
           resultantMap['delivery_personel_obj'] = deliveryPersonelMap['data'];

          // fetch the users company info
          Map<String,dynamic> companyMapRes = await getCompany();

          // get user auth claims
          Map<String,dynamic> userClaims = await AuthService().getUserAuthClaimns();
          
          if(!userClaims['result']){
            return {'result':false,'firebase_user' : false,'delivery_personel_obj': DeliveryPersonel(),'company_obj': Company(),'phone_verification': false};
          }

         resultantMap['phone_verification'] = userClaims['phone_verification'];
      
         if(userClaims.containsKey('blocked') ){
           resultantMap['blocked'] = true;
         }

           // add the users company info 
           resultantMap['company_obj'] = companyMapRes['result'] ? companyMapRes['data'] : Company();
          
        



      }
     
      myPrint(resultantMap,heading: '');
      return resultantMap;
      
    }catch(e){

      return {'result': false, 'desc': 'Unexpected error, please try again.'};
    }
  }



 
}
