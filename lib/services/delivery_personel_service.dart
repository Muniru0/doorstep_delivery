

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep_delivery/constants/constants.dart';
import 'package:doorstep_delivery/services/auth_service.dart';
import 'package:doorstep_delivery/services/data_models/branch_managers_data_model.dart';
import 'package:doorstep_delivery/services/data_models/branch_delivery_personel_data_model.dart';
import 'package:doorstep_delivery/services/data_models/company_branch_data_model.dart';
import 'package:doorstep_delivery/services/data_models/company_branch_destinations_data_model.dart';
import 'package:doorstep_delivery/services/data_models/company_data_model.dart';
import 'package:doorstep_delivery/services/data_models/parcel_data_model.dart';
import 'package:doorstep_delivery/services/firebase_storage_uploader.dart';
import 'package:doorstep_delivery/services/secure_store.dart';
import 'package:doorstep_delivery/services/server_requests.dart';
import 'package:doorstep_delivery/services/shared_prefs.dart';
import 'package:doorstep_delivery/ui/utils/helper_functions.dart/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';



class DeliveryPersonelService{


final FirebaseFirestore _firestore = FirebaseFirestore.instance;




  // add the company
  Future<Map> addCompany(Company company)async {

    try{
      var companyObjMap = company.toMap();
     SharedPref.addCompany(company);
   User? _user =  await AuthService().getCurrentUser();
      if(_user == Null){
          return {'result': false, 'desc': 'Session expired, please re-authenticate to continue'};
      }
      String _authToken = await _user!.getIdToken(true);
     companyObjMap['id_token'] = _authToken;
      var res =  await  ServerRequests.sendNetworkRequest(Constants.REQUEST_TYPE_ADD_COMPANY,params:companyObjMap);


    if(res['result']){
      SharedPref.updateSettings({

        CompanyDataModel.COMPANY_NAME: company.companyName,
        CompanyDataModel.COMPANY_FIRESTORE_ID : res['desc']

        });
    } 
    return res;
    } on PlatformException catch(e){


      print(e.code);
      print(e.message);
      print('Add company inside company service.');
      return {'result': false,'desc':'Something went wrong. Try again later'};

    }
  }


  // upload the company logo
  Future<Map> uploadCompanyLogo(file)async{
     try{

   return await FirebaseFileUploader().uploadFile(file,remoteDir: Constants.COMPANY_LOGO_FILES_DIR);
    


     }on PlatformException catch(e){
       print(e.code);
       print(e.message);
       return {'result': true,'desc':'Something unexpectedly went wrong,please try again later.'};
     }
  }


    // update the verification credentials
  Future<Map> updateCredentialsVerification(params) async{

    try{

     
     return  await SharedPref.updateSettings(params);
       

    }catch(e){
      print(e);
      return {'result': false, 'desc': 'Something went wrong, please try again.'};
    }
  }


  // get a company by using the staff email
  Future<Map<String,dynamic>> getCompanyByStaffEmail({String userRole = Constants.COURIER_SERVICE_DIRECTOR_ROLE,String email = ''})async{


    try{

        var whereField = '';
        String collectionPath = Constants.COURIER_SERVICE_ROOT_DOC_PATH;

        switch(userRole){
          case Constants.COURIER_SERVICE_BRANCH_MANAGER_ROLE:
          collectionPath = collectionPath + '/' + Constants.COURIER_SERVICE_BRANCH_MANAGERS_COLLECTION_NAME;
          whereField = CompanyBranchDataModel.COMPANY_BRANCH_MANAGER_EMAIL;
          break;
          default :
          collectionPath = collectionPath + '/' + Constants.COURIER_SERVICE_DIRECTORS_COLLECTION_NAME;
          whereField = CompanyDataModel.DIRECTOR_EMAIL;
          break; 

        }

      QuerySnapshot snapshot = await _firestore.collection(collectionPath).where(whereField,isEqualTo: email).get();

      if(snapshot.size < 1){
      
        return {'result':true,'desc': null};
      
      }


        return {'result': true, 'company_data': Company.fromMap(snapshot.docs.first.data() as Map<String,dynamic>) };

    }catch(e){

      print('$e company service .dart line 120');
      return {'result':false,'desc': 'Unexpected error, please try again later.'};

    }
  }
 

