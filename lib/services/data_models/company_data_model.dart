



class CompanyDataModel {

  static const String DIRECTOR_FIREBASE_UID = "director_firebase_uid";
  static const String COMPANY_FIRESTORE_ID  = 'company_firestore_id';
  static const String COMPANY_NAME = "company_name";
  static const String COMPANY_TEL = "company_tel";
  static const String COMPANY_EMAIL = "company_email";
  static const String COMPANY_HEAD_OFFICE_LOCATION_NAME = "company_head_office_location_name";
  static const String COMPANY_HEAD_OFFICE_LAT = "company_head_office_lat";
  static const String COMPANY_HEAD_OFFICE_LNG = "company_head_office_lng";
  static const String DIRECTOR_NAME = 'director_name';
  static const String DIRECTOR_EMAIL = 'director_email';
  static const String DIRECTOR_TEL = 'director_tel';
  static const String CITY_OF_OPERATION = 'city_of_operation';
  static const String STREET_OF_OPERATION = 'street_of_operation';
  static const String EXPRESS_DELIVERY    = 'express_delivery';
  static const String BIKE_DELIVERY_TYPE = 'bike_delivery_type';
  static const String CAR_DELIVERY_TYPE = 'car_delivery_type';
  static const String DATE_JOINED = "date_joined";

  
}

class Company {
  String directorFirebaseUid;
  String companyFirestoreID;
  String companyName;
  String companyTel;
  String companyEmail;
  String companyCityOfOperation; 
  String companyStreetOfOperation;
  String companyHeadOfficeLocationName;
  String companyHeadOfficeLat;
  String companyHeadOfficeLng;
  String directorName;
  String directorEmail;
  String directorTel;
  bool bikeDeliveryType;
  bool carDeliveryType;
  bool expressDelivery;
  int dateJoined;

  
  


  Company(
      {
        this.directorFirebaseUid = '',
        this.companyFirestoreID ='',
        this.companyName = '',
        this.companyEmail = '',
        this.companyTel = '',
        this.companyCityOfOperation = '',
        this.companyStreetOfOperation = '',
        this.directorName = '',
        this.directorEmail = '',
        this.directorTel = '',
      
        this.bikeDeliveryType = false,
        this.carDeliveryType  = false,
        this.expressDelivery = false,
        this.companyHeadOfficeLocationName  ='',
        this.companyHeadOfficeLat = '',
        this.companyHeadOfficeLng ='',
        
        this.dateJoined = 0,
        
       
        });



  factory Company.fromMap(Map<String, dynamic> json) => Company(
      companyFirestoreID                     :json[CompanyDataModel.COMPANY_FIRESTORE_ID],
      directorFirebaseUid                        : json[CompanyDataModel.DIRECTOR_FIREBASE_UID],
      companyName                            : json[CompanyDataModel.COMPANY_NAME],
      companyEmail                           : json[CompanyDataModel.COMPANY_EMAIL],
      companyTel                             : json[CompanyDataModel.COMPANY_TEL],
      companyCityOfOperation                 : json[CompanyDataModel.CITY_OF_OPERATION],
      companyStreetOfOperation               : json[CompanyDataModel.STREET_OF_OPERATION],
      directorName                    : json[CompanyDataModel.DIRECTOR_NAME],
      directorEmail                   : json[CompanyDataModel.DIRECTOR_EMAIL],
      directorTel                     :json[CompanyDataModel.DIRECTOR_TEL],
      companyHeadOfficeLocationName       :json[CompanyDataModel.COMPANY_HEAD_OFFICE_LOCATION_NAME],
      companyHeadOfficeLat                   : json[CompanyDataModel.COMPANY_HEAD_OFFICE_LAT] ,
      companyHeadOfficeLng                   : json[CompanyDataModel.COMPANY_HEAD_OFFICE_LNG] ,
      bikeDeliveryType            : toBool(json[CompanyDataModel.BIKE_DELIVERY_TYPE]),
      carDeliveryType           : toBool(json[CompanyDataModel.CAR_DELIVERY_TYPE]),
      expressDelivery: toBool(json[CompanyDataModel.CAR_DELIVERY_TYPE]),
      dateJoined                                    :json[CompanyDataModel.DATE_JOINED]

      );

