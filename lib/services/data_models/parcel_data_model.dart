import 'dart:convert';

class ParcelsDataModel {
  static const String USER_DOC_ID = 'user_docID';
  static const String DISPATCH_USER_ID = 'dispatch_user_id';
  static const String COURIER_SERVICE = 'courier_service';
  static const String COURIER_SELECTION_TYPE = 'courier_selection_type';
  static const String PARCEL_DOC_ID = 'parcelDocID';
  static const String PARCEL_CODE = 'parcel_code';
  static const String SENDER_FULLNAME = 'sender_fullname';
  static const String SENDER_PHONE_NUMBER = 'sender_phone_number';
  static const String RECEIPIENT_FULLNAME = 'receipient_fullname';
  static const String RECEIPIENT_PHONE_NUMBER = 'receipient_phone_number';
  static const String TRANSIT_PROGRESS = 'transit_progress';
  static const String PARCEL_PRICE = 'parcel_price';
  static const String PARCEL_PAYMENT_STATUS = 'parcel_payment_status';
  static const String PARCEL_SIZE = 'parcel_size';
  static const String PARCEL_WEIGHT = 'parcel_weight';
  static const String PICKUP_TIME = 'pickup_time';
  static const String PARCEL_DEPOSIT_TIME = 'parcel_deposit_time';
  static const String PARCEL_DEPOSIT_LOCATION = 'parcel_deposit_location';
  static const String PARCEL_DEPOSIT_FARE = 'parcel_deposit_fare';
  static const String PARCEL_DELIVERY_FARE = 'parcel_delivery_fare';
  static const String PARCEL_DELIVERY_DISTANCE = 'parcel_delivery_distance';
  static const String PARCEL_DEPARTURE_TIME = 'parcel_departure_time';
  static const String PARCEL_IN_TRANSIT_TIME = 'parcel_in_transit_time';
  static const String PARCEL_REACHED_DESTINATION_TIME = 'parcel_reached_destination_time';
  static const String DELIVERY_LONGITUDE = 'delivery_longitude';
  static const String DELIVERY_LATITUDE = 'delivery_latitude';
  static const String DELIVERY_LOCATION_NAME = 'delivery_location_name';
  static const String PARCEL_DELIVERY_TIME = 'parcel_delivery_time';
  static const String PARCEL_TYPE = 'parcel_type';
  static const String PARCELS_QUANTITY = 'parcels_quantity';
  static const String PARCEL_DESTINATION_PLACE_ID  = 'parcel_destination_place_id';
  static const String PARCEL_PICKUP_LOCATION_PLACE_ID  = 'parcel_pickup_location_place_id';
  static const String PARCEL_PAYMENT = 'parcel_payment';
  static const String SENDER_LOCATION_ADDRESS = 'sender_location_address';
  static const String RECEIPIENT_LOCATION_ADDRESS = 'receipient_location_address';
  static const String PARCEL_DELIVERY_TYPE = 'parcel_delivery_type';
  static const String PARCEL_PICKUP_LOCATION_LAT = 'parcel_pickup_location_lat';
  static const String PARCEL_PICKUP_LOCATION_LNG = 'parcel_pickup_location_lng';
  static const String PARCEL_PICKUP_LOCATION_ADDRESS = 'parcel_pickup_locaiton_address';
  static const String PARCEL_DESTINATION_ADDRESS = 'parcel_destination_address';
  static const String PARCEL_DESTINATION_LAT = 'parcel_destination_lat';
  static const String PARCEL_DESTINATION_LNG = 'parcel_destination_lng';
  static const String  DATE_CREATED = 'date_created';



}