  // get the company with the company ID
  Future<Map<String,dynamic>> getCompanyWithID(companyDocID)async{

   try{

      DocumentSnapshot companyDoc = await _firestore.doc(Constants.COURIER_SERVICE_ROOT_DOC_PATH + Constants.ALL_COURIER_SERVICE_COMPANIES_COLLECTION_NAME + '/' + companyDocID).get();

      if(!companyDoc.exists){
          return {'result':true,'data': null};
      }
    myPrint(companyDoc.data(),heading: 'Company Data');
 return {'result':true, 'data': Company.fromMap(companyDoc.data() as Map<String,dynamic>)};

    }catch(e){
      print('$e company service line 153');
      return {'result': false,'desc': 'Unexpected error, please try again later.'};
    }

  }
 

  // get company stats stream
  Stream<DocumentSnapshot> fetchCompanyParcelsDailyStatsStream({String companyFirestoreID = ''}) {

      // a day in milliseconds
      int dayInMilliseconds = 1000 * 60 * 60 * 24;

      
  var todayParcelsStatsCollectionName = (DateTime.now().millisecondsSinceEpoch   / dayInMilliseconds).floor();

      return _firestore.doc('${Constants.ROOT_PARCELS_COL_ID}${Constants.PARCELS_COLLECTION_NAME}/$companyFirestoreID/${Constants.DAILY_PARCELS_STATS_COLLECTION_NAME}/$todayParcelsStatsCollectionName').snapshots();    

  }


  

  // get all company branches
  Future<Map> getCompanyBranches({String companyFirestoreID = '', String flag = ''})async {
    var docPath = Constants.ROOT_PARCELS_COL_ID + Constants.ALL_COURIER_COMPANIES_COLLECTION_NAME + '/' + companyFirestoreID;
    try{

      String docFieldName = '';
      
      switch(flag){
        case  Constants.COURIER_SERVICE_DIRECTORS_COLLECTION_NAME:
        docFieldName = '';
        break;
        case  Constants.COURIER_SERVICE_BRANCH_MANAGERS_COLLECTION_NAME:
         docFieldName = '';
        break;
        case  Constants.COURIER_SERVICE_BRANCH_OFFICERS_COLLECTION_NAME:
         docFieldName = '';
        break;
        case  Constants.COURIER_SERVICE_BRANCHES_COLLECTION_NAME:
         docFieldName = '';
        break;
        case  Constants.COURIER_SERVICE_BRANCH_DESTINATIONS_COLLECTION_NAME:
         docFieldName = '';
        break;

      }
  
    DocumentSnapshot res =  await _firestore.doc(docPath).get();

    if(res.exists){
       Map<String, dynamic> resData = res.data() as Map<String,dynamic>;
      return {'result': true, 'desc':resData[docFieldName]};
    }

    return {'result': false, 'desc': "Sorry could'nt find company records"};
      

    }catch(e){
      print(e);
      print('Inside the company service.dart file on line 196');
      print(docPath);
      return {'result': false, 'desc': 'Unexpected error while loading company data.'};
    }
  }

  
  
  Future<Map<String,dynamic>> getDeliveryPersonelInfo(staffFirebaseUid)async{
     try{

        

    

          DocumentSnapshot staffSnapshot = await _firestore.doc(Constants.COURIER_SERVICE_ROOT_DOC_PATH + Constants.PARCELS_COL_ID + '/' + staffFirebaseUid).get();

          if(!staffSnapshot.exists){
          
            return {'result':true,'data': {}};
          
          }


        return {'result': true, 'data': staffSnapshot.data()};

    }on FirebaseException catch(e){
        myPrint(e,heading: e.code);
      print('$e company service .dart line 120');
      return {'result':false,'desc': 'Request processing error, please try again later.'};

    }


  }


