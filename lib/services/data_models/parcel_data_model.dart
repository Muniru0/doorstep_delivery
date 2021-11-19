import 'dart:convert';

class ParcelDataModel {
  static const String USER_DOC_ID = 'user_docID';
  static const String DISPATCH_USER_ID = 'dispatch_user_id';
  static const String COURIER_SERVICE_DOC_ID = 'courier_service_doc_id';
  static const String COURIER_SERVICE_NAME   = 'courier_service_name';
  static const String COURIER_SERVICE = 'courier_service';
  static const String COURIER_SELECTION_TYPE = 'courier_selection_type';
  static const String PARCEL_DOC_ID = 'parcelDocID';
  static const String PARCEL_CODE = 'parcel_code';
  static const String SENDER_FULLNAME = 'sender_fullname';
  static const String SENDER_PHONE_NUMBER = 'sender_phone_number';
  static const String RECEIPIENT_FULLNAME = 'receipient_fullname';
  static const String RECEIPIENT_PHONE_NUMBER = 'receipient_phone_number';
  static const String PARCEL_PRICE = 'parcel_price';
  static const String PARCEL_PAYMENT_STATUS = 'parcel_payment_status';
  static const String PARCEL_SIZE = 'parcel_size';
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
  static const String PARCEL_DESTINATION_STATE = 'parcel_destination_state';
  static const String PARCEL_DELIVERY_STATUS = 'delivery_status';
  static const String PARCEL_DELIVERY_PERSONEL_NAME = 'delivery_personel_name';
  static const String PARCEL_DELIVERY_PERSONEL_RATING = 'delivery_personel_rating';
  

  static const String PARCEL_PICKUP_CODE = 'parcel_pickup_code';
  static const String PARCEL_SENDING_BRANCH_ID = 'parcel_sending_branch_id';
  static const String PARCEL_RECEIVING_BRANCH_ID = 'parcel_receiving_branch_id';


  static const String  TIMESTAMP = 'timestamp';

  static const String PARCEL_SENDING_TIME = 'parcel_sending_time';

  static const String PARCEL_ORDER_PLACEMENT_TIME = 'parcel_order_placement_time';

  static const String PARCEL_PICKUP_TIME = 'parcel_pickup_time';
  static const String PARCEL_PROCESSING_TIME = 'parcel_processing_time';

  static const String PARCEL_DELIVERY_REQUEST_STATUS ='parcel_delivery_request_status';

  

}

class Parcel {
  String userDocID;
  String dispatchUserID;
  String courierServiceDocID;
  String courierServiceName;
  String courierSelectionType;
  String parcelDocID;
  String parcelCode;
  String parcelPickupCode;
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
  int parcelDeliveryTime;
  String  parcelType;
  int parcelsQuantity;
  int parcelDeliveryType;
  double parcelPickupLocationLat;
  double parcelPickupLocationLng;
  double parcelDestinationLat;
  double parcelDestinationLng;
  String parcelDestinationState;
  String parcelDeliveryPersonelName;
  String parcelDeliveryRequestStatus;
  double    parcelDeliveryPersonelRating;
  double parcelPaymentStatus;
  String parcelSendingBranchID;
  String parcelReceivingBranchID;
  int parcelSendingTime;
  int parcelPickupTime;
  int parcelOrderPlacementTime;
  int parcelProcessingTime;

  int timestamp;


 

  Parcel(
      {
this.userDocID = '',
this.dispatchUserID = '',
this.courierServiceDocID = '',
this.courierServiceName = '',
this.courierSelectionType = '',
this.parcelDocID = '',
this.parcelPickupCode = '',
this.parcelDeliveryFare = 0.0,
this.parcelCode = '',
this.senderFullname = '',
this.senderPhoneNumber = '',
this.receipientFullname = '',
this.receipientPhoneNumber = '',
this.parcelPickupLocationAddress = '',
this.parcelPickupLocationLat = 0.0,
this.parcelPickupLocationLng = 0.0,
this.parcelDestinationAddress = '',
this.parcelDestinationLat = 0.0,
this.parcelDestinationLng = 0.0,
this.parcelDestinationState  = '',
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
this.parcelDeliveryTime = 0,
this.parcelType = '', 
this.parcelsQuantity = 1,
this.parcelDeliveryType = 0,
this.parcelPaymentStatus = 0,
this.parcelDeliveryPersonelName = '',
this.parcelDeliveryRequestStatus = '',
this.parcelDeliveryPersonelRating = 0.0,
this.parcelSendingBranchID = '',
this.parcelReceivingBranchID = '',
this.parcelSendingTime = 0,
this.timestamp = 0, 
this.parcelPickupTime = 0,
this.parcelOrderPlacementTime = 0,
this.parcelProcessingTime = 0,
      });

