// const branchOfficePersonelData = {

//         'branch_name': companyBranchName,
//         'BRANCH_ID':companyBranchID,
//         "date_joined":timestamp
//       };

import 'dart:convert';

class BranchOfficePersonelDataModel {

 static const String BRANCH_ID = 'branch_id';
 static const String BRANCH_NAME = 'branch_name';
 static const String BRANCH_OFFICE_PERSONEL_EMAIL = 'branch_office_personel_email';
 static const String BRANCH_OFFICE_PERSONEL_ID = 'branch_office_personel_id';
 static const String BRANCH_OFFICE_PERSONEL_NAME = 'branch_office_personel_name';
 static const String BRANCH_OFFICE_PERSONEL_PHONE = 'branch_office_personel_phone';
 static const String BRANCH_OFFICE_PERSONEL_RATING = 'branch_office_personel_rating';
 static const String BRANCH_OFFICE_PERSONEL_TOWN_OR_CITY = 'branch_office_personel_town_or_city';
 static const String COMPANY_FIRESTORE_ID = 'company_firestore_id';
 static const String DATE_JOINED = 'date_joined';
 static const String TOTAL_NUMBER_OF_PARCELS_RECEIVED = 'total_number_of_parcels_received';
 static const String TOTAL_NUMBER_OF_PARCELS_SENT = 'total_number_of_parcels_sent';
  
  





}

class BranchOfficePersonel {
  String branchOfficePersonelID;
  String branchOfficePersonelName;
  String branchOfficePersonelPhone;
  String branchOfficePersonelEmail;
  int     totalNumberOfParcelsSent;
  int     totalNumberOfParcelsReceived;
  String branchOfficePersonelTownOrcity;
  String branchID;
  String companyDocID;
  String branchName; 
  double? branchOfficePersonelRating;
  int dateJoined;



  BranchOfficePersonel({
    this.branchOfficePersonelID = '',
    this.branchOfficePersonelName = '',
    this.branchOfficePersonelPhone = '',
    this.branchOfficePersonelEmail = '',
    this.totalNumberOfParcelsSent = 0,
    this.totalNumberOfParcelsReceived = 0,
    this.branchOfficePersonelTownOrcity = '',
    this.branchOfficePersonelRating = 0.0,
    this.branchID = '',
    this.branchName = '',
    this.companyDocID = '',
    this.dateJoined = 0
    
  });

  factory BranchOfficePersonel.fromMap(Map<String, dynamic> json) => BranchOfficePersonel(
      branchOfficePersonelID: json[BranchOfficePersonelDataModel.BRANCH_OFFICE_PERSONEL_ID],
      branchOfficePersonelName: json[BranchOfficePersonelDataModel.BRANCH_OFFICE_PERSONEL_NAME],
      branchOfficePersonelPhone: json[BranchOfficePersonelDataModel.BRANCH_OFFICE_PERSONEL_PHONE],
      branchOfficePersonelEmail: json[BranchOfficePersonelDataModel.BRANCH_OFFICE_PERSONEL_EMAIL],
      totalNumberOfParcelsSent: json[BranchOfficePersonelDataModel.TOTAL_NUMBER_OF_PARCELS_SENT],
      totalNumberOfParcelsReceived: json[BranchOfficePersonelDataModel.TOTAL_NUMBER_OF_PARCELS_RECEIVED],
      branchOfficePersonelTownOrcity: json[BranchOfficePersonelDataModel.BRANCH_OFFICE_PERSONEL_TOWN_OR_CITY],
      branchOfficePersonelRating: double.tryParse(json[BranchOfficePersonelDataModel.BRANCH_OFFICE_PERSONEL_RATING].toString()),
      branchID: json[BranchOfficePersonelDataModel.BRANCH_ID],
      branchName: json[BranchOfficePersonelDataModel.BRANCH_NAME],
      companyDocID: json[BranchOfficePersonelDataModel.COMPANY_FIRESTORE_ID],
      dateJoined: json[BranchOfficePersonelDataModel.DATE_JOINED],

      );

  Map<String, dynamic> toMap() => {
          BranchOfficePersonelDataModel.BRANCH_OFFICE_PERSONEL_ID: branchOfficePersonelID,     
        BranchOfficePersonelDataModel.BRANCH_OFFICE_PERSONEL_NAME: branchOfficePersonelName,
        BranchOfficePersonelDataModel.BRANCH_OFFICE_PERSONEL_PHONE: branchOfficePersonelPhone,
        BranchOfficePersonelDataModel.BRANCH_OFFICE_PERSONEL_EMAIL : branchOfficePersonelEmail,
         BranchOfficePersonelDataModel.TOTAL_NUMBER_OF_PARCELS_SENT : totalNumberOfParcelsSent,
          BranchOfficePersonelDataModel.TOTAL_NUMBER_OF_PARCELS_RECEIVED : totalNumberOfParcelsReceived,
         BranchOfficePersonelDataModel.BRANCH_OFFICE_PERSONEL_TOWN_OR_CITY : branchOfficePersonelTownOrcity,
         BranchOfficePersonelDataModel.BRANCH_OFFICE_PERSONEL_RATING : branchOfficePersonelRating,       
        BranchOfficePersonelDataModel.BRANCH_ID : branchID,
        BranchOfficePersonelDataModel.BRANCH_NAME: branchName,
        BranchOfficePersonelDataModel.COMPANY_FIRESTORE_ID : companyDocID,
        BranchOfficePersonelDataModel.DATE_JOINED: dateJoined,
 

      };

  
}