  // fetch the company staff stats
  Future<Map<String,dynamic>> getCompanyStaffStats(companyDocID)async {
    try{


   DocumentSnapshot snapshot = await _firestore.doc(Constants.COURIER_SERVICE_ROOT_DOC_PATH + Constants.ALL_COURIER_SERVICE_COMPANIES_COLLECTION_NAME + '/' +companyDocID + '/' + Constants.OVERALL_COMPANY_STAFF_STATS).get();

    

    if(!snapshot.exists){
     
      return {"result": false,'desc': 'Internal server error, please try again later.'};
    }
    try{

      myPrint(snapshot.data(),heading: 'Company stats data');
    return {'result': true, 'data':CompanyStaffStats.fromMap(snapshot.data() as Map<String,dynamic>)};
    }catch(e){
       myPrint(e,heading: 'company service line 282');
        return {'result': false,'desc': 'Unexpected error, while loading company statistics. If problem persists please contact admin.'};
    }
    }on FirebaseException catch(e){
      myPrint(e,heading:'line 290 company service');
      if(e.code == 'unavailable'){
         return {'result':false,'desc': 'Please check your internet settings and try again.'};
      }
     
       return {'result': false,'desc':'Unexpected error, please try again.'};
    }
  }


  // add the company branch
  Future<Map> addCompanyBranch( CompanyBranch companyBranch)async {


   try{

   Map<String,dynamic> idTokenRes = await AuthService().getAuthIdToken();
  
     if(!idTokenRes['result']){
       return {'result': false,'desc': 'Please sign-out completely and try again.'};
     }
    Map<String,dynamic> companyBranchMap = companyBranch.toMap();
   companyBranchMap['id_token'] = idTokenRes['data'];
     
    return await ServerRequests.sendNetworkRequest(Constants.ADD_COMPANY_BRANCH,params: companyBranchMap);
    
       
   }catch(e){
     print(e);
     print("Inside Company branch Service.dart");
     return {'result': false,'desc':'Unexpected error occured,please try again.'};
   }
    

  }


  // add company branch destinations
  addCompanyBranchDestinations(List<CompanyBranchDestination> companyBranchDestinations) {


    try{
      WriteBatch batch = _firestore.batch();
      for (var companyBranchDestination in companyBranchDestinations) {
         var docRef = "${(Random().nextDouble() * 100000000000000000)}_${companyBranchDestination.destinationName}";
      batch.set(_firestore.doc('${Constants.COURIER_SERVICE_BRANCH_DESTINATIONS_COL}/$docRef'), companyBranchDestination.toMap());
      }
      batch.commit();

    }catch(e){
      print(e);
      return {'result': false, 'desc': 'Unexpected error plese try again.'};
    }
  }


  // save the company branch destinations
  Future<Map> saveCompanyBranchDestinations(List<CompanyBranchDestination> branchDestinations) async{

    try{
     if(branchDestinations.isEmpty){
       return {'result': false, 'desc': "Please add destinations."};
     }

     WriteBatch batch =  _firestore.batch();

      branchDestinations.forEach((destination) {
        var docRef = "${Random().nextDouble() * 100000000000000000}_${destination.destinationName}";
        batch.set(_firestore.doc(Constants.ROOT_PARCELS_COL_ID + Constants.COURIER_SERVICE_BRANCH_DESTINATIONS_COLLECTION_NAME), destination.toMap());
       });
      batch.commit();
      return {'result': true, 'desc': 'success'};
    }catch(e){

      print(e);
      print('Inside company service on line 68');
      return {'result': false, 'desc': 'Unexpected error, please try again.'};
    }
  }



