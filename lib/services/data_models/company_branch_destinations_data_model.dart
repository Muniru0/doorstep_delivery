




class CompanyBranchDestinationDataModel {
  static const String BRANCH_NAME = "company_branch_name";
  static const String COMPANY_BRANCH_FIRESTORE_ID = 'company_branch_firestore_id';

  static const String DESTINATION_NAME = "destination_name";
  static const String MIN_PARCEL_PRICE = "min_parcel_price";
  static const String DATE_ADDED = "date_added";
  
}

class CompanyBranchDestination {
  String branchName;
  String companyBranchFirestoreID;
  String destinationName;
  String minParcelPrice;
  String dateAdded;

 
  
  CompanyBranchDestination(
      {
        this.branchName = '',
        this.companyBranchFirestoreID = '',
        this.destinationName = '',
        this.minParcelPrice = '',
        this.dateAdded = '',

       
        });

  factory CompanyBranchDestination.fromMap(Map<String, dynamic> json) => CompanyBranchDestination(
      branchName: json[CompanyBranchDestinationDataModel.BRANCH_NAME ],
      companyBranchFirestoreID: json[CompanyBranchDestinationDataModel.COMPANY_BRANCH_FIRESTORE_ID],
      destinationName: json[CompanyBranchDestinationDataModel.DESTINATION_NAME],
      minParcelPrice: json[CompanyBranchDestinationDataModel.MIN_PARCEL_PRICE],
      dateAdded: json[CompanyBranchDestinationDataModel.DATE_ADDED],
     
      
      );

  Map<String, dynamic> toMap() => {
        CompanyBranchDestinationDataModel.BRANCH_NAME  : branchName,
        CompanyBranchDestinationDataModel.COMPANY_BRANCH_FIRESTORE_ID  : companyBranchFirestoreID,
        CompanyBranchDestinationDataModel.DESTINATION_NAME : destinationName,
        CompanyBranchDestinationDataModel.MIN_PARCEL_PRICE : minParcelPrice,
        CompanyBranchDestinationDataModel.DATE_ADDED: dateAdded,

       
      };

  static bool toBool(input, {type = ""}) {
    return input == 1;
  }
}

