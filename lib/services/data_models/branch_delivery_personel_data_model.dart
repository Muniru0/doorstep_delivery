



class DeliveryPersonelDataModel {

 static const String BRANCH_ID = 'branch_id';
 static const String IS_AFFILIATED_DELIVERY_PERSONEL = 'is_affiliated_branch_delivery_personel';
 static const String DELIVERY_PERSONEL_BRANCH_NAME = 'branch_name';
 static const String DELIVERY_PERSONEL_AVATAR_URL = 'branch_delivery_personel_avatar_url';
 static const String DELIVERY_PERSONEL_EMAIL = 'branch_delivery_personel_email';
 static const String DELIVERY_PERSONEL_ID = 'branch_delivery_personel_id';
 static const String DELIVERY_PERSONEL_NAME = 'branch_delivery_personel_name';
 static const String DELIVERY_PERSONEL_PHONE = 'branch_delivery_personel_phone';
 static const String DELIVERY_PERSONEL_GENDER = 'branch_delivery_personel_gender';
 static const String DELIVERY_PERSONEL_RATING = 'branch_delivery_personel_rating';
 static const String DELIVERY_PERSONEL_LOCATION_LAT = 'branch_delivery_personel_location_lat';
 static const String DELIVERY_PERSONEL_LOCATION_LNG = 'branch_delivery_personel_location_lng';
 static const String DISPATCH_VEHICLE_TYPE                  = 'dispatch_vehicle_type';
 static const String DISPATCH_VEHICLE_REGISTRATION_NUMBER        =  'dispatch_vehicle_registration_number';
 static const String DISPATCH_VEHICLE_MODEL                      = 'dispatch_vehicle_model';
 static const String DISPATCH_VEHICLE_BRAND                      = 'dispatch_vehicle_brand';
 static const String DELIVERY_PERSONEL_STATUS = 'branch_delivery_personel_status';
 static const String DELIVERY_PERSONEL_STATUS_EDITOR = 'branch_delivery_personel_status_editor';
 static const String DELIVERY_PERSONEL_TOWN_OR_CITY = 'branch_delivery_personel_town_or_city';
 static const String COMPANY_FIRESTORE_ID = 'company_firestore_id';
 static const String TIMESTAMP = 'timestamp';
 static const String TOTAL_NUMBER_OF_PARCELS_DELIVERD = 'total_number_of_parcels_delivered';
 static const String TOTAL_NUMBER_OF_UNSUCCESSFUL_DELIVERIES = 'total_number_of_unsuccessful_deliveries';

  
  





}

class DeliveryPersonel {
  String deliveryPersonelID;
  String deliveryPersonelName;
  String branchDeliveryPersonelAvatarUrl;
  String deliveryPersonelPhone;
  String deliveryPersonelEmail;
  String deliveryPersonelGender;
  int     totalNumberOfParcelsDelivered;
  String deliveryPersonelStatusEditor;
  String deliveryPersonelTownOrcity;
  String branchID;
  String companyDocID;
  String branchName; 
  int deliveryPersonelRating;
  double deliveryPersonelLocationLat;
  double deliveryPersonelLocationLng;
  bool isAffiliatedDeliveryPersonel;
  String deliveryPersonelStatus;
  int totalNumberOfUnsuccessfulDeliveries;
  String dispatchVehicleType;
  String dispatchVehicleRegistrationNumber;
  String dispatchVehicleBrand;
  String dispatchVehicleModel;
  int timestamp;



  DeliveryPersonel({
    this.deliveryPersonelID = '',
    this.deliveryPersonelName = '',
    this.branchDeliveryPersonelAvatarUrl = '',
    this.deliveryPersonelPhone = '',
    this.deliveryPersonelEmail = '',
    this.deliveryPersonelGender = '',
    this.totalNumberOfParcelsDelivered = 0,
    this.deliveryPersonelTownOrcity = '',
    this.deliveryPersonelStatusEditor = '',
    this.deliveryPersonelRating = 0,
    this.branchID = '',
    this.branchName = '',
    this.companyDocID = '',
    this.deliveryPersonelLocationLat = 0.0,
    this.deliveryPersonelLocationLng = 0.0,
    this.isAffiliatedDeliveryPersonel = false,
    this.deliveryPersonelStatus = 'idle',
    this.totalNumberOfUnsuccessfulDeliveries = 0,
    this.dispatchVehicleType = '',
    this.dispatchVehicleBrand = '',
    this.dispatchVehicleModel = '',
    this.dispatchVehicleRegistrationNumber = '',
    this.timestamp = 0
    
  });