  factory Parcel.fromMap(Map<String, dynamic> json) => Parcel(
      userDocID: json[ParcelDataModel.USER_DOC_ID],
      dispatchUserID: json[ParcelDataModel.DISPATCH_USER_ID],
      courierServiceDocID: json[ParcelDataModel.COURIER_SERVICE ],
      courierServiceName: json[ParcelDataModel.COURIER_SERVICE_NAME ],
      courierSelectionType: json[ParcelDataModel.COURIER_SELECTION_TYPE],
      parcelDocID: json[ParcelDataModel.PARCEL_DOC_ID],
      senderFullname: json[ParcelDataModel.SENDER_FULLNAME],
      senderPhoneNumber: json[ParcelDataModel.SENDER_PHONE_NUMBER],
      receipientFullname: json[ParcelDataModel.RECEIPIENT_FULLNAME],
      receipientPhoneNumber: json[ParcelDataModel.RECEIPIENT_PHONE_NUMBER],
      parcelPickupLocationAddress: json[ParcelDataModel.PARCEL_PICKUP_LOCATION_ADDRESS],
      parcelDestinationAddress: json[ParcelDataModel.PARCEL_DESTINATION_ADDRESS],
      parcelPrice: json[ParcelDataModel.PARCEL_PRICE],
      parcelSize: json[ParcelDataModel.PARCEL_SIZE],
      parcelPickupLocationLat: json[ParcelDataModel.PARCEL_PICKUP_LOCATION_LAT],
      parcelPickupLocationLng: json[ParcelDataModel.PARCEL_PICKUP_LOCATION_LNG],
      pickUpTime: json[ParcelDataModel.PICKUP_TIME],
      parcelDepositTime: json[ParcelDataModel.PARCEL_DEPOSIT_TIME],
      parcelDepartureTime: json[ParcelDataModel.PARCEL_DEPARTURE_TIME],
      parcelInTransitTime : json[ParcelDataModel.PARCEL_IN_TRANSIT_TIME],
      parcelReachedDestinationTime: json[ParcelDataModel.PARCEL_REACHED_DESTINATION_TIME],
      parcelDeliveryRequestStatus: json[ParcelDataModel.PARCEL_DELIVERY_REQUEST_STATUS],
      parcelDeliveryTime: json[ParcelDataModel.PARCEL_DELIVERY_TIME],
      parcelDepositFare: json[ParcelDataModel.PARCEL_DEPOSIT_FARE],
      parcelDeliveryFare: json[ParcelDataModel.PARCEL_DELIVERY_FARE],
      parcelCode: json[ParcelDataModel.PARCEL_CODE],
      parcelDestinationLat: json[ParcelDataModel.PARCEL_DESTINATION_LAT],
      parcelDestinationLng: json[ParcelDataModel.PARCEL_DESTINATION_LNG],
      parcelDestinationState: json[ParcelDataModel.PARCEL_DESTINATION_STATE],
      parcelPickupCode: json[ParcelDataModel.PARCEL_PICKUP_CODE],
      parcelType            : json[ParcelDataModel.PARCEL_TYPE],
      parcelsQuantity : json[ParcelDataModel.PARCELS_QUANTITY],
      parcelPayer:  json[ParcelDataModel.PARCEL_PAYMENT],
      parcelDeliveryType:  json[ParcelDataModel.PARCEL_DELIVERY_TYPE],
      parcelPaymentStatus: json[ParcelDataModel.PARCEL_PAYMENT_STATUS],
      parcelDeliveryPersonelName:  json[ParcelDataModel.PARCEL_DELIVERY_PERSONEL_NAME],
      parcelDeliveryPersonelRating:  json[ParcelDataModel.PARCEL_DELIVERY_PERSONEL_RATING],
      parcelSendingBranchID:  json[ParcelDataModel.PARCEL_SENDING_BRANCH_ID],
      parcelReceivingBranchID:  json[ParcelDataModel.PARCEL_RECEIVING_BRANCH_ID],
      parcelPickupTime:  json[ParcelDataModel.PARCEL_PICKUP_TIME],
      parcelOrderPlacementTime:  json[ParcelDataModel.PARCEL_ORDER_PLACEMENT_TIME],
      parcelSendingTime:  json[ParcelDataModel.PARCEL_SENDING_TIME],
      parcelProcessingTime:  json[ParcelDataModel.PARCEL_PROCESSING_TIME],
      timestamp:  json[ParcelDataModel.TIMESTAMP],

      
      

);

