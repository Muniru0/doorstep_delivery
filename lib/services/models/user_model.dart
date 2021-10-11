
import 'package:doorstep_delivery/constants.dart';
import 'package:doorstep_delivery/model_registry.dart';
import 'package:doorstep_delivery/services/data_models/user_data_model.dart';
import 'package:doorstep_delivery/services/models/base_model.dart';
import 'package:doorstep_delivery/services/models/courier_company_model.dart';
import 'package:doorstep_delivery/services/user_service.dart';
import 'package:doorstep_delivery/ui/utils/helper_functions.dart/functions.dart';

class UserModel extends BaseModel {

  UserService _userService = UserService();


  MyUser _user = MyUser();
  MyUser get getUser => _user;
  
 
  Future<Map<String, dynamic>> init() async {
    try {


      // initialize the user info
      Map<String,dynamic> res = await _userService.initializeUser();
      
      // store it in the model if available
      if(res["result"]){
       
             if(res['user_data'].firebaseUid.isNotEmpty){
                refreshUserModel(user: res['user_data']);
                myPrint(res['company_data'].directorTel);
                
                register<CompanyModel>().refreshCompanyModel(company: res['company_data']);
              }    
         
        }

        return res;
    } catch (e) {
      print("$e user model line 37");
      return {"result": false, "desc": "ERROR"};
    }
  }


 void refreshUserModel({MyUser? user}) {
  
    if (user != null) {
      
      _user = user;

    }else{
  
      _user = getUser;
    }

    notifyListeners();
  }

  Future<Map> uploadImage(
      ) async {
    try {
     

      Map uploadImageRes = await _userService.uploadImage(
          imageSource: '', remoteDir: '');
      if (uploadImageRes["desc"] == null) return uploadImageRes;

      if (uploadImageRes["result"]) {
        var splittedRes = uploadImageRes["desc"].split(Constants.UNIQUE_STRING);
      
        return {"result": true, "desc": "success"};
      }

      return uploadImageRes;
    } catch (e) {
      print(e);
      return {
        "result": false,
        "desc": "An unexcepted error occured. Please try again later."
      };
    }
  }

  Future<Map> findUserBy(value, {phone = false,fullname = false,email =  false})async {

    var res;
      if(phone){
       res  = await _userService.findUserBy(value,phone:true);
      }else if(fullname){
       res  = await _userService.findUserBy(value,fullname:true);
      }else{
         res  = await _userService.findUserBy(value,email:true);
      }
     if(res['result']){
        // refresh the model with a new user if one is found
        refreshUserModel(user:MyUser.fromMap(res['desc']));

     }
    return res;

  }

  
  


}
