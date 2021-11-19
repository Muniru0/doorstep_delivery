import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep_delivery/constants/constants.dart';
import 'package:doorstep_delivery/services/data_models/user_data_model.dart';
import 'package:doorstep_delivery/services/secure_store.dart';
import 'package:doorstep_delivery/services/shared_prefs.dart';



class UserService {



  // firestore instance
 final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


 

 


  Future<Map> isPasswordValid({password}) async {
    try {
      return await SecureStorage.confirmUserPassword(password);
    } catch (e) {
      print(e);
      return {'result': false, 'desc': 'Error confirming password.'};
    }
  }

  Future<Map> getUserCloudData({email}) async {
    try {
      List<DocumentSnapshot> docs = (await _firebaseFirestore
              .collection(Constants.CUSTOMERS_COLLECTION_PATH)
              .get())
          .docs;
      if (docs.length < 1) return {'result': false, 'desc': null};

      return {'result': true, 'desc': docs.last.data(), 'docID': docs.last.id};
    } catch (e) {
      print(e);
      return {'result': false, 'desc': 'An unexpected error occured.'};
    }
  }

  Future<Map> confirmUserPassword({password = ''}) async {
    try {
      return await SecureStorage.confirmUserPassword(password);
    } catch (e) {
      return {
        'result': false,
        'desc': 'Unexpected Error validating user password.'
      };
    }
  }



  uploadImage({imageSource, remoteDir}) {}

  Future<Map> findUserBy(value,{phone = false, fullname = false, email = false}) async{

    try{
      var field;
        if(phone){
          field = MyUserDataModel.PHONE_NUMBER;
        }else if(fullname){
          field = MyUserDataModel.FULLNAME;
        }else{
          field = MyUserDataModel.EMAIL;
        }

      List<QueryDocumentSnapshot> docs =  (await _firebaseFirestore.collection(Constants.CUSTOMERS_COLLECTION_PATH)
        .where(field,isEqualTo:value ).get()).docs;

      if(docs.length > 0){
        return {"result": true, 'desc': docs.first.data()};
      }

      return {'result': false, 'desc': 'User Not found.'};

    }catch(e){
        print(e);
        return {'result': false, 'desc': "Unexpected error,please try again."};
    }
  }


}

