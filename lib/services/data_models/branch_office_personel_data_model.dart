

class DeliveryPersonelDataModel {

 static const String BRANCH_ID = 'branch_id';
static const String IS_AFFILIATED_DELIVERY_PERSONEL = 'is_affiliated_delivery_personel';
 static const String DELIVERY_PERSONEL_BRANCH_NAME = 'branch_name';
 static const String DELIVERY_PERSONEL_AVATAR_URL = 'branch_delivery_personel_avatar_url';
 static const String DELIVERY_PERSONEL_EMAIL = 'branch_office_personel_email';
 static const String DELIVERY_PERSONEL_ID = 'branch_office_personel_id';
 static const String DELIVERY_PERSONEL_NAME = 'branch_office_personel_name';
 static const String DELIVERY_PERSONEL_PHONE = 'branch_office_personel_phone';
 static const String DELIVERY_PERSONEL_RATING = 'branch_office_personel_rating';
 static const String DELIVERY_PERSONEL_TOWN_OR_CITY = 'branch_office_personel_town_or_city';
 static const String COMPANY_FIRESTORE_ID = 'company_firestore_id';
 static const String TIMESTAMP = 'timestamp';
 static const String TOTAL_NUMBER_OF_PARCELS_DELIVERD = 'total_number_of_parcels_received';

  
  





}

class DeliveryPersonel {
  String deliveryPersonelID;
  String deliveryPersonelName;
  String branchDeliveryPersonelAvatarUrl;
  String deliveryPersonelPhone;
  String deliveryPersonelEmail;
  int     totalNumberOfParcelsDelivered;
  String deliveryPersonelTownOrcity;
  String branchID;
  String companyDocID;
  String branchName; 
  double? deliveryPersonelRating;
  bool isAffiliatedDeliveryPersonel;
  int timestamp;



  DeliveryPersonel({
    this.deliveryPersonelID = '',
    this.deliveryPersonelName = '',
    this.branchDeliveryPersonelAvatarUrl = '',
    this.deliveryPersonelPhone = '',
    this.deliveryPersonelEmail = '',
    this.totalNumberOfParcelsDelivered = 0,
    this.deliveryPersonelTownOrcity = '',
    this.deliveryPersonelRating = 0.0,
    this.branchID = '',
    this.branchName = '',
    this.companyDocID = '',
    this.isAffiliatedDeliveryPersonel = false,
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
      deliveryPersonelRating: double.tryParse(json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_RATING].toString()),
      branchID: json[DeliveryPersonelDataModel.BRANCH_ID],
      branchName: json[DeliveryPersonelDataModel.DELIVERY_PERSONEL_BRANCH_NAME],
      companyDocID: json[DeliveryPersonelDataModel.COMPANY_FIRESTORE_ID],
      timestamp: json[DeliveryPersonelDataModel.TIMESTAMP],

      );

  Map<String, dynamic> toMap() => {
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_ID: deliveryPersonelID,     
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_NAME: deliveryPersonelName,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_AVATAR_URL: branchDeliveryPersonelAvatarUrl,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_PHONE: deliveryPersonelPhone,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_EMAIL : deliveryPersonelEmail,
        DeliveryPersonelDataModel.TOTAL_NUMBER_OF_PARCELS_DELIVERD : totalNumberOfParcelsDelivered,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_TOWN_OR_CITY : deliveryPersonelTownOrcity,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_RATING : deliveryPersonelRating,       
        DeliveryPersonelDataModel.BRANCH_ID : branchID,
        DeliveryPersonelDataModel.DELIVERY_PERSONEL_BRANCH_NAME: branchName,
        DeliveryPersonelDataModel.COMPANY_FIRESTORE_ID : companyDocID,
        DeliveryPersonelDataModel.IS_AFFILIATED_DELIVERY_PERSONEL:isAffiliatedDeliveryPersonel,
        DeliveryPersonelDataModel.TIMESTAMP: timestamp,
 

      };

  
}
