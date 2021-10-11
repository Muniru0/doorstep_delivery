// const branchManagerData = {

//         'branch_name': companyBranchName,
//         'BRANCH_ID':companyBranchID,
//         "date_joined":timestamp
//       };

import 'dart:convert';

class BranchManagersDataModel {
  static const String BRANCH_MANAGER_ID = 'branch_manager_id';
  static const String BRANCH_MANAGER_NAME = 'branch_manager_name';
  static const String BRANCH_MANAGER_PHONE = 'branch_manager_phone';
  static const String BRANCH_MANAGER_EMAIL = 'branch_manager_email';
  static const String BRANCH_MANAGER_TOWN_OR_CITY = 'branch_manager_town_or_city';
  static const String BRANCH_MANAGER_RATING = 'branch_manager_rating';
  static const String BRANCH_ID = 'branch_id';
  static const String COMPANY_FIRESTORE_ID = 'company_firestore_id';
  static const String BRANCH_NAME = 'branch_name';
  static const String DATE_JOINED = 'date_joined';





}

class BranchManager {
  String branchManagerID;
  String branchManagerName;
  String branchManagerPhone;
  String branchManagerEmail;
  String branchID;
  String companyDocID;
  String branchName; 
  double? branchManagerRating;
  int dateJoined;
  String branchManagerTownOrcity;


  BranchManager({
    this.branchManagerID = '',
    this.branchManagerName = '',
    this.branchManagerPhone = '',
    this.branchManagerEmail = '',
    this.branchManagerTownOrcity = '',
    this.branchManagerRating = 0.0,
    this.branchID = '',
    this.branchName = '',
    this.companyDocID = '',
    this.dateJoined = 0
    
  });

  factory BranchManager.fromMap(Map<String, dynamic> json) => BranchManager(
      branchManagerID: json[BranchManagersDataModel.BRANCH_MANAGER_ID],
      branchManagerName: json[BranchManagersDataModel.BRANCH_MANAGER_NAME],
      branchManagerPhone: json[BranchManagersDataModel.BRANCH_MANAGER_PHONE],
      branchManagerEmail: json[BranchManagersDataModel.BRANCH_MANAGER_EMAIL],
       branchManagerTownOrcity: json[BranchManagersDataModel.BRANCH_MANAGER_TOWN_OR_CITY],
      branchManagerRating: double.tryParse(json[BranchManagersDataModel.BRANCH_MANAGER_RATING].toString()),
      branchID: json[BranchManagersDataModel.BRANCH_ID],
      branchName: json[BranchManagersDataModel.BRANCH_NAME],
      companyDocID: json[BranchManagersDataModel.COMPANY_FIRESTORE_ID],
      dateJoined: json[BranchManagersDataModel.DATE_JOINED],

      );

  Map<String, dynamic> toMap() => {
          BranchManagersDataModel.BRANCH_MANAGER_ID: branchManagerID,     
        BranchManagersDataModel.BRANCH_MANAGER_NAME: branchManagerName,
        BranchManagersDataModel.BRANCH_MANAGER_PHONE: branchManagerPhone,
        BranchManagersDataModel.BRANCH_MANAGER_EMAIL : branchManagerEmail,
         BranchManagersDataModel.BRANCH_MANAGER_TOWN_OR_CITY : branchManagerTownOrcity,
         BranchManagersDataModel.BRANCH_MANAGER_RATING : branchManagerRating,       
        BranchManagersDataModel.BRANCH_ID : branchID,
        BranchManagersDataModel.BRANCH_NAME: branchName,
        BranchManagersDataModel.COMPANY_FIRESTORE_ID : companyDocID,
        BranchManagersDataModel.DATE_JOINED: dateJoined,
 

      };

  BranchManager userFromJson(String str) {
    final jsonData = json.decode(str);
    return BranchManager.fromMap(jsonData);
  }

  String userToJson(BranchManager data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

  static bool toBool(input, {type = ''}) {
    return input == "true";
  }

  
}