  Map<String, dynamic> toMap() => {
 CompanyDataModel.COMPANY_FIRESTORE_ID : companyFirestoreID,
 CompanyDataModel.DIRECTOR_FIREBASE_UID :directorFirebaseUid,
 CompanyDataModel.COMPANY_NAME:companyName,    
 CompanyDataModel.COMPANY_EMAIL:companyEmail,     
 CompanyDataModel.COMPANY_TEL:companyTel,    
 CompanyDataModel.CITY_OF_OPERATION:companyCityOfOperation,
 CompanyDataModel.STREET_OF_OPERATION:
     companyStreetOfOperation,
 CompanyDataModel.DIRECTOR_NAME:
     directorName,
 CompanyDataModel.EXPRESS_DELIVERY:fromBool(expressDelivery),
 CompanyDataModel.DIRECTOR_EMAIL:directorEmail,
 CompanyDataModel.DIRECTOR_TEL:directorTel,
CompanyDataModel.COMPANY_HEAD_OFFICE_LOCATION_NAME: companyHeadOfficeLocationName,
 CompanyDataModel.COMPANY_HEAD_OFFICE_LAT : companyHeadOfficeLat,    
 CompanyDataModel.COMPANY_HEAD_OFFICE_LNG :companyHeadOfficeLng,
 CompanyDataModel.BIKE_DELIVERY_TYPE:
     fromBool(bikeDeliveryType),
 CompanyDataModel.CAR_DELIVERY_TYPE:fromBool(carDeliveryType),

 CompanyDataModel.DATE_JOINED: dateJoined
      

      };



  static bool toBool(input, {type = ""}) {
    return input == 'true';
  }

  static String fromBool(input, {type = ""}) {
    return input ? 'true' : 'false';
  }
}




class CompanyStaffStatsDataModel{
  static const String TOTAl_NUMBER_OF_DIRECTORS = "total_number_of_directors";
  static const String TOTAL_NUMBER_OF_BRANCH_MANAGERS  = 'total_number_of_branch_managers';
  static const String TOTAL_NUMBER_OF_BRANCHES = "total_number_of_branches";
  static const String TOTAL_NUMBER_OF_DELIVERY_PERSONEL = "total_number_of_delivery_personel";
  static const String TOTAL_NUMBER_OF_OFFICE_PERSONEL = "total_number_of_office_personel";
  static const String TIMESTAMP = 'timestamp';

}

class CompanyStaffStats{

  int totalNumberOfDirectors;
  int totalNumberOfBranchManagers;
  int totalNumberOfBranches;
  int totalNumberOfDeliveryPersonel;
  int totalNumberOfOfficePersonel;
  int timestamp;

  CompanyStaffStats({
    this.totalNumberOfDirectors = 0,
    this.totalNumberOfBranchManagers = 0,
    this.totalNumberOfBranches = 0,
    this.totalNumberOfDeliveryPersonel = 0,
    this.totalNumberOfOfficePersonel = 0, 
    this.timestamp = 0
    });

    factory CompanyStaffStats.fromMap(Map<String,dynamic> map) => CompanyStaffStats(
     totalNumberOfDirectors:  map[CompanyStaffStatsDataModel.TOTAl_NUMBER_OF_DIRECTORS], totalNumberOfBranchManagers:  map[CompanyStaffStatsDataModel.TOTAL_NUMBER_OF_BRANCH_MANAGERS], totalNumberOfBranches:  map[CompanyStaffStatsDataModel.TOTAL_NUMBER_OF_BRANCHES], 
     totalNumberOfDeliveryPersonel:  map[CompanyStaffStatsDataModel.TOTAL_NUMBER_OF_DELIVERY_PERSONEL], totalNumberOfOfficePersonel:  map[CompanyStaffStatsDataModel.TOTAL_NUMBER_OF_OFFICE_PERSONEL], timestamp:  map[CompanyStaffStatsDataModel.TIMESTAMP],

    );
    
}