class Parcel {
  String userDocID;
  String dispatchUserID;
  String courierService;
  String courierSelectionType;
  String parcelDocID;
  String parcelCode;
  String parcelPickupcode;
  String senderFullname;
  String senderPhoneNumber;
  String receipientFullname;
  String receipientPhoneNumber;
  String parcelPickupLocationAddress;
  String parcelDestinationAddress;
  String transitProgress;
  int    parcelPrice;
  int    parcelPayer;
  int    parcelSize;
  int    pickUpTime;
  int    parcelDepositTime;
  int    parcelDepositFare;
  double    parcelDeliveryFare;
  int parcelDepartureTime;
  int parcelInTransitTime;
  int parcelReachedDestinationTime;
  double parcelDeliveryTime;
  String  parcelType;
  int parcelsQuantity;
  int parcelDeliveryType;
  double parcelPickupLocationLat;
  double parcelPickupLocationLng;
  double parcelDestinationLat;
  double parcelDestinationLng;
  int parcelPaymentStatus;


 

  Parcel(
      {
this.userDocID = '',
this.dispatchUserID = '',
this.courierService = '',
this.courierSelectionType = '',
this.parcelDocID = '',
this.parcelPickupcode = '',
this.parcelDeliveryFare = 0.0,
this.parcelCode = '',
this.senderFullname = '',
this.senderPhoneNumber = '',
this.receipientFullname = '',
this.receipientPhoneNumber = '',
this.parcelPickupLocationAddress = 'pick up ',
this.parcelPickupLocationLat = 0.0,
this.parcelPickupLocationLng = 0.0,
this.parcelDestinationAddress = 'destination address',
this.parcelDestinationLat = 0.0,
this.parcelDestinationLng = 0.0,
this.transitProgress = '',
this.parcelPrice = 0,
this.parcelPayer = 0,
this.parcelSize = 0,
this.pickUpTime = 0,
this.parcelDepositTime = 0,
this.parcelDepositFare = 0,
this.parcelDepartureTime = 0,
this.parcelInTransitTime = 0,
this.parcelReachedDestinationTime = 0,
this.parcelDeliveryTime = 0.0,
this.parcelType = '', 
this.parcelsQuantity = 1,
this.parcelDeliveryType = 0,
this.parcelPaymentStatus = 0
      });

  factory Parcel.fromMap(Map<String, dynamic> json) => Parcel(
      userDocID: json[ParcelsDataModel.USER_DOC_ID],
      dispatchUserID: json[ParcelsDataModel.DISPATCH_USER_ID],
      courierService: json[ParcelsDataModel.COURIER_SERVICE ],
      courierSelectionType: json[ParcelsDataModel.COURIER_SELECTION_TYPE],
      parcelDocID: json[ParcelsDataModel.PARCEL_DOC_ID],
      senderFullname: json[ParcelsDataModel.SENDER_FULLNAME],
      senderPhoneNumber: json[ParcelsDataModel.SENDER_PHONE_NUMBER],
      receipientFullname: json[ParcelsDataModel.RECEIPIENT_FULLNAME],
      receipientPhoneNumber: json[ParcelsDataModel.RECEIPIENT_PHONE_NUMBER],
      parcelPickupLocationAddress: json[ParcelsDataModel.PARCEL_PICKUP_LOCATION_ADDRESS],
      parcelDestinationAddress: json[ParcelsDataModel.PARCEL_DESTINATION_ADDRESS],
      transitProgress: json[ParcelsDataModel.TRANSIT_PROGRESS],
      parcelPrice: json[ParcelsDataModel.PARCEL_PRICE],
      parcelSize: json[ParcelsDataModel.PARCEL_SIZE],
      parcelPickupLocationLat: json[ParcelsDataModel.PARCEL_PICKUP_LOCATION_LAT],
      parcelPickupLocationLng: json[ParcelsDataModel.PARCEL_PICKUP_LOCATION_LNG],
      pickUpTime: json[ParcelsDataModel.PICKUP_TIME],
      parcelDepositTime: json[ParcelsDataModel.PARCEL_DEPOSIT_TIME],
      parcelDepartureTime: json[ParcelsDataModel.PARCEL_DEPARTURE_TIME],
      parcelInTransitTime : json[ParcelsDataModel.PARCEL_IN_TRANSIT_TIME],
      parcelReachedDestinationTime: json[ParcelsDataModel.PARCEL_REACHED_DESTINATION_TIME],
      parcelDeliveryTime: json[ParcelsDataModel.PARCEL_DELIVERY_TIME],
      parcelDepositFare: json[ParcelsDataModel.PARCEL_DEPOSIT_FARE],
      parcelType            : json[ParcelsDataModel.PARCEL_TYPE],
      parcelsQuantity : json[ParcelsDataModel.PARCELS_QUANTITY],
      parcelPayer:  json[ParcelsDataModel.PARCEL_PAYMENT],
      parcelDeliveryType:  json[ParcelsDataModel.PARCEL_DELIVERY_TYPE],
      parcelPaymentStatus: json[ParcelsDataModel.PARCEL_PAYMENT_STATUS]

      
      

);

