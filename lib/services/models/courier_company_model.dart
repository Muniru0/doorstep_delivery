import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep_delivery/services/company_service.dart';
import 'package:doorstep_delivery/services/data_models/branch_managers_data_model.dart';
import 'package:doorstep_delivery/services/data_models/branch_office_personel_data_model.dart';
import 'package:doorstep_delivery/services/data_models/company_branch_data_model.dart';
import 'package:doorstep_delivery/services/data_models/company_branch_destinations_data_model.dart';
import 'package:doorstep_delivery/services/data_models/company_data_model.dart';
import 'package:doorstep_delivery/services/data_models/parcel_stats_data_model.dart';
import 'package:doorstep_delivery/services/models/base_model.dart';



class CompanyModel extends BaseModel{

  
   Company _company = Company(); 
   
   bool companyPhoneVerification = false;
   bool directorPhoneVerification = false;

  ParcelsStats _parcelStats = ParcelsStats();
  List<BranchManager> branchManagersList = [];

  int totalNumberOfBranchManagers = 0;
  int totalNumberOfBranches       = 0;
  int totalNumberOfDirectors      = 0;
  int totalNumberOfOfficePersonel = 0;
  int totalNumberOfDeliveryPersonel = 0;

  File? companyLogoFile;
  final CompanyService _companyService = CompanyService();

  late Timer timer;



   

   final CompanyBranch _companyBranch = CompanyBranch(); 
   int qureyOffset = 1;
   bool lastDocFetched = false;
   
   List<CompanyBranchDestination> _companyBranchDestinations = [];

  List<CompanyBranchDestination> _selectedCompanyBranchDestinations = [];


   File? companyBranchManagerAvatar;

  List<CompanyBranch> companyBranchesList = [];

  String selectedDateRange   = '../../.. - ../../../';

  List<BranchOfficePersonel> branchOfficePersonelList = [];


    
   File? get getCompanyBranchManagerAvatar => companyBranchManagerAvatar;

  List<BranchOfficePersonel> get getBranchOfficePersonels => branchOfficePersonelList;
   void setCompanyBranchManagerAvatar(file){

        companyBranchManagerAvatar = file;
        notifyListeners();
   } 
 
 List<CompanyBranch> get getCompanyBranchesList => companyBranchesList;


 // get company branch managers list

  List<BranchManager> get getBranchManagers => branchManagersList;

  

 // add branch manager to list of branch managers
 void addBranchManagerToList(index,BranchManager branchManager){

   branchManagersList.insert(index,branchManager);
   notifyListeners();
 }
    

  // clear the list of company branch managers
  void clearListOfCompanyBranchManagers(){

    branchManagersList.clear();
    notifyListeners();

  }

  // update branchManagersList
  BranchManager removeFromCompanyBranchManagersList(index){
 
  BranchManager branchManager = branchManagersList.removeAt(index);
 
    notifyListeners();
    return branchManager;

 }


 // get parcels stats
  ParcelsStats get getParcelStats => _parcelStats;
  void setParcelsStats(ParcelsStats parcelsStats){
      _parcelStats = parcelsStats;
    notifyListeners();
  }

int get getTotalNumberOfDirectors => totalNumberOfDirectors;
int get getTotalNumberOfBranchManagers => totalNumberOfBranchManagers;
int get getTotalNumberOfBranches => totalNumberOfBranches;
int get getTotalNumberOfOfficePersonel => totalNumberOfOfficePersonel;
int get getTotalNumberOfDeliveryPersonel => totalNumberOfDeliveryPersonel;


  void setGeneralCompanyStats({int directors = 0,int branchManagers = 0, int branches = 0, int deliveryPersonel = 0,int officePersonel = 0, }){

   
    if(directors > 0){
      totalNumberOfDirectors = directors;
    } 

    if(branchManagers > 0){
      totalNumberOfBranchManagers = branchManagers;
    } 

    if(branches > 0){
      totalNumberOfBranches = branches;
    }

     if(deliveryPersonel > 0){
      totalNumberOfDeliveryPersonel = deliveryPersonel;
    }

    if(officePersonel > 0){
      totalNumberOfOfficePersonel= officePersonel;
    }

    notifyListeners();

  }
  


   File get getCompanyLogoFile => companyLogoFile!;
   void setCompanyLogoFile(file){

        companyLogoFile = file;
        notifyListeners();
   }
 