  // fetch the company branches
  Future<Map> fetchCompanyBranches({int offset  = 1, String companyDocID = ''})async {

    try{
      
    

      if(offset == 1){

        QuerySnapshot res =  await _firestore.collection(Constants.COURIER_SERVICE_ROOT_DOC_PATH + Constants.COURIER_SERVICE_BRANCHES_COLLECTION_NAME).where(CompanyBranchDataModel.COMPANY_FIRESTORE_ID,isEqualTo:companyDocID).orderBy(CompanyBranchDataModel.TIMESTAMP).limit(10).get();
        
        if(res.size < 1){
          myPrint('True empty list',heading: 'Truly empty');
          return {'result': true,'data': null};
        }
       
        List<CompanyBranch> branchesList = [];
       res.docs.forEach((branch) {
         myPrint(branch.data(),heading: 'Branch Data');
         var branchObj = CompanyBranch.fromMap(branch.data()! as Map<String,dynamic>);
         branchesList.add(branchObj);}

       );

      myPrint('',heading: 'Successful Return.');
       return {'result': true, 'data': branchesList};
        
      }

      QuerySnapshot res = await _firestore.collection(Constants.COURIER_SERVICE_ROOT_DOC_PATH + Constants.COURIER_SERVICE_BRANCHES_COLLECTION_NAME).where(CompanyBranchDataModel.TIMESTAMP, isGreaterThan:offset).where(CompanyDataModel.COMPANY_FIRESTORE_ID,isEqualTo: companyDocID).orderBy(CompanyBranchDataModel.TIMESTAMP).limit(10).get();

      if(res.size < 1){
         return {'result': true,'data': null};
      }

     var branchesList = [];
       res.docs.forEach((branch) =>
         branchesList.add(CompanyBranch.fromMap(branch.data()! as Map<String,dynamic>))
       );

       return {'result': true, 'data': branchesList};

    
    } catch(e){
      print(e);
      print('company branch service _');
      return {'result': false, 'desc': 'Unexpected error, please try again later.'};
    }


  }


    // add the company branch manager
   Future<Map<String,dynamic>> addCompanyBranchManager({String branchManagerEmail = '', String branchManagerPhone = '',required String branchID})async {

    try{
    var res = await AuthService().getAuthIdToken(forceRefresh: true);

    if(!res['result']){
        return {'result': false,'desc': 'Error adding manager. Please try re-authenticating.'};
    }

    return await ServerRequests.sendNetworkRequest(Constants.ADD_COMPANY_BRANCH_MANAGER_NETWORK_REQUEST_FLAG, params: {'id_token': res['data'],'company_branch_manager_email':branchManagerEmail,'company_branch_manager_phone': branchManagerPhone,'company_branch_id':branchID});


    }catch(e){


      myPrint(e,heading: 'company service line 540');
      return {'result': false,'desc': 'Unexpected error,please try again'};
    }


  }


  // fetch all the company branch Managers
  Future<Map<String,dynamic>> fetchCompanyBranchManagers({String branchID = ''}) async{

    try{
 
        QuerySnapshot _managersSnapshot = await _firestore.collection(Constants.COURIER_SERVICE_ROOT_DOC_PATH + Constants.COURIER_SERVICE_BRANCH_MANAGERS_COLLECTION_NAME).where(BranchManagersDataModel.BRANCH_ID,isEqualTo: branchID).get();

      if(_managersSnapshot.size < 1){ 
        return {'result':true,'data': null};
        }

          List<BranchManager> data = [];
        _managersSnapshot.docs.forEach((QueryDocumentSnapshot managerDoc) {
            myPrint(managerDoc.data() as Map<String,dynamic>);
            data.add(BranchManager.fromMap(managerDoc.data() as Map<String,dynamic>));

        });

        return {'result':true, 'data': data};
        
    }catch(e){
      myPrint('$e error',heading: 'company service line 440');
      return {'result': false,'desc': 'Sorry error fetching branch managers'};
    }


  }


