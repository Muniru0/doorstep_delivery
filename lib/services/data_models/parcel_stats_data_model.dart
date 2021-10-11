
class ParcelStatsDataModel {
  static const String TOTAL_NUMBER_OF_PARCELS_SENT = 'total_number_of_parcels_sent';
  static const String TOTAL_NUMBER_OF_PARCELS_DELIVERED = 'total_number_of_parcels_delivered';
  static const String TOTAL_NUMBER_OF_PARCELS_RECEIVED = 'total_number_of_parcels_received';
   static const String TOTAL_AMOUNT_OF_PARCELS_SENT = 'total_amount_of_parcels_sent';
  static const String TOTAL_AMOUNT_OF_PARCELS_DELIVERED = 'total_amount_of_parcels_delivered';
  static const String TOTAL_AMOUNT_OF_PARCELS_RECEIVED = 'total_amount_of_parcels_received';
   static const String TIMESTAMP = 'timestamp';




}

class ParcelsStats {

  int totalNumberOfParcelsSent;
  int totalNumberOfParcelsReceived; 
  int totalNumberOfParcelsDelivered;
  int totalAmountOfParcelsSent;
  int totalAmountOfParcelsReceived; 
  int totalAmountOfParcelsDelivered;
  int timestamp;


  ParcelsStats({
  this.totalNumberOfParcelsSent  = 0,
  this.totalNumberOfParcelsReceived = 0,
  this.totalNumberOfParcelsDelivered = 0,
  this.totalAmountOfParcelsSent = 0,
  this.totalAmountOfParcelsReceived = 0, 
  this.totalAmountOfParcelsDelivered = 0,
  this.timestamp = 0
   
  });

  factory ParcelsStats.fromMap(Map<String, dynamic> json) => ParcelsStats(
     
     
      totalNumberOfParcelsSent: json[ParcelStatsDataModel.TOTAL_NUMBER_OF_PARCELS_SENT],
      totalNumberOfParcelsReceived: json[ParcelStatsDataModel.TOTAL_NUMBER_OF_PARCELS_RECEIVED],
      totalNumberOfParcelsDelivered: json[ParcelStatsDataModel.TOTAL_NUMBER_OF_PARCELS_DELIVERED],

        totalAmountOfParcelsSent: json[ParcelStatsDataModel.TOTAL_AMOUNT_OF_PARCELS_SENT],

      totalAmountOfParcelsReceived: json[ParcelStatsDataModel.TOTAL_AMOUNT_OF_PARCELS_RECEIVED],

      totalAmountOfParcelsDelivered: json[ParcelStatsDataModel.TOTAL_AMOUNT_OF_PARCELS_DELIVERED],
    
      );

  Map<String, dynamic> toMap() => {
        ParcelStatsDataModel.TOTAL_NUMBER_OF_PARCELS_SENT: totalNumberOfParcelsSent,
        ParcelStatsDataModel.TOTAL_NUMBER_OF_PARCELS_RECEIVED: totalNumberOfParcelsReceived,
        ParcelStatsDataModel.TOTAL_NUMBER_OF_PARCELS_DELIVERED: totalNumberOfParcelsDelivered,
        ParcelStatsDataModel.TOTAL_AMOUNT_OF_PARCELS_SENT: totalAmountOfParcelsSent,
        ParcelStatsDataModel.TOTAL_AMOUNT_OF_PARCELS_RECEIVED: totalAmountOfParcelsReceived,
        ParcelStatsDataModel.TOTAL_AMOUNT_OF_PARCELS_DELIVERED: totalAmountOfParcelsDelivered,
   
      };

  
}