   Company  get getCompany => _company;
    
    void setCourierCompany(Company courierCompany){
        courierCompany = _company;
        notifyListeners();
    }


  refreshCompanyModel({Company? company}){
      

     
      if(company == null){

    _company = getCompany;
      }else{
        _company = company;
      }
   print(getCompany.toMap());
    notifyListeners();
  }


 Map updateModel(Map data){
    
     
       if (data.containsKey(CompanyDataModel.COMPANY_FIRESTORE_ID)) {
        getCompany.companyFirestoreID = data[CompanyDataModel.COMPANY_FIRESTORE_ID];
      
      }

      if (data.containsKey(CompanyDataModel.COMPANY_NAME)) {
        getCompany.companyName = data[CompanyDataModel.COMPANY_NAME];

      }

      if (data.containsKey(CompanyDataModel.COMPANY_TEL) ) {
        getCompany.companyTel = data[CompanyDataModel.COMPANY_TEL];
       
      }

      if (data.containsKey(CompanyDataModel.COMPANY_EMAIL) ) {
        getCompany.companyEmail =  data[CompanyDataModel.COMPANY_EMAIL];
  
      }

       if (data.containsKey(CompanyDataModel.DIRECTOR_NAME) ) {
        getCompany.directorName =  data[CompanyDataModel.DIRECTOR_NAME];
  
      }

      if (data.containsKey(CompanyDataModel.DIRECTOR_TEL) ) {
        getCompany.directorTel =  data[CompanyDataModel.DIRECTOR_TEL];
  
      }

      if (data.containsKey(CompanyDataModel.DIRECTOR_EMAIL) ) {
        getCompany.directorEmail =  data[CompanyDataModel.DIRECTOR_EMAIL];
  
      }
       
       if (data.containsKey(CompanyDataModel.CITY_OF_OPERATION) ) {
        getCompany.companyCityOfOperation =  data[CompanyDataModel.CITY_OF_OPERATION];
  
      }

        if (data.containsKey(CompanyDataModel.STREET_OF_OPERATION) ) {
        getCompany.companyStreetOfOperation =  data[CompanyDataModel.STREET_OF_OPERATION];
  
      }

     

         if (data.containsKey(CompanyDataModel.COMPANY_HEAD_OFFICE_LOCATION_NAME) ) {
        getCompany.companyHeadOfficeLocationName =  data[CompanyDataModel.COMPANY_HEAD_OFFICE_LOCATION_NAME];
  
      }

     if (data.containsKey(CompanyDataModel.COMPANY_HEAD_OFFICE_LAT) ) {
        getCompany.companyHeadOfficeLat =  data[CompanyDataModel.COMPANY_HEAD_OFFICE_LAT];
  
      }
     
       if (data.containsKey(CompanyDataModel.COMPANY_HEAD_OFFICE_LNG) ) {
        getCompany.companyHeadOfficeLng =  data[CompanyDataModel.COMPANY_HEAD_OFFICE_LNG];
  
      }
     
       if (data.containsKey(CompanyDataModel.BIKE_DELIVERY_TYPE) ) {
        getCompany.bikeDeliveryType =  data[CompanyDataModel.BIKE_DELIVERY_TYPE];
  
      }

        if (data.containsKey(CompanyDataModel.CAR_DELIVERY_TYPE) ) {
        getCompany.carDeliveryType =  data[CompanyDataModel.CAR_DELIVERY_TYPE];
  
      }

    if (data.containsKey(CompanyDataModel.EXPRESS_DELIVERY) ) {
        getCompany.expressDelivery =  data[CompanyDataModel.EXPRESS_DELIVERY];
  
      }

     

    notifyListeners();
       return data;
  

 }


  Stream<DocumentSnapshot> fetchCompanyParcelsDailyStatsStream() {
 
      return  _companyService.fetchCompanyParcelsDailyStatsStream(companyFirestoreID: getCompany.companyFirestoreID);


  }



    int accountCreationProgress = 0;
    int get getAccountCreationProgress => accountCreationProgress;
    void setAccountCreationProgress(percentage){
      accountCreationProgress = percentage;
      notifyListeners();
    }
 Future<Map> addCompany()async{
    
     timer = Timer.periodic(Duration(seconds: 1),(t){
     setAccountCreationProgress(t.tick);
     if(t.tick == 100){
       t.cancel();
     }
     });

    
      
   
   var res = await _companyService.addCompany(getCompany);

     if(timer.isActive){
         timer.cancel();
     }
      
   
        return res;
 }
  
 