  // fetch a single company staff
  Future<Map<String,dynamic>> fetchCompanyStaff({String userRole = '',String firebaseUid = '' }) async{


    try{
    
    if(firebaseUid.isEmpty){
      return {'result':false,'desc': 'User not found.'};
    }

     DocumentSnapshot _userProfileDoc;
    try{
     String staffDocPath = Constants.COURIER_SERVICE_ROOT_DOC_PATH;

       switch(userRole){
         case Constants.COURIER_SERVICE_DIRECTOR_ROLE:
         staffDocPath = staffDocPath + Constants.COURIER_SERVICE_DIRECTORS_COLLECTION_NAME;
         break;
          case Constants.COURIER_SERVICE_BRANCH_MANAGER_ROLE:
         staffDocPath = staffDocPath + Constants.COURIER_SERVICE_BRANCH_MANAGERS_COLLECTION_NAME;
         break;
         
       } 

     _userProfileDoc = await _firestore.doc(staffDocPath + '/' + firebaseUid).get();

    }on FirebaseException catch(e){
      if(e.code == 'unavailable'){
        return {'result': false,'desc': 'Please check your internet connection and try again.'};
      }
      return {'result': false,'desc': 'Error fetching user info.'};
    }

    if(!_userProfileDoc.exists){
      return {'result': false,'desc': 'User not found.'};
    }

    return {'result': true, 'data': BranchManager.fromMap(_userProfileDoc.data() as Map<String,dynamic>)};

    }catch(e){
      print('$e line company service 503');
      return {'result': false,'desc': 'Unexpected error please try again later.'};
    }
  }




  // delete a single company staff
  Future<Map<String,dynamic>> deleteCompanyStaff({String userRole = '', String firebaseUid = '' })async {

    try{

    var res =   await AuthService().getAuthIdToken(forceRefresh: true);
    if(!res['result']){
      return {'result': false,'desc': 'Error deleting staff. Please try again later.'};
    }

    var requestFlag;
    var params = {'id_token':res['data']};

    if(userRole == Constants.COURIER_SERVICE_BRANCH_MANAGER_ROLE){

      requestFlag = Constants.DELETE_COMPANY_STAFF_NETWORK_REQUEST_FLAG;
      params['branch_manager_firebase_uid'] = firebaseUid;
    
    }else if(userRole == Constants.COURIER_SERVICE_BRANCH_OFFICE_PERSONEL_ROLE){

      requestFlag = Constants.DELETE_COMPANY_BRANCH_OFFICE_PERSONEL_NETWORK_REQUEST_FLAG;
      params['company_office_personel_firebase_uid'] = firebaseUid;
    }

 
return await ServerRequests.sendNetworkRequest(requestFlag, params: params);
  }catch(e){

      myPrint(e,heading: 'Company service line 516');
      return {'result': false,'desc': 'Unexpected error,please try again.'};


  }
  

  }

 


  // fetch the company branch office personel
  Future<Map<String,dynamic>> fetchCompanyDeliveryPersonel({String branchID = ''}) async{
    

 try{
   
        QuerySnapshot _branchOfficePersonelSnapshot = await _firestore.collection(Constants.COURIER_SERVICE_ROOT_DOC_PATH + Constants.COURIER_SERVICE_OFFICE_PERSONEL_COLLECTION_NAME).where(DeliveryPersonelDataModel.BRANCH_ID,isEqualTo: branchID).get();

      if(_branchOfficePersonelSnapshot.size < 1){ 
        return {'result':true,'data': null};
        }

          List<DeliveryPersonel> data = [];
        _branchOfficePersonelSnapshot.docs.forEach((QueryDocumentSnapshot branchOfficePersonelDoc) {
            myPrint(branchOfficePersonelDoc.data() as Map<String,dynamic>);
            data.add(DeliveryPersonel.fromMap(branchOfficePersonelDoc.data() as Map<String,dynamic>));

        });

        return {'result':true, 'data': data};
        
    }catch(e){
      myPrint('$e error',heading: 'company service line 440');
      return {'result': false,'desc': 'Sorry error fetching branch managers'};
    }


  }



  Stream<QuerySnapshot> getCompanyLiveParcels(String companyFirestoreID) {

    return _firestore.collection(Constants.COURIER_SERVICE_ROOT_DOC_PATH + Constants.PARCELS_COLLECTION_NAME + '/' + companyFirestoreID + '/' + Constants.PARCELS_COLLECTION_NAME).snapshots();
  }



  
  Future<Map<String,dynamic>> addCompanyDeliveryPersonel({String branchID = '', String branchOfficePersonelEmail = '', String branchOfficePersonelPhone = ''}) async{
    
     try{

    var res = await AuthService().getAuthIdToken(forceRefresh: true);

    if(!res['result']){
        return {'result': false,'desc': 'Error adding manager. Please try re-authenticating.'};
    }

    return await ServerRequests.sendNetworkRequest(Constants.ADD_COMPANY_BRANCH_OFFICE_PERSONEL_NETWORK_REQUEST_FLAG, params: {'id_token': res['data'],'company_office_personel_email':branchOfficePersonelEmail,'company_office_personel_phone': branchOfficePersonelPhone,'company_branch_id':branchID});


    }catch(e){


      myPrint(e,heading: 'company service line 601');
      return {'result': false,'desc': 'Unexpected error,please try again'};
      
    }
  }