  Map<String, dynamic> toMap() => {
        ParcelsDataModel.USER_DOC_ID: userDocID,
        ParcelsDataModel.DISPATCH_USER_ID : dispatchUserID,
        ParcelsDataModel.COURIER_SERVICE: courierService,
        ParcelsDataModel.COURIER_SELECTION_TYPE : courierSelectionType,
        ParcelsDataModel.PARCEL_CODE: parcelCode,
        ParcelsDataModel.PARCEL_DOC_ID : parcelDocID,
        ParcelsDataModel.SENDER_FULLNAME: senderFullname,
        ParcelsDataModel.SENDER_PHONE_NUMBER : senderPhoneNumber,
        ParcelsDataModel.RECEIPIENT_FULLNAME: receipientFullname,
        ParcelsDataModel.RECEIPIENT_PHONE_NUMBER: receipientPhoneNumber,
        ParcelsDataModel.PARCEL_PICKUP_LOCATION_ADDRESS : parcelPickupLocationAddress,
        ParcelsDataModel.PARCEL_PICKUP_LOCATION_LAT : parcelPickupLocationLat,
        ParcelsDataModel.PARCEL_PICKUP_LOCATION_LNG : parcelPickupLocationLng,
        ParcelsDataModel.PARCEL_DESTINATION_ADDRESS: parcelDestinationAddress,
        ParcelsDataModel.PARCEL_DESTINATION_LAT: parcelDestinationLat,
        ParcelsDataModel.PARCEL_DESTINATION_LNG: parcelDestinationLng,
        ParcelsDataModel.TRANSIT_PROGRESS: transitProgress,
        ParcelsDataModel.PARCEL_PRICE: parcelPrice,
        ParcelsDataModel.PARCEL_SIZE: parcelSize,
        ParcelsDataModel.PICKUP_TIME:pickUpTime,
        ParcelsDataModel.PARCEL_DEPARTURE_TIME: parcelDepositTime,
        ParcelsDataModel.PARCEL_IN_TRANSIT_TIME: parcelInTransitTime,
        ParcelsDataModel.PARCEL_REACHED_DESTINATION_TIME : parcelReachedDestinationTime,
        ParcelsDataModel.PARCEL_DELIVERY_TIME: parcelDeliveryTime,
        ParcelsDataModel.PARCEL_DEPOSIT_FARE : parcelDepositFare,
        ParcelsDataModel.PARCEL_DELIVERY_FARE : parcelDeliveryFare,
        ParcelsDataModel.PARCEL_TYPE : parcelType,
        ParcelsDataModel.PARCELS_QUANTITY : parcelsQuantity,
        ParcelsDataModel.PARCEL_PAYMENT : parcelPayer,
        ParcelsDataModel.PARCEL_DELIVERY_TYPE : parcelDeliveryType,
        ParcelsDataModel.PARCEL_PAYMENT_STATUS :parcelPaymentStatus
        

     
      };

  Parcel userFromJson(String str) {
    final jsonData = json.decode(str);
    return Parcel.fromMap(jsonData);
  }

  String userToJson(Parcel data) {
    final dyn = data.toMap();
    return json.encode(dyn);
  }

  static bool toBool(input, {type = ''}) {
    return input == 1;
  }

  static bool fromBool(input) {
    return input == 'true';
  }
}