  void updateCredentialsVerification(Map params) async{
    var res = await _companyService.updateCredentialsVerification(params);
  }


  Future<Map<String,dynamic>> getCompanyStaffStats({bool
  updatemodel = true})async{

    var res = await _companyService.getCompanyStaffStats(getCompany.companyFirestoreID);

    // check if the result has positive results
    if(res['result'] && updatemodel){
    
      // myPrint(res['data'].totalNumberOfBranches,heading: 'Total Number of Branches');
      setGeneralCompanyStats(
        branchManagers:res['data'].totalNumberOfBranchManagers,
        directors:res['data'].totalNumberOfDirectors,
        deliveryPersonel:res['data'].totalNumberOfDeliveryPersonel,
        branches:res['data'].totalNumberOfBranches
        );
    }
    return res;
   
  }

  

  Future<Map> numberOf({String flag = ''}) async{
    return await _companyService.getCompanyBranches(companyFirestoreID: getCompany.companyFirestoreID,flag: flag );

   
  }



  Future<Map<String,dynamic>> getCompanyStaff({String userRole = '',firebaseUid}) async{
   
    return await _companyService.getCompanyStaff(userRole, firebaseUid);

  }

  Stream<QuerySnapshot> getCompanyLiveParcels() {
    return _companyService.getCompanyLiveParcels(getCompany.companyFirestoreID);
  }

  
 int get getQueryOffset => qureyOffset;
 void updateQueryOffset({int offset = 10}){
   qureyOffset += offset;
   notifyListeners();
 }      
 

 bool get getLastDocFetched => lastDocFetched;
 void setLastDocFetched(flag){
   lastDocFetched = flag;
   notifyListeners();
 }      
 

 CompanyBranch get getCompanyBranch => _companyBranch;
List<CompanyBranchDestination> get getCompanyBranchDestinations => _companyBranchDestinations;
List<CompanyBranchDestination> get getSelectedCompanyBranchDestinations =>_selectedCompanyBranchDestinations;


void addToSelectedCompanyBranchDestinations(CompanyBranchDestination destination){
  getSelectedCompanyBranchDestinations.add(destination);
  notifyListeners();
}


   void  updateCompanyBranchDetails({companyBranchID = '',companyBranchName = '' ,companyBranchManagerEmail = '',companyBranchManagerTel ='',companyBranchCountry = '',companyBranchCity = '', companyBranchManagerGender = ''}){


       if(companyBranchID.isNotEmpty){
        
      
        _companyBranch.companyBranchID = companyBranchID;
      }


      if(companyBranchName.isNotEmpty){
        
      
        _companyBranch.companyBranchName = companyBranchName;
      }


      if(companyBranchManagerEmail.isNotEmpty){ 
 
       _companyBranch.companyBranchManagerEmail = companyBranchManagerEmail;
      }


      if(companyBranchManagerTel.isNotEmpty){

  _companyBranch.companyBranchManagerTel = companyBranchManagerTel;
      }

     
     if(companyBranchCity.isNotEmpty){

        _companyBranch.companyBranchCityOrTown = companyBranchCity;
      }
     
     

      notifyListeners();



   }



   Future<Map> addCompanyBranch({companyFirestoreID = '',branchName = '',managerEmail = '',managerPhone = '',townOrCity  =  '',address  = '', String directorFirebaseUid = ''})async{


    CompanyBranch _branchMap = CompanyBranch(companyFirestoreID:companyFirestoreID ,companyBranchName: branchName,companyBranchManagerEmail: managerEmail,companyBranchManagerTel: managerPhone,companyBranchCityOrTown: townOrCity,companyBranchAddress: address,);
    
     var res =  await _companyService.addCompanyBranch(_branchMap);

     if(res['result']){
       updateCompanyBranchDetails(companyBranchID : res['desc']);
     }
       notifyListeners();
       return res;
   }


     Future<Map> addCompanyBranchDestinations()async{

     return await _companyService.addCompanyBranchDestinations(getCompanyBranchDestinations);
   }

  bool addToCompanyDestinationsList({String destination = '', String minParcelPrice = ''}) {

      var destinationObj = CompanyBranchDestination(branchName: _companyBranch.companyBranchName,destinationName: destination, minParcelPrice: minParcelPrice,);
      if(!getCompanyBranchDestinations.contains(destinationObj)){
        getCompanyBranchDestinations.add(destinationObj);
      }
      notifyListeners();
      return true;
  }