  Future<Map<String,dynamic>>updateDeliveryPersonelInfo({String firebaseUid = '',required Map<String,dynamic> data}) async{


    try{

      // if the update is for the email or phone number
      if(data.containsKey(DeliveryPersonelDataModel.DELIVERY_PERSONEL_EMAIL)){

         
         
         User? _user;
          try{

            _user =    AuthService().getCurrentUser();


          _user!.updateEmail(data[DeliveryPersonelDataModel.DELIVERY_PERSONEL_EMAIL]);



          }on FirebaseException catch(e){

              if(e.code == 'requires-recent-login'){
              var res =    await SecureStorage.getUserPassword();

              if(!res['result']){
                return {'result': false,'desc': 'Please sign-out completely and try again.'};
               
              }

                 AuthCredential _authCredential = EmailAuthProvider.credential(email:data[DeliveryPersonelDataModel.DELIVERY_PERSONEL_EMAIL] ,password: res['desc'] );
        

         
              await _user?.reauthenticateWithCredential(_authCredential);

               _user!.updateEmail(data[DeliveryPersonelDataModel.DELIVERY_PERSONEL_EMAIL]);

              }else{
                return {'result': false,'desc':getFirebaseAuthException(e.code)};
              }
             
              
          }
       
          WriteBatch _batch = _firestore.batch();

          _batch.update(_firestore.doc('${Constants.COURIER_SERVICE_ROOT_DOC_PATH}${Constants.COURIER_SERVICE_DELIVERY_COLLECTION_NAME}/$firebaseUid'), data);

           _batch.update(_firestore.doc('${Constants.CUSTOMERS_COLLECTION_PATH}/$firebaseUid'),data);

           _batch.commit();

           return {'result':true, 'data': 'sucess'};


      }




    myPrint('${Constants.COURIER_SERVICE_ROOT_DOC_PATH}${Constants.COURIER_SERVICE_DELIVERY_COLLECTION_NAME}/$firebaseUid',heading: 'Doc Path');
    await _firestore.doc('${Constants.COURIER_SERVICE_ROOT_DOC_PATH}${Constants.COURIER_SERVICE_DELIVERY_COLLECTION_NAME}/$firebaseUid').update(data);

    await SharedPref.storeValue(data);

    return {'result': true, 'data': 'success'};




    } catch(e){

      myPrint('$e company service line 640');

      return {'result': false,'desc': 'Unexpected error, please try again.'};
    }
  }


  String getFirebaseAuthException(code){


    
    switch(code){
      case  'invalid-email':
      return "Email and password mismatch.";
      case 'user-not-found':
      return 'Email and password mismatch';
      case 'wrong-password':
      return 'Email and password mismatch';
     case 'email-already-in-use':
     return 'Please the email is already in use.';
     case 'weak-password':
     return 'Please provide a stronger password.';
     case 'invalid-credential':
     return 'Please the user credentials are mismatched';
     case 'user-mismatch':
     return 'Please sign-out completely and try again.';
     case 'requires-recent-login':
     return 'Please sign-out completely and sign-in to continue.';

     default:return 'Authentication failed unexpectedly, please try again later.';
    }
  }