  factory DeliveryPersonel.fromMap(Map<String, dynamic> json) => DeliveryPersonel(
      deliveryPersonelID: json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_ID],
      deliveryPersonelName: json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_NAME],
      branchDeliveryPersonelAvatarUrl: json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_AVATAR_URL],
      deliveryPersonelPhone: json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_PHONE],
      deliveryPersonelEmail: json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_EMAIL],
      totalNumberOfParcelsDelivered: json[DeliveryPersonelDataModel.TOTAL_NUMBER_OF_PARCELS_DELIVERD],
      deliveryPersonelTownOrcity: json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_TOWN_OR_CITY],
      deliveryPersonelGender: json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_GENDER],
      deliveryPersonelRating: json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_RATING],
      branchID: json[DeliveryPersonelDataModel.BRANCH_ID],
      branchName: json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_BRANCH_NAME],
      companyDocID: json[DeliveryPersonelDataModel.COMPANY_FIRESTORE_ID],
      deliveryPersonelStatusEditor : json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_STATUS_EDITOR],
      deliveryPersonelLocationLat:  double.tryParse(json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_LOCATION_LAT].toString())!,
      deliveryPersonelLocationLng: double.tryParse( json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_LOCATION_LNG].toString())!,
      deliveryPersonelStatus: json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_STATUS] ,
      isAffiliatedDeliveryPersonel: json[DeliveryPersonelDataModel.IS_AFFILIATED_DELIVERY_PERSONEL] ,
      totalNumberOfUnsuccessfulDeliveries: json[DeliveryPersonelDataModel.TOTAL_NUMBER_OF_UNSUCCESSFUL_DELIVERIES] ,
      dispatchVehicleType:  json[DeliveryPersonelDataModel.DISPATCH_VEHICLE_TYPE],
      dispatchVehicleModel: json[DeliveryPersonelDataModel.DISPATCH_VEHICLE_MODEL] ,
      dispatchVehicleBrand: json[DeliveryPersonelDataModel.DISPATCH_VEHICLE_BRAND] ,
      dispatchVehicleRegistrationNumber: json[DeliveryPersonelDataModel.DISPATCH_VEHICLE_REGISTRATION_NUMBER],
      timestamp: json[DeliveryPersonelDataModel.TIMESTAMP],

      );

  Map<String, dynamic> toMap() => {
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_ID: deliveryPersonelID,     
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_NAME: deliveryPersonelName,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_AVATAR_URL: branchDeliveryPersonelAvatarUrl,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_PHONE: deliveryPersonelPhone,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_EMAIL : deliveryPersonelEmail,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_GENDER : deliveryPersonelGender,
        DeliveryPersonelDataModel.TOTAL_NUMBER_OF_PARCELS_DELIVERD : totalNumberOfParcelsDelivered,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_TOWN_OR_CITY : deliveryPersonelTownOrcity,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_RATING : deliveryPersonelRating,       
        DeliveryPersonelDataModel.BRANCH_ID : branchID,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_BRANCH_NAME: branchName,
        DeliveryPersonelDataModel.COMPANY_FIRESTORE_ID : companyDocID,
        DeliveryPersonelDataModel.IS_AFFILIATED_DELIVERY_PERSONEL:isAffiliatedDeliveryPersonel,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_LOCATION_LAT : deliveryPersonelLocationLat,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_LOCATION_LNG: deliveryPersonelLocationLng,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_STATUS:deliveryPersonelStatus,
         DeliveryPersonelDataModel.DELIVERY_PERSONEL_STATUS_EDITOR:deliveryPersonelStatusEditor,
        DeliveryPersonelDataModel.TOTAL_NUMBER_OF_UNSUCCESSFUL_DELIVERIES:totalNumberOfUnsuccessfulDeliveries,
        DeliveryPersonelDataModel.DISPATCH_VEHICLE_TYPE : dispatchVehicleType,
        DeliveryPersonelDataModel.DISPATCH_VEHICLE_BRAND:dispatchVehicleBrand,
        DeliveryPersonelDataModel.DISPATCH_VEHICLE_MODEL:dispatchVehicleModel,
        DeliveryPersonelDataModel.DISPATCH_VEHICLE_REGISTRATION_NUMBER:dispatchVehicleRegistrationNumber,
        DeliveryPersonelDataModel.TIMESTAMP: timestamp,
 

      };

  

 static String fromBool(input){
    return input ? 'true': 'false';
  }

  static bool toBool(input){
    return input == 'true';
  }



}