  bool editBranchDestination({String destination = '', String minParcelPrice ='', destinationIndex }) {

      if(destinationIndex == null){
        return false;
      }

      var newDestinationObj = CompanyBranchDestination(branchName: _companyBranch.companyBranchName,destinationName: destination, minParcelPrice: minParcelPrice,);
       
      getCompanyBranchDestinations[destinationIndex] = newDestinationObj;
      notifyListeners();

      return true;
  }

  void clearSelectedCompanyBranchDestinationsList() {
   var selectedDestinations =  getSelectedCompanyBranchDestinations;
    selectedDestinations.forEach((destination) { 
      getCompanyBranchDestinations.remove(destination);
    });
    selectedDestinations.clear();
     
    notifyListeners();
  }


  void deselectCompanyBranchDestination(CompanyBranchDestination destination){
    var destinations = getSelectedCompanyBranchDestinations;
    destinations.removeAt(destinations.indexOf(destination));
    notifyListeners();
  }


  void removeFromBranchDestinationsList(CompanyBranchDestination companyBranchDestination) {
        var destinations = getCompanyBranchDestinations;
    destinations.removeAt(destinations.indexOf(companyBranchDestination));
    notifyListeners();


  }

  Future<Map> saveCompanyBranchDestinations() async{
    
    return await _companyService.saveCompanyBranchDestinations(getCompanyBranchDestinations);
  }

  Future<Map> fetchCompanyBranches() async{
   
    var res =  await _companyService.fetchCompanyBranches(offset:getQueryOffset,companyDocID: getCompany.companyFirestoreID);
    if(res['result']){

      if(res['data'] != null){
         if(res['data'].length < 10){
           setLastDocFetched(true);
         }
         updateQueryOffset();
        updateListOfBranches(branches: res['data']);
       
      }
       
    }

    return res;

  }

  void updateListOfBranches({required List<CompanyBranch> branches }) {
  
      companyBranchesList.addAll(branches);
       notifyListeners();

  }

String get getSelectedDateRange => selectedDateRange;
  void setSelectedDateRange(String range) {

    selectedDateRange = range;

  notifyListeners();
  }

  Future<Map<String,dynamic>> fetchCompanyBranchManagers({String branchID = ''}) async{

   return await _companyService.fetchCompanyBranchManagers(branchID: branchID);

  
  }

  Future<Map<String,dynamic>> fetchCompanyStaff({String userRole = '',String firebaseUid = ''})async {


 return await _companyService.fetchCompanyStaff(userRole: userRole,firebaseUid: firebaseUid);
  }

  Future<Map<String,dynamic>>  deleteCompanyStaff({String userRole = '', String firebaseUid = ''}) async{

    return await _companyService.deleteCompanyStaff(userRole: userRole, firebaseUid: firebaseUid);
  }

  Future<Map<String,dynamic>> addBranchManager({String branchManagerEmail = '', String branchManagerPhone = '', required String branchID}) async{

    return await _companyService.addCompanyBranchManager(branchID: branchID,branchManagerEmail: branchManagerEmail,branchManagerPhone: branchManagerPhone);
  }

  void addBranchOfficePersonelToList(int index, BranchOfficePersonel branchOfficePersonel) {


  
   branchOfficePersonelList.insert(index,branchOfficePersonel);
   notifyListeners();
  }

BranchOfficePersonel   removeFromCompanyBranchOfficePersonelsList(int index) {
     
  BranchOfficePersonel branchOfficePersonel = branchOfficePersonelList.removeAt(index);
 
    notifyListeners();
    return branchOfficePersonel;
  }



  Future<Map<String,dynamic>> getCompanyBranchOfficePersonels({String branchID = ''})async {
return await _companyService.fetchCompanyBranchOfficePersonel(branchID: branchID);

  }



  Future<Map<String,dynamic>> addBranchOfficePersonel({String branchID = '', String branchOfficePersonelEmail = '', String branchOfficePersonelPhone = ''}) async{

    return await _companyService.addCompanyBranchOfficePersonel(branchID: branchID,branchOfficePersonelEmail: branchOfficePersonelEmail,branchOfficePersonelPhone: branchOfficePersonelPhone);
  }


  














}