  Future<Map<String,dynamic>>fetchActiveDelivery(String companyFirestoreID,String deliveryPersonelID)async{

    try{

          
     QuerySnapshot _querySnapshot = await _firestore.collection('${Constants.ROOT_PARCELS_COL_ID}${Constants.PARCELS_COL_ID}/$companyFirestoreID/${Constants.PARCELS_COL_ID}').where(ParcelDataModel.DISPATCH_USER_ID,isEqualTo:deliveryPersonelID).where(ParcelDataModel.TIMESTAMP,isGreaterThan: 0).where(ParcelDataModel.PARCEL_DELIVERY_REQUEST_STATUS,isNotEqualTo: Constants.PARCEL_DELIVERY_STATUS_COMPLETED).orderBy(ParcelDataModel.TIMESTAMP).limitToLast(1).get();


      if(_querySnapshot.size < 1){
       
        return {'result': true ,'data': Parcel()};

      }

    
     
     List<Parcel> _parcelObjsList =  _querySnapshot.docs.map((parcelDoc) => Parcel.fromMap(parcelDoc.data() as Map<String,dynamic>)).toList();

     
     return {'result': true,'data': _parcelObjsList};
    }catch(e){


      myPrint('$e company service line 1015');

      return {'result': false,'desc': 'Unexpected error,whilst retrieving active deliveries. Please try again later.'};
    }
  }

  Future<Map<String,dynamic>> fetchDeliveryPersonel(String deliveryPersonelID) async{


  //  try{

      DocumentSnapshot _doc = await _firestore.doc('${Constants.COURIER_SERVICE_ROOT_DOC_PATH}${Constants.COURIER_SERVICE_DELIVERY_COLLECTION_NAME}/$deliveryPersonelID').get();


      if(!_doc.exists){

        return {'result': false,'desc': 'FATAL'};
      }

      myPrint(_doc.data(),heading: 'Delivery Personel Info');
      return {'result': true, 'data': DeliveryPersonel.fromMap(_doc.data() as Map<String,dynamic>)};



    // }catch(e){


    //   myPrint('$e delivery personel service 751');
    //   return {'result':false,'desc': 'Unexpected error, please try again.'};
    // }



  }

  Future<Map<String,dynamic>> updateDeliveryPersonelOfflineState({required bool status,required DeliveryPersonel deliveryPersonel})async {


    try{

         myPrint('');
    await _firestore.doc('${Constants.COURIER_SERVICE_ROOT_DOC_PATH}${Constants.COURIER_SERVICE_DELIVERY_COLLECTION_NAME}/${deliveryPersonel.deliveryPersonelID}').update({DeliveryPersonelDataModel.DELIVERY_PERSONEL_STATUS: status,DeliveryPersonelDataModel.DELIVERY_PERSONEL_STATUS_EDITOR: deliveryPersonel.deliveryPersonelID});
    await      SharedPref.storeValue({DeliveryPersonelDataModel.DELIVERY_PERSONEL_STATUS: status,DeliveryPersonelDataModel.DELIVERY_PERSONEL_STATUS_EDITOR: deliveryPersonel.deliveryPersonelID});
   

    return {'result': true, 'data': 'success'};


    
    
    }catch(e){

      myPrint('$e delivery personel service line');
      return {'result': false,'desc': 'Unexpected error, please try again.'};
    }



  }

  Future<Map<String,dynamic>> fetchRecentParcelDelivery(companyFirestoreID,deliveryPersonelID)async {



          try{

          
     QuerySnapshot _querySnapshot = await _firestore.collection('${Constants.ROOT_PARCELS_COL_ID}${Constants.PARCELS_COL_ID}/$companyFirestoreID/${Constants.PARCELS_COL_ID}').where(ParcelDataModel.DISPATCH_USER_ID,isEqualTo:deliveryPersonelID).orderBy(ParcelDataModel.TIMESTAMP).limitToLast(1).get();


      if(_querySnapshot.size < 1){
       
        return {'result': true ,'data': Parcel()};

      }

    
     
     List<Parcel> _parcelObjsList =  _querySnapshot.docs.map((parcelDoc) => Parcel.fromMap(parcelDoc.data() as Map<String,dynamic>)).toList();

     
     return {'result': true,'data': _parcelObjsList};
    }catch(e){


      myPrint('$e company service line 1015');

      return {'result': false,'desc': 'Unexpected error,whilst retrieving active deliveries. Please try again later.'};
    }
  }



}