  Map<String, dynamic> toMap() => {
        ParcelDataModel.USER_DOC_ID: userDocID,
        ParcelDataModel.DISPATCH_USER_ID : dispatchUserID,
        ParcelDataModel.COURIER_SERVICE: courierServiceDocID,
        ParcelDataModel.COURIER_SERVICE_NAME: courierServiceName,
        ParcelDataModel.COURIER_SELECTION_TYPE : courierSelectionType,
        ParcelDataModel.PARCEL_CODE: parcelCode,
        ParcelDataModel.PARCEL_DOC_ID : parcelDocID,
        ParcelDataModel.SENDER_FULLNAME: senderFullname,
        ParcelDataModel.SENDER_PHONE_NUMBER : senderPhoneNumber,
        ParcelDataModel.RECEIPIENT_FULLNAME: receipientFullname,
        ParcelDataModel.RECEIPIENT_PHONE_NUMBER: receipientPhoneNumber,
        ParcelDataModel.PARCEL_PICKUP_LOCATION_ADDRESS : parcelPickupLocationAddress,
        ParcelDataModel.PARCEL_PICKUP_LOCATION_LAT : parcelPickupLocationLat,
        ParcelDataModel.PARCEL_PICKUP_LOCATION_LNG : parcelPickupLocationLng,
        ParcelDataModel.PARCEL_DESTINATION_ADDRESS: parcelDestinationAddress,
        ParcelDataModel.PARCEL_DESTINATION_STATE: parcelDestinationState,
        ParcelDataModel.PARCEL_DESTINATION_LAT: parcelDestinationLat,
        ParcelDataModel.PARCEL_DESTINATION_LNG: parcelDestinationLng,
        ParcelDataModel.PARCEL_PRICE: parcelPrice,
        ParcelDataModel.PARCEL_SIZE: parcelSize,
        ParcelDataModel.PICKUP_TIME:pickUpTime,
        ParcelDataModel.PARCEL_DEPARTURE_TIME: parcelDepositTime,
        ParcelDataModel.PARCEL_IN_TRANSIT_TIME: parcelInTransitTime,
        ParcelDataModel.PARCEL_REACHED_DESTINATION_TIME : parcelReachedDestinationTime,
        ParcelDataModel.PARCEL_DELIVERY_TIME: parcelDeliveryTime,
        ParcelDataModel.PARCEL_DEPOSIT_FARE : parcelDepositFare,
        ParcelDataModel.PARCEL_DELIVERY_FARE : parcelDeliveryFare,
        ParcelDataModel.PARCEL_TYPE : parcelType,
        ParcelDataModel.PARCELS_QUANTITY : parcelsQuantity,
        ParcelDataModel.PARCEL_PAYMENT : parcelPayer,
        ParcelDataModel.PARCEL_DELIVERY_TYPE : parcelDeliveryType,
        ParcelDataModel.PARCEL_PAYMENT_STATUS :parcelPaymentStatus,
        ParcelDataModel.PARCEL_DELIVERY_PERSONEL_RATING : parcelDeliveryPersonelRating,
        ParcelDataModel.PARCEL_DELIVERY_PERSONEL_NAME :parcelDeliveryPersonelName,
        ParcelDataModel.PARCEL_DELIVERY_REQUEST_STATUS: parcelDeliveryRequestStatus,
        ParcelDataModel.PARCEL_PICKUP_TIME : parcelPickupTime,
        ParcelDataModel.PARCEL_ORDER_PLACEMENT_TIME : parcelOrderPlacementTime,
        ParcelDataModel.PARCEL_PROCESSING_TIME :parcelProcessingTime,
        ParcelDataModel.TIMESTAMP :timestamp
      
       };

  

}
