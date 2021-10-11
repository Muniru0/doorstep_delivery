


class CompanyBranchDataModel {
  static const String COMPANY_FIRESTORE_ID = 'company_firestore_id';
  static const String COMPANY_BRANCH_ID = 'company_branch_id';
  static const String COMPANY_BRANCH_NAME = "company_branch_name";
  static const String COMPANY_BRANCH_MANAGER_ID = "branch_manager_id";
  static const String COMPANY_BRANCH_MANAGER_NAME = "company_branch_manager_name";
  static const String COMPANY_BRANCH_MANAGER_GENDER = "company_branch_manager_gender";
  static const String COMPANY_BRANCH_MANAGER_PHONE = "company_branch_manager_phone";
  static const String COMPANY_BRANCH_MANAGER_EMAIL = "company_branch_manager_email";
  static const String COMPANY_BRANCH_ADDRESS = "company_branch_address";
  static const String COMPANY_BRANCH_CITY_OR_TOWN = "company_branch_city_or_town";
  static const String NUMBER_OF_DESTINATIONS = 'number_of_destinations';
  static const String TOTAL_NUMBER_OF_PARCELS_SENT = 'total_number_of_parcels_sent';
  static const String TOTAL_NUMBER_OF_PARCELS_RECEIVED = 'total_number_of_parcels_received';
  static const String TOTAL_NUMBER_OF_PARCELS_DELIVERED = 'total_number_of_parcels_delivered';
  static const String TOTAL_AMOUNT_OF_PARCELS_SENT = 'total_amount_of_parcels_sent';
  static const String TOTAL_AMOUNT_OF_PARCELS_RECEIVED = 'total_amount_of_parcels_received';
  static const String TOTAL_AMOUNT_OF_PARCELS_DELIVERED = 'total_amount_of_parcels_delivered';
  static const String TIMESTAMP = 'timestamp';




  
}



class CompanyBranch {
  String companyFirestoreID;
  String companyBranchID;
  String companyBranchName;
  String companyBranchManagerID;
  String companyBranchManagerName;
  String companyBranchManagerEmail;
  String companyBranchManagerTel;
  String companyBranchManagerGender;
  String companyBranchCityOrTown;
  String companyBranchAddress;
  int    numberOfDestinations;
  int totalNumberOfParcelsSent;
  int totalNumberOfParcelsReceived;
  int totalNumberOfParcelsDelivered;
  int totalAmountOfParcelsSent;
  int totalAmountOfParcelsReceived;
  int totalAmountOfParcelsDelivered;
  int timestamp;
  
  CompanyBranch(
      {
        this.companyBranchID = '',
        this.companyFirestoreID = '',
        this.companyBranchName = '',
        this.companyBranchManagerID = '',
        this.companyBranchManagerName = '',
        this.companyBranchManagerEmail = '',
        this.companyBranchManagerTel = '',
        this.companyBranchCityOrTown = '',
        this.companyBranchManagerGender = '',
        this.companyBranchAddress = '',
        this.numberOfDestinations = 0,
        this.totalAmountOfParcelsDelivered =0,
        this.totalAmountOfParcelsReceived = 0,
        this.totalAmountOfParcelsSent = 0,
        this.totalNumberOfParcelsReceived =0 ,
        this.totalNumberOfParcelsSent = 0,
        this.totalNumberOfParcelsDelivered = 0,
        this.timestamp = 0,
        });

  factory CompanyBranch.fromMap(Map<String, dynamic> json) => CompanyBranch(
      companyFirestoreID: json[CompanyBranchDataModel.COMPANY_FIRESTORE_ID],
      companyBranchID: json[CompanyBranchDataModel.COMPANY_BRANCH_ID],
      companyBranchName: json[CompanyBranchDataModel.COMPANY_BRANCH_NAME],
      companyBranchManagerID: json[CompanyBranchDataModel.COMPANY_BRANCH_MANAGER_ID],
      companyBranchManagerName: json[CompanyBranchDataModel.COMPANY_BRANCH_MANAGER_NAME],
      companyBranchManagerEmail: json[CompanyBranchDataModel.COMPANY_BRANCH_MANAGER_EMAIL ],
      companyBranchManagerTel: json[CompanyBranchDataModel.COMPANY_BRANCH_MANAGER_PHONE],
      companyBranchManagerGender: json[CompanyBranchDataModel.COMPANY_BRANCH_MANAGER_GENDER],
      companyBranchCityOrTown: json[CompanyBranchDataModel.COMPANY_BRANCH_CITY_OR_TOWN],
      companyBranchAddress: json[CompanyBranchDataModel.COMPANY_BRANCH_ADDRESS],
      numberOfDestinations: json[CompanyBranchDataModel.NUMBER_OF_DESTINATIONS],
      totalNumberOfParcelsSent: json[CompanyBranchDataModel.TOTAL_NUMBER_OF_PARCELS_SENT],
      totalNumberOfParcelsReceived: json[CompanyBranchDataModel.TOTAL_NUMBER_OF_PARCELS_RECEIVED],
      totalNumberOfParcelsDelivered: json[CompanyBranchDataModel.TOTAL_NUMBER_OF_PARCELS_DELIVERED],
       totalAmountOfParcelsSent: json[CompanyBranchDataModel.TOTAL_AMOUNT_OF_PARCELS_SENT],     
      totalAmountOfParcelsReceived: json[CompanyBranchDataModel.TOTAL_AMOUNT_OF_PARCELS_RECEIVED],
       totalAmountOfParcelsDelivered: json[CompanyBranchDataModel.TOTAL_AMOUNT_OF_PARCELS_DELIVERED],
      timestamp: json[CompanyBranchDataModel.TIMESTAMP ],
     
      );



  Map<String, dynamic> toMap() => {
        CompanyBranchDataModel.COMPANY_FIRESTORE_ID : companyFirestoreID,
        CompanyBranchDataModel.COMPANY_BRANCH_ID : companyBranchID,
        CompanyBranchDataModel.COMPANY_BRANCH_NAME : companyBranchName,
                CompanyBranchDataModel.COMPANY_BRANCH_MANAGER_ID : companyBranchManagerID,
        CompanyBranchDataModel.COMPANY_BRANCH_MANAGER_NAME: companyBranchManagerName,
        CompanyBranchDataModel.COMPANY_BRANCH_MANAGER_EMAIL: companyBranchManagerEmail,
        CompanyBranchDataModel.COMPANY_BRANCH_MANAGER_PHONE: companyBranchManagerTel,
        CompanyBranchDataModel.COMPANY_BRANCH_MANAGER_GENDER: companyBranchManagerGender,
        CompanyBranchDataModel.COMPANY_BRANCH_CITY_OR_TOWN: companyBranchCityOrTown,
        CompanyBranchDataModel.COMPANY_BRANCH_ADDRESS: companyBranchAddress,
        CompanyBranchDataModel.NUMBER_OF_DESTINATIONS: numberOfDestinations,
        CompanyBranchDataModel.TOTAL_NUMBER_OF_PARCELS_SENT: totalNumberOfParcelsSent,
        CompanyBranchDataModel.TOTAL_NUMBER_OF_PARCELS_RECEIVED: totalNumberOfParcelsReceived,
        CompanyBranchDataModel.TOTAL_NUMBER_OF_PARCELS_DELIVERED: totalNumberOfParcelsDelivered,
        CompanyBranchDataModel.TOTAL_AMOUNT_OF_PARCELS_SENT: totalAmountOfParcelsSent,
        CompanyBranchDataModel.TOTAL_AMOUNT_OF_PARCELS_RECEIVED: totalAmountOfParcelsReceived,
        CompanyBranchDataModel.TOTAL_AMOUNT_OF_PARCELS_DELIVERED: totalAmountOfParcelsDelivered,
        CompanyBranchDataModel.TIMESTAMP: timestamp,
       
       
      };

  static bool toBool(input, {type = ""}) {
    return input == 1;
  }
}

