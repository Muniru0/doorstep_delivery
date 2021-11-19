
import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math' ;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorstep_delivery/constants/constants.dart';
import 'package:doorstep_delivery/model_registry.dart';
import 'package:doorstep_delivery/services/data_models/branch_delivery_personel_data_model.dart';
import 'package:doorstep_delivery/services/data_models/parcel_data_model.dart';
import 'package:doorstep_delivery/services/firebase_storage_uploader.dart';
import 'package:doorstep_delivery/services/models/courier_company_model.dart';
import 'package:doorstep_delivery/ui/routes/settings_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:doorstep_delivery/ui/utils/helper_functions.dart/functions.dart';
import 'package:doorstep_delivery/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show PlatformException, rootBundle;
import "package:google_maps_webservice/places.dart";
import 'package:google_maps_webservice/directions.dart' as mapDirections;
import 'package:simple_animations/simple_animations.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';




class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> with WidgetsBindingObserver {
 
  
  late double _w;
  late double _h;
  late String _mapStyle;
  Completer<GoogleMapController> _controller = Completer();


 GoogleMapsPlaces places =  GoogleMapsPlaces(apiKey: Constants.GOOGLE_WEB_SERVICES_MAPS_API_KEY);

 mapDirections.GoogleMapsDirections directions = mapDirections.GoogleMapsDirections(apiKey: Constants.GOOGLE_WEB_SERVICES_MAPS_API_KEY); 

  FocusNode focusNode = FocusNode();


  TextEditingController searchLocationController = TextEditingController();
  late bool showLocationsSuggestions;

  String previousValue = '';
  late bool isLoadingMapStyle;
  late bool isAcquiringLocation;
  var locationsMarkers = <MarkerId,Marker>{};
  late double selectedLocationLat;
  late double selectedLocationLng;
  late String selectedLocationPlaceID;
  late bool isSearchBarVisible;

  late String selectedLocationAddr;

  late bool isSearchingLocationByText;

  FocusNode searchLocationFocusNode = FocusNode();

 late double moveMyImage;

 CameraPosition? lastKnownCameraPosition;

 late double lastFetchedLocationLat;

 late double lastFetchedLocationLng;
 late StreamSubscription<Position> currentPositionStream;
  late DeliveryPersonelModel _deliveryPersonelModel;

  final deliveryPersonelPillKey = GlobalKey();

  late double mapBearing;
 List<LatLng> kLocations = [
   LatLng(5.71053128123312,-0.200749933719635),
   LatLng(5.710427861425905,-0.2007509395480156),
   LatLng(5.7100999204299026,-0.20063761621713638),
   LatLng(5.709838368168349,-0.2004558965563774),
  LatLng(5.709508425157901,-0.20030803978443146),
  LatLng(5.70960717455202,-0.2002326026558876),
  LatLng(5.709010674574394,-0.2001253142952919),
  LatLng(5.708685401673999,-0.19999857991933823),
  LatLng(5.7082460327554765,-0.19989833235740662),
 ]; 
 late Stream stream;

late double containerHeight; 

 BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

 late bool showDeliveryPersonelsSideBarList;

  late bool openDrawer;

 late Image doorstepLogo;

  late WidgetsFlag _widgetsFlag;

  late String majorRequestError;

  late bool hasActiveDeliveries;

  late List<DeliveryPersonel> _deliveryPersonelsList;

  late bool isFetchingActiveDeliveries;
  late PanelController _panelController;

  BitmapDescriptor? pinLocationIcon;

  late bool _isAccountLocked;

  late bool _showBlurredOverlay;

  late DeliveryPersonel _deliveryPersonel;

 late bool _isLoadingRecentParcelDelivery;

 late Parcel _recentParcel;
  



void newLocationUpdate(LatLng latLng,{DeliveryPersonel? deliveryPersonel}) {


     var marker = Marker(
        markerId: MarkerId(deliveryPersonel!.deliveryPersonelID),
          //zIndex: 30.0,
          anchor: Offset(0.5,0.5),
         // position: LatLng(5.7082460327554765,-0.19989833235740662),
          position:latLng ,
          // rotation: Geolocator.bearingBetween(previousLatLng.latitude, previousLatLng.longitude, latLng.latitude, latLng.longitude),
          infoWindow: InfoWindow(
            title: _deliveryPersonelModel.getDeliveryPersonel.deliveryPersonelName,
            snippet: 'rating: ${(_deliveryPersonelModel.getDeliveryPersonel.deliveryPersonelRating / ((_deliveryPersonelModel.getDeliveryPersonel.totalNumberOfParcelsDelivered + _deliveryPersonelModel.getDeliveryPersonel.totalNumberOfUnsuccessfulDeliveries) * 5)).toStringAsFixed(1)}',
            
          ),
          icon: pinLocationIcon!
        );
     setState(() => locationsMarkers[MarkerId(deliveryPersonel.deliveryPersonelID)] = marker);
  }


@override
void initState(){
 
    WidgetsBinding.instance!.addObserver(this);
  _deliveryPersonelModel = register<DeliveryPersonelModel>();
  _deliveryPersonel       = _deliveryPersonelModel.getDeliveryPersonel;
  lastFetchedLocationLat = 0.0;
  lastFetchedLocationLng = 0.0;
  selectedLocationLat = 0.0;
  selectedLocationLng = 0.0;
  mapBearing = 0.0;
  containerHeight = 0.0;
  showDeliveryPersonelsSideBarList = false;
  isLoadingMapStyle = false;
   isSearchBarVisible = false;
   isSearchingLocationByText = false;
   openDrawer = false;
   selectedLocationAddr = Constants.LOCATION_LOADING_DOTS;
   selectedLocationPlaceID = '';
   showLocationsSuggestions = false;
   isAcquiringLocation = false;
   hasActiveDeliveries = false;
   isFetchingActiveDeliveries = false;
   _isAccountLocked = false;
   _showBlurredOverlay = false;
   _isLoadingRecentParcelDelivery = false;
   _recentParcel = Parcel();
   _panelController = PanelController();
   _deliveryPersonelsList = [];
   majorRequestError = '';
   _widgetsFlag =  WidgetsFlag.showIdleDeliveryPersonelStateWidget;
  
   rootBundle.loadString(Constants.CUSTOM_MAP_STYLE_FILE_PATH).then((string) {
    _mapStyle = string;
  });
  doorstepLogo = Image.asset(Constants.DOORSTEP_LOGO_PATH,fit: BoxFit.cover,);
  

 Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.bestForNavigation,forceAndroidLocationManager: true).listen(
    (Position position) {
      if(position != null){
         newLocationUpdate(LatLng(position.latitude, position.longitude),deliveryPersonel: _deliveryPersonelModel.getDeliveryPersonel);
      }else{
        myPrint('Please the location is null');
      }
      
    });



   
    setCustomMapPin();
   // fetchActiveDelivery(showLoadingGif: false);
    Geolocator.getServiceStatusStream().listen(
    (ServiceStatus status) {
      myPrint(status);
        if(status == ServiceStatus.disabled){
          UtilityWidgets.getToast('Location disabled,please enable your location to receive requests.',);
          setState(() {
            _panelController.open();
            _widgetsFlag = WidgetsFlag.showLocationDisabledWidget;
          });
        }else if(status == ServiceStatus.enabled){
            UtilityWidgets.getToast('Location enabled,you are ready to receive requests.',);
          setState(() {
            _panelController.open();
            _widgetsFlag = WidgetsFlag.showIdleDeliveryPersonelStateWidget;
          });  
        }

      
    });

    
    super.initState();

}




  
  void  updateDeliveryPersonelInfo({showLoadingGif = true})async{

        
            if(showLoadingGif){
              setState((){ _widgetsFlag = WidgetsFlag.showLoadingShimmer;});
            }

        Position _position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation); 

           var res = await   _deliveryPersonelModel.updateDeliveryPersonelInfo({DeliveryPersonelDataModel.DELIVERY_PERSONEL_LOCATION_LAT: _position.latitude,DeliveryPersonelDataModel.DELIVERY_PERSONEL_LOCATION_LNG: _position.longitude});

          if(!res['result']){
              UtilityWidgets.getToast('Error updating location info.',duration: '2');
              return;
          }

         
        
        
        

  }




  
  void  fetchActiveDelivery({showLoadingGif = true})async{

        
            if(showLoadingGif){
              setState((){ _widgetsFlag = WidgetsFlag.showLoadingShimmer;});
            }

     
           var res = await   _deliveryPersonelModel.fetchActiveDeliveries();

          if(!res['result']){
              _panelController.open();
            setState(() {
              majorRequestError = res['desc'];
              _widgetsFlag = WidgetsFlag.showMajorError;
            });

            return;
          }

         
        if(res['data'].parcelDocID.isEmpty){

          fetchDeliveryPersonel();

            return;
        }


        // TODO: HANDLE CURRENT ACTIVE DELIVERY
              
        
        

  }




  void  fetchDeliveryPersonel({showLoadingGif = true})async{

        
            if(showLoadingGif){
              setState((){ _widgetsFlag = WidgetsFlag.showLoadingShimmer;});
            }

     
           var res = await   _deliveryPersonelModel.fetchDeliveryPersonel();

          if(!res['result']){
              _panelController.open();
            setState(() {

             
              majorRequestError = res['desc'] == 'FATAL' ? 'Error while fetching data,please sign-out and sign back-in to continue': res['desc'];

              _widgetsFlag = WidgetsFlag.showMajorError;
            });

            return;
          }

          myPrint('fetched active del',heading: 'Fetch Active deliveries callled');


            if(res['data'] is DeliveryPersonel){


              if(res['data'].dispatchVehicleBrand.isEmpty || res['data'].dispatchVehicleModel.isEmpty || res['data'].dispatchVehicleRegistrationNumber.isEmpty ||res['data'].dispatchVehicleType.isEmpty){
                  setState(() {
                    _panelController.open();
                    _widgetsFlag = WidgetsFlag.showCompleteDeliveryVehicleInfoWidget;
                  });

                  return;
              }

                if( res['data'].deliveryPersonelStatus == Constants.DELIVERY_PERSONEL_OFFLINE_STATE){

                  setState(() {
                    _widgetsFlag = WidgetsFlag.showDeliveryPersonelOfflineWidget;
                    if(res['data'].deliveryPersonelStatusEditor != res['data'].deliveryPersonelID){
                          _isAccountLocked = true;
                        return;
                        
                        }
       
                        
           
                    
                  });

                  

                  return ;
                }

                setState(() {
                  _isLoadingRecentParcelDelivery = true;
                });

                _deliveryPersonelModel.fetchRecentParcelDelivery().then((res){

                    if(!res['result']){
                        UtilityWidgets.getToast('Error retrieving recent parcel deliveries');
                        return;
                    } 
                  
                    if(res['data'].parcelDocID.isNotEmpty){
                         setState(() {

                      _recentParcel = res['data']; 
                    });
                    }

                 

                }).whenComplete(() => setState(() {
                  _isLoadingRecentParcelDelivery = false;
                }));

               
       
                setState(() {
                  _widgetsFlag = WidgetsFlag.showIdleDeliveryPersonelStateWidget;
                });
    
      }

  }




@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
     if(state == AppLifecycleState.resumed){
        myPrint('resumed',heading: 'Inside resumed');
       setState(() {
         
       });
     }
    setState(() {
         
       });
    super.didChangeAppLifecycleState(state);
  }

 @override 
   dispose(){
      currentPositionStream.cancel(); 
     super.dispose();
   }



  void goToCurrentLocation()async{
   setState(()=>isAcquiringLocation = true);
           
               
    GoogleMapController controller = await _controller.future;
   Position position =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  
    setState(() { selectedLocationLat = position.latitude; selectedLocationLng = position.longitude;});
    
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      bearing: 23.047945022583008,
      target: LatLng(position.latitude, position.longitude),
     tilt: 45.0,
      zoom: 17.595899200439453))).then((value) => null);
      // .whenComplete(() => setState(()=>isAcquiringLocation = false)) ;
  
 
}



 void animateCameraToLocation(double lat, double lng)async{
      GoogleMapController controller = await _controller.future;
     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      bearing: 23.047945022583008,
      target: LatLng(lat, lng),
     tilt: 0.0,
      zoom: 17.595899200439453))).whenComplete(() => showLocationsSuggestions = false);
       setState(() {
      if(locationsMarkers.isNotEmpty){
           locationsMarkers.clear();
      }
       });

    
     
        locationsMarkers[MarkerId('marker')] = Marker(
          markerId: MarkerId('marker'),
          zIndex: 30.0,
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
            title: 'Title',
            snippet: 'Address',
            
          ),
          icon: pinLocationIcon!
        );
     
 }


 Future<void> _onMapCreated(GoogleMapController controller) async {
   

      Position? lastKnownPosition = await Geolocator.getLastKnownPosition();
      LatLng latLng = lastKnownPosition != null ? LatLng(lastKnownPosition.latitude , lastKnownPosition.longitude) :  const LatLng(5.708696077300338,-0.2004465088248253);

    try{
               //controller.setMapStyle(_mapStyle);
              _controller.complete(controller);
             

            Position  position =  await Geolocator.getCurrentPosition();
            latLng = LatLng(position.latitude,position.longitude);

        }on PlatformException catch(e){

     bool isLocationServicesEnabled =  await  Geolocator.isLocationServiceEnabled();
     if(e.message == 'The location service on the device is disabled.'){
            myPrint('use the string for the error identification');
     }
     if(!isLocationServicesEnabled){

          UtilityWidgets.getToast('Location services on the device have being disabled.',duration: '2',);
     }else{

        UtilityWidgets.getToast('Unexpected error, while fetching location data.',duration: '2');
     }

    }
  
   lastKnownCameraPosition = CameraPosition(
      bearing:0.0,
      target: latLng,
      tilt: 45.0,
      zoom: 17.595899200439453);
  
    controller.animateCamera(CameraUpdate.newCameraPosition(lastKnownCameraPosition!)).then((value) => null).whenComplete(() => setState(()=>isAcquiringLocation = false)) ;

  if(locationsMarkers.isNotEmpty){
           locationsMarkers.clear();
      }


       locationsMarkers[MarkerId(_deliveryPersonelModel.getDeliveryPersonel.deliveryPersonelID)] = Marker(

          markerId: MarkerId(_deliveryPersonelModel.getDeliveryPersonel.deliveryPersonelID),
          //zIndex: 30.0,
          anchor:const Offset(0.5,0.5),
          position:latLng,
         // rotation: bearing,
          infoWindow: InfoWindow(
            title: _deliveryPersonelModel.getDeliveryPersonel.deliveryPersonelName,
            snippet: 'rating: ${(_deliveryPersonelModel.getDeliveryPersonel.deliveryPersonelRating / ((_deliveryPersonelModel.getDeliveryPersonel.totalNumberOfParcelsDelivered + _deliveryPersonelModel.getDeliveryPersonel.totalNumberOfUnsuccessfulDeliveries) * 5)).toStringAsFixed(1)}',
            
          ),
          icon: pinLocationIcon!
        );



       // chooseLocationWithLatLng(latLng.latitude, latLng.longitude);

    //setState(() { selectedLocationLat = position.latitude; selectedLocationLng = position.longitude;});
    //  CameraPosition(
    //   bearing: 0.0 ,
    //   target: LatLng(latLng.latitude, latLng.longitude),
    //  tilt: 0.0,
    //   zoom: 14.595899200439453)

   // cameraPosition = position.latitude 
  //    selectedLocationLat = latLng.latitude;
  //    selectedLocationLng = latLng.longitude;


  //         var locationLat = 5.709760636414532;
  //         var locationLng = -0.2004465088248253;
  //         var  destinationLat =  5.708696077300338;
  //         var  destinationLng = -0.19875671714544296;
  
  // mapDirections.DirectionsResponse destinationDirections = await  directions.directionsWithLocation(Location(lat: locationLat,lng:locationLng), Location(lat: 5.682697669786985,lng: -0.17163723707199097,),transitRoutingPreference: TransitRoutingPreferences.fewerTransfers);


  //   List<mapDirections.Route>  routes   = destinationDirections.routes;

  

  //     if(destinationDirections.status != 'OK'){

  //         UtilityWidgets.getToast('Error displaying delivery personels information.');
          
  //     }


    
//   Location legStartLocation =    routes.first.legs.first.steps.first.startLocation;

//   Location legEndLocation   =  routes.first.legs.first.steps.first.endLocation;

//  var bearing = Geolocator.bearingBetween(legStartLocation.lat, legStartLocation.lng, legEndLocation.lat, legEndLocation.lng);




  
    //    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //   bearing: bearing,
    //   target: LatLng(position.latitude, position.longitude),
    //  tilt: 0.0,
    //   zoom: 13.595899200439453)));

       
     // chooseLocationWithLatLng(position.latitude,position.longitude);
       
    //   for (final office in googleOffices.offices) {
    //     final marker = Marker(
    //       markerId: MarkerId(DateTime.now().toString()),
    //       position: LatLng(office.lat, office.lng),
    //       infoWindow: InfoWindow(
    //         title: 'Title',
    //         snippet: 'Address',
    //       ),
    //     );
    //     _markers[office.name] = marker;
    //   }
    // });

    

   
  }



 Widget showDeliveryPersonelsSideBarListItem(){
   
   return  Container(
            width: _w * 75,
            padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color:Color(0xFFe9e9ec),width: 1.0 ))

            ),
            
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(18.0),
                    ),
                    margin: EdgeInsets.only(right: 7.5),
                    child: Image.asset(Constants.USER_ICON
                    ,fit: BoxFit.cover,),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Container(child: Text('Yussif Muniru',style:TextStyle(fontSize: 13.5,fontWeight: FontWeight.bold)),),
                    Container(
                      margin: EdgeInsets.only(top: 7.0),
                      child: Text('Royal(G-21-W 8283)',style: TextStyle(color:Color(0xFF797979),fontSize: 12.5))
                    ),
                   ]
                ),
                Expanded(child: const SizedBox()),
                Container(
                  padding: EdgeInsets.all(3.5),
                  decoration: BoxDecoration(
                    color: Color(0xFFf7f7f7),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    children: [
                      Container(child: Icon(AntDesign.star,color: Color(0xFFffcc01),size: 15 ),),
                      Container(
                        child: Text(' 4.89',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.5))
                      ),
                     ]
                  ),
                ),
              ],
            ),
          );
       
 }


 void setCustomMapPin() async {


     pinLocationIcon = await BitmapDescriptor.fromAssetImage(
     const ImageConfiguration(devicePixelRatio: 1.0),
      Constants.DELIVERY_BIKE_ICON);

   }




 List<Widget> locationsWidget = [];


 Widget liveParcelWidget(Parcel parcel){

   var image = Random().nextInt(6);

   return 
    Container(
                  width: _w ,
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(15),
                    color: white,
                      ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(15),
                    color: white,
                    shadowColor: Color(0xFFf7f7f9),
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      width: _w,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                    
                              Row(
                    
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(parcel.parcelsQuantity.toString(),style: TextStyle(color: white,fontSize: 12.5)),
                                    decoration: BoxDecoration(
                                      color: black,
                                      shape: BoxShape.circle,
                                    )
                                  ),
                                   Container(
                                     margin: EdgeInsets.only(left: 3.0),
                                    padding: EdgeInsets.all(7.0),
                                    child: Text('${parcel.parcelType}',style: TextStyle(fontWeight: FontWeight.bold,color: black,fontSize: 14.5)),
                                    
                                   
                                  ),
                                ],
                              ),
                    
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 7.0),
                                    child: Text('₵ ${parcel.parcelPrice}.0',style: TextStyle(color:Color(0xFFa7a5b3),fontSize: 13.5,fontWeight: FontWeight.bold )),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(right: 3.0,left: 7.0),
                                    child: Icon(Ionicons.time_sharp,color: fadedHeadingsColor,size: 12.0)
                                  ),
                                  Text('${parcel.parcelDeliveryTime.toStringAsFixed(0)}mins',style: TextStyle(fontSize: 12.5),),
                                  
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    alignment:Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:brightMainColor,
                                    ),
                                    child: Icon(AntDesign.staro,color: white,size: 20.0)
                                  ),
                    
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 7),
                                    child: Text('${parcel.parcelDeliveryPersonelRating}',style:TextStyle(color: brightMainColor,fontSize: 13.5,fontWeight: FontWeight.bold)),
                                  ),
                    
                                  Text('${parcel.parcelDeliveryPersonelName}',style: TextStyle(color: Color(0xFF9f9fb2),fontSize: 12.5,fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 13.0),
                              Text('${parcel.receipientFullname} , ${parcel.parcelDestinationAddress}',style: TextStyle(color:Color(0xFF363e4a),fontSize: 14.0,fontWeight: FontWeight.bold)),
                            ],
                          ),

                          Expanded(child: SizedBox()),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              width: 75,
                              height: 75,
                             
                              child: Image.asset('assets/images/test_parcel_$image.jpg'  ,fit: BoxFit.cover),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(15.0),
                              //   // image: DecorationImage(image: Image.asset('assets/images/test_parcel_1.png').image)
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
            
            
 }
 


 
 Widget drawerItem({required IconData icon, required String title,required VoidCallback onTap, bool faded = false,hasTopMargin = false,required ui.Color iconColor}){
   return InkWell(
        onTap:onTap,
        splashColor:Color(0xFFb8b8b8) ,
        child: Container(
          width: _w * 0.5,
          height: 60.0,
          
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(left: 75.0),
          child: Row(
             children: [
              Container(margin: EdgeInsets.only(right: 15.0) ,child: Icon(icon,size: 15.0,color:faded ? fadedHeadingsColor : iconColor ),),
              Text(title,style: TextStyle(fontSize: 13.5,fontWeight: faded ? FontWeight.normal :FontWeight.bold,color:faded ? fadedHeadingsColor : black  )),
            ],
          ),
        ),
      );
 }
 



 
  @override
  Widget build(BuildContext context) {
    
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:false ? Center(child: loadingIndicator(width: 15.0, height: 15.0)) :
       Stack(
        children: [
          SlidingUpPanel(
            maxHeight: _h * 0.7 ,
            minHeight:(_widgetsFlag == WidgetsFlag.showIdleDeliveryPersonelStateWidget) ? _h * 0.7 :  _h * 0.1,
            isDraggable: (_widgetsFlag != WidgetsFlag.showMajorError) && ( _widgetsFlag != WidgetsFlag.showLoadingShimmer) && (_widgetsFlag != WidgetsFlag.showCompleteDeliveryVehicleInfoWidget) && (_widgetsFlag != WidgetsFlag.showLocationDisabledWidget) && (_widgetsFlag != WidgetsFlag.showIdleDeliveryPersonelStateWidget),
            borderRadius:  BorderRadius.circular(30.0),
             parallaxEnabled: true,
             parallaxOffset: .1,
             color: Colors.transparent,
             boxShadow:const [BoxShadow(color: Colors.transparent)],
             controller: _panelController ,
             
             body:
           
                SizedBox(
                  height:_h ,
                  child: StreamBuilder<QuerySnapshot>(
                          stream: _deliveryPersonelModel.getLiveParcelsDeliveriesStream(),
                          builder: (context, snapshot) {
                  
                         if(snapshot.connectionState == ConnectionState.waiting){
                              myPrint('Loading .....');
                            }
                      
                      
                          if(snapshot.hasError){
                
                            myPrint(snapshot.error);  
                              }
                
                              if(snapshot.hasData){
                                if(snapshot.data != null){
                
                                  myPrint('Yh... we have data for the best');
                                }
                
                              }
                      
                                   
                      
                               return Stack(
                                 
                                 children: [
                      
                                     
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 700),
                                    curve: Curves.easeIn,
                                    child: 
                                       Animarker(
                                      curve: Curves.ease,
                                      mapId: _controller.future.then<int>((value) => value.mapId), //Grab Google Map Id,
                                      zoom: 16.59,
                                        markers: locationsMarkers.values.toSet(),
                                      child: GoogleMap(
                                        scrollGesturesEnabled: !_isAccountLocked,
                                        zoomGesturesEnabled: !_isAccountLocked,
                                      onMapCreated: _onMapCreated,
                                        myLocationEnabled: true,
                                        myLocationButtonEnabled: false,
                                        mapType: MapType.normal ,
                                        //markers: locationsMarkers.values.toSet(),
                                        onTap: (LatLng latLng){
                                          print(latLng.latitude);
                                          print(latLng.longitude);
                                        },
                                      
                                    
                                      onCameraMove: (cameraPosition){
                                      setState(() {
                                        if(isSearchBarVisible){
                                          isSearchBarVisible = false;
                                        }
                                        if(showLocationsSuggestions){
                                          showLocationsSuggestions = false;
                                        }
                                  
                                        print(cameraPosition.target.latitude);
                                        print(cameraPosition.target.longitude);
                                        lastKnownCameraPosition = cameraPosition;
                                      });
                                  
                                                
                                                
                                        },
                      onCameraMoveStarted: (){},
                      compassEnabled: false,
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(5.6778757, -0.0174085),
                          zoom:14.91,
                      ),
                            
    ),
),

                                  ),
                                
    
                
                           
                            
                             
                       
                            Positioned(
                                 left: 15.0,
                                 top: 50.0,
                                 child:   InkWell(
                                   onTap: (){
                                      setState(() {
                                        openDrawer = !openDrawer;
                                      });
                                   },
                                    child: Container(
                                   width: _w * 0.13,
                                   height: _w * 0.13,
                                   decoration: const BoxDecoration(shape: BoxShape.circle),
                               child:
                                  const Material(
                                     elevation: 15.0,
                                      shape: CircleBorder(),
                                     color: Color(0xff01394a),child: Icon(MaterialCommunityIcons.dots_vertical,size: 18.0,color: logoMainColor ))),
                                 ),
                     ),


                      
          Positioned(
                                 right: 15.0,
                                 top: 60,
                                 child:   Visibility(
                                   visible: _widgetsFlag == WidgetsFlag.showDeliveryPersonelOfflineWidget,
                                   child: InkWell(
                                     onTap: ()async{
                             setState((){_showBlurredOverlay = true;});

                                      var res =   await    _deliveryPersonelModel.updateDeliveryPersonelInfo({DeliveryPersonelDataModel.DELIVERY_PERSONEL_STATUS:Constants.DELIVERY_PERSONEL_IDLE_STATE});

                               setState(()=>  _showBlurredOverlay = false);


                              if(!res['result']){
                                  _panelController.open();
                                setState(() {
                                  majorRequestError = res['desc'];
                                  _widgetsFlag = WidgetsFlag.showMajorError;
                                });

                                return;
                              }
                            


                          setState(() {
                            _widgetsFlag = WidgetsFlag.showIdleDeliveryPersonelStateWidget;
                          });      
                      
                      
                      
                             },
                                    child: 
                                     Material(
                                       elevation: 15.0,
                                       borderRadius: BorderRadius.circular(23.0),
                                                             
                                       color: Colors.white,child: Container(
                                           width: _w * 0.3,
                                     height: _w * 0.1,
                                     alignment: Alignment.center,
                                     padding:const EdgeInsets.only(left: 10.0),
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(23.0)
                                     ),
                                         child: Row(
                                          
                                           children: [
                                 
                                             Container(
                                               width: 35,
                                               height:16 ,
                                               alignment: _deliveryPersonelModel.getDeliveryPersonel.deliveryPersonelStatus == Constants.DELIVERY_PERSONEL_OFFLINE_STATE ? Alignment.centerLeft : Alignment.centerRight,
                                             
                                                margin:const EdgeInsets.only(right:5.0),
                                               decoration: BoxDecoration(
                                                 color: logoMainColor,
                                                borderRadius: BorderRadius.circular(15.0),
                                                ),
                                               child: Container(
                                                 width:15.0,
                                                 height: 15.0,
                                                 decoration: const BoxDecoration(
                                                 color: white,
                                                   shape: BoxShape.circle
                                                 ),
                                               ),
                                               ),
                                             
                                             Text(_deliveryPersonelModel.getDeliveryPersonel.deliveryPersonelStatus == Constants.DELIVERY_PERSONEL_OFFLINE_STATE ? 'Offline' : 'Online',style: const TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold)),
                                           ],
                                         ))),
                                   ),
                                 ),
                     ),
                      

                   

                                  Positioned(
                                 right: 15.0,
                                 bottom: _h * 0.28,
                                 child:   Visibility(
                                   visible: false,
                                   child: InkWell(
                                     onTap: (){
                                      goToCurrentLocation();
                                     },
                                    child: 
                                     Material(
                                       elevation: 15.0,
                                       borderRadius: BorderRadius.circular(23.0),
                                                             
                                       color: Colors.white,child: Container(
                                           width: _w * 0.3,
                                     height: _w * 0.1,
                                     alignment: Alignment.center,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(23.0)
                                     ),
                                         child: Text('Recenter',style: TextStyle(fontSize: 12.5,fontWeight: FontWeight.bold)))),
                                   ),
                                 ),
                     ),
                      
     
                                 ],
                                                          );
                             
                             
                             }
                           ),
                ),
             
                                            
             panelBuilder: (sc) => Container(
               width: 0,
               height: 0.0,
               child: Stack(
                 fit: StackFit.loose,
                 clipBehavior: Clip.none,
                 children: [
                 loadingShimmer(),
                 showMajorError(() => fetchActiveDelivery()),  
                 emptyActiveDeliveriesWidget(),
                 showActiveDeliveries(sc),
                 showActiveDeliveryPersonels(sc),
                  completeDeliveryVehicleInfo(),
                 deliveryPersonelOfflineWidget(),
                 locationDisabledWidget(),
                 deliveryPersonelIdleStatusWidget(),
                   
                 ],
               ),
             )),
        
          Positioned(top: _h * 0.15,left: _w * 0.45,child:Visibility(visible: _isAccountLocked,child: const Icon(Feather.lock,size: 35.0,color: black,))),
          Positioned.fill(child:Visibility(visible: openDrawer,child: InkWell(onTap: (){
                          setState(() {
                            openDrawer = false;
                          });
                        },child: Container(color: black.withOpacity(0.5))))),
                  
                  
                    AnimatedPositioned(
              duration:Duration(milliseconds: 700) ,
              curve: Curves.ease,
              left:openDrawer ? 0.0 : -_w,
              top:20.0,
              child: Container(

                width: _w * 0.8,
                height: _h,
                color: white,

                child: Column(
                  children: [
                    Container(
                      width: _w,
                      padding: EdgeInsets.only(top: 30,bottom: 20.0 ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.0,color: fadedHeadingsColor)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: _w * 0.8,
                            height: _h * 0.20,
                            margin: EdgeInsets.only(bottom: 20.0),
                            child: doorstepLogo,
                    ),

                          Text('Welcome!',style: TextStyle(fontSize: 11.5, )),
                          Container(
                            margin: EdgeInsets.only(top: 3.5),
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Text(_deliveryPersonelModel.getCompany.companyName,style: TextStyle(fontSize: 15.5,fontWeight: FontWeight.bold)),
                            
                          ),
                          Divider(thickness: 0.5, color: fadedHeadingsColor,),

                          Container(
                            width: _w,
                            height: _h * 0.6,
                            alignment: Alignment.centerLeft,
                            
                            child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(0.0),
                              children: [
                                drawerItem(icon: MaterialIcons.delivery_dining,title:'Deliveries',onTap: (){Navigator.pushNamed(context,Constants.DELIVERIES_ROUTE);},iconColor:Color(0xFF7cc0dc) ),

                                  drawerItem(icon: Feather.users,title:'Directors',onTap: (){
                                  Navigator.pushNamed(context,Constants.DIRECTORS_ROUTE);
                                },iconColor: logoMainColor),
                               drawerItem(icon: Feather.user ,title:'Delivery Personels',onTap: (){Navigator.pushNamed(context,Constants.DELIVERY_PERSONELS_ROUTE);},iconColor:Color(0xFFeae194) ),
                                
                               drawerItem(icon: AntDesign.barchart ,title:'Statistics',onTap: (){
                                 Navigator.pushNamed(context,Constants.PARCELS_STATISTICS_ROUTE);
                               },iconColor: Color(0xFFc245b9)),
                                drawerItem(icon: MaterialIcons.payment ,title:'Usage and Billing',onTap: (){
                                  Navigator.pushNamed(context,Constants.USAGE_AND_BILLING_ROUTE);
                                },iconColor: logoMainColor),
                                 drawerItem(icon: EvilIcons.comment,title:'Account Top-up',onTap: (){
                                   Navigator.pushNamed(context,Constants.ACCOUNT_TOP_UP_ROUTE);
                                 },iconColor: Color(0xFF8bc34a)),

                                 Divider(thickness: 0.5, color: fadedHeadingsColor,),


                                 drawerItem(icon: Feather.user, title: "Profile", onTap: (){
                                   Navigator.pushNamed(context,Constants.DIRECTOR_PROFILE_ROUTE);
                                 },faded: true,iconColor: fadedHeadingsColor), 
                                 drawerItem(icon: SimpleLineIcons.settings, title: "Settings", onTap: (){
                                   Navigator.pushNamed(context,Constants.SETTINGS_ROUTE);
                                 },faded: true,iconColor: fadedHeadingsColor),
                                drawerItem(icon: Feather.share_2, title: "Invite a friend", onTap: (){
                                  Navigator.pushNamed(context,Constants.INVITE_A_FRIEND);
                                },faded: true,iconColor: fadedHeadingsColor),

                                 drawerItem(icon: Feather.lock, title: "Lock Account", onTap: (){
                                
                                },faded: true,iconColor: fadedHeadingsColor),

                                 Divider(thickness: 0.5, color: fadedHeadingsColor,),

                               drawerItem(icon: AntDesign.poweroff, title: "LogOut", onTap: (){},faded: true,iconColor: fadedHeadingsColor),
                                 

                              ],
                            ) ,
                            ),

                         
                        ],
                      ),
                    ),
                  ],
                ),
              ),  

            ),
                           

                                  Positioned.fill(
                               child: CustomAnimation<double>(
                                          tween: Tween(begin: 0.0,end: 1.0),
                                          control: _showBlurredOverlay ? CustomAnimationControl.play : CustomAnimationControl.playReverse,
                                          duration:const Duration(milliseconds:500),
                                          builder: (context, child, value) {
                                           
                                            return  Visibility(
                                        visible: !(value < 5.0) ,
                                       child: BackdropFilter(
                                          filter: ui.ImageFilter.blur(
                                            sigmaX: value,
                                            sigmaY: value,
                                            
                                          ),
                              child: Container(
                                 color: Colors.white.withOpacity(0.05),
                               ),
               ),);
                                          }
                                        ),
             
           ),
                           
        
        ],
      ),
                                  
        );
          }



    Widget showActiveDeliveries(sc){
      return  
       AnimatedPositioned(
                       duration: Duration(seconds: 1),
                       bottom: _widgetsFlag == WidgetsFlag.showActiveDeliveries ? 0.0: -_h,
                       curve: Curves.easeIn,
                       child: PlayAnimation<double>(
                        tween: Tween(begin: 0.0,end: 1.0),
                         builder: (context, child,value) {
                           return Material(
                              elevation: 35.0 * value,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                              color: Color(0xFFf7f7f9).withOpacity(0.93),
                              child: Container(
                               
                                  width: _w ,
                                  height:  _h * 0.7,
                                padding: EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                                ),
                                child:
                                 Column(
                                  children: [
                            
                                 Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF999ab7),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                       Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text('Tap on the parcels below to view more info',style: TextStyle(fontSize: 12.5,color: Color(0xFF999ab7),fontWeight: FontWeight.bold )),
                              ),
                                    ],
                                  ),
                                  
                                
                            
                                          
                                              Container(
                                              width: _w ,
                                              height: _h * 0.6,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                 controller: _widgetsFlag == WidgetsFlag.showActiveDeliveries ? sc : null,
                                                padding: EdgeInsets.all(0.0),
                                                itemCount: 10,
                                                itemBuilder: (context,index)=>  liveParcelWidget(Parcel(parcelsQuantity: 3,parcelType: 'Cloth',parcelDeliveryTime: 25 ,parcelPrice: 11,parcelDeliveryPersonelRating: 3.6,parcelDeliveryPersonelName: 
                                                  'Yussif Muniru',receipientFullname: 'Yussif Muniru',parcelDestinationAddress: 'Maglo Mini-mart')), 
                                    
                                                      ),
                                      ),
                                 
                                 
                                    ],
                                  ),
                                  ),
                                  );
                         }
                       ),
                     );

                
                  
    }




   Widget showActiveDeliveryPersonels(sc){
      return   AnimatedPositioned(
                       duration: Duration(seconds: 1),
                      
                       bottom: -_h,
                       curve: Curves.bounceIn,
                       child: PlayAnimation<double>(
                         tween: Tween(begin: 0.0,end: 1.0),
                         builder: (context, child,value) {
                           return Material(
                              elevation: 35.0 * value,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                              color: Color(0xFFf7f7f9).withOpacity(0.93),
                              child: Container(
                                
                                  width: _w ,
                                  height:  _h * 0.7 ,
                                padding: EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                                ),
                                child:
                                 Column(
                                  children: [
                               Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF999ab7),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                       Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text('Tap on the delivery personel to view more info',style: TextStyle(fontSize: 12.5,color: Color(0xFF999ab7),fontWeight: FontWeight.bold )),
                              ),
                                    ],
                                  ),
                                
                            
                                          
                                              Container(
                                              width: _w ,
                                              height: _h * 0.6,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                controller: sc ,
                                                padding: EdgeInsets.all(0.0),
                                                itemCount: 10,
                                                itemBuilder: (context,index)=>  deliveryPersonelWidget(deliveryPersonel: DeliveryPersonel(),index: index), 
                                    
                                                      ),
                                      ),
                                 
                                 
                                    ],
                                  ),
                                  ),
                                  );
                         }
                       ),
                     );
     }


  Widget deliveryPersonelWidget({required DeliveryPersonel deliveryPersonel , int index = 0, bool isLast = false}) {

      var image = Random().nextInt(5);
    return Container(
      
       padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(bottom: isLast ? _h * 0.1: 0.0),
       child:Container(
         padding: EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
         border: Border(bottom: BorderSide(width: 0.1, color: Color(0xFFa3a3a3)),
       ),),
         child: Row(
           children: [
             ClipRRect(borderRadius: BorderRadius.circular(15.0),child: Container(
          width: 75,
          height: 75,
         
          child: Image.asset('assets/images/test_parcel_${image == 0 ? 1 : image}.jpg'  ,fit: BoxFit.cover)),),

             Container(
               margin: EdgeInsets.only(left: 20.0),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text('Yussif Muniru',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: black)),
                    Row(
                      children: [
                        Container(
                        
                          margin: EdgeInsets.symmetric(vertical: 7.5),
                          child: Text('Accra ',style: TextStyle(color: Color(0xFFa4a4a4), fontSize: 12.5)),
                        ),
                        Container(
                          width: 3.0,
                          height: 3.0,
                          decoration: BoxDecoration(
                             color: Color(0xFFa4a4a4),
                            shape: BoxShape.circle
                          ),

                         ),

                          Container(
                         
                          margin: EdgeInsets.symmetric(vertical: 7.5,horizontal: 5.0),
                          child: Text('Royal Motorobike ',style: TextStyle(color: Color(0xFFa4a4a4), fontSize: 12.5)),
                          ),

                           Container(
                          width: 3.0,
                          height: 3.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFa4a4a4),
                            shape: BoxShape.circle
                          ),),

                           Container(
                         
                          margin: EdgeInsets.symmetric(vertical: 7.5,horizontal: 5.0),
                          child: Text(Constants.CEDI_SYMBOL + " ${Random().nextInt(1000)} K",style: TextStyle( color: true ? black :Color(0xFFa4a4a4), fontSize: 11.5,fontWeight: FontWeight.bold)),
                          ),
                      ],
                    ),

                    Container(
                      
                      child: Row(
                     
                        children: [
                             Icon(AntDesign.star,size: 13.0,color: logoMainColor),
                          Container(
                            margin: EdgeInsets.only(left: 2.0, ),
                            child: Text(' 4.6 ',style: TextStyle(color: logoMainColor, fontSize: 11.5),),),
                          
                            Container(
                            margin: EdgeInsets.only(left: 3.0),
                            child: Text('(1.2k parcels)',style: TextStyle(color: Color(0xFFa4a4a4), fontSize: 11.5,fontWeight: FontWeight.bold)),
                          ),
                          
                           

                           
                          
                        ],
                      )

                    ),
                
               ],),
             )
           ],
         ),
       ),
    );
  }



  Widget deliveryPill(){
    return RepaintBoundary(
     key: deliveryPersonelPillKey,
     child: Stack(
      
      children: [
        Column(
          children: [
          Material(
          elevation: 15.0,
          borderRadius: BorderRadius.circular(45.0),
                 child:
                  Container(
                    padding: EdgeInsets.all(10.0),
                    width: _w * 0.8,
                    child: Row(
                    children: [
                ClipRRect(
                borderRadius: BorderRadius.circular(75 / 2),
                child: Container(
                padding: EdgeInsets.all(3.5),
                    width:45 ,
                    height: 45,
                    child:  true ? Container(child: Icon(MaterialIcons.my_location,size:37)) : Image.asset('assets/images/parcel_icon.png',fit: BoxFit.cover),
                    color:Color(0xFFe9e9ec) ),
              ),
                
              SizedBox(width: 13.5),    
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                                 
              Text('Cloth, size 4',style: TextStyle(fontSize:13.5,color: black.withOpacity(0.95),fontWeight: FontWeight.bold)),
                      //),
    SizedBox(height: 5.5,),
          Row(children: [
            Container(margin: EdgeInsets.only(right: 2.5),child: Icon(AntDesign.staro,color: logoMainColor,size: 14.0)),
            Text('4.7 , ',style: TextStyle(color: logoMainColor,fontSize: 12.5,fontWeight: FontWeight.bold)),
            Text('Yussif Muniru',style: TextStyle(color:  Color(0xFFa4a4a4),fontSize: 13.5,fontWeight: FontWeight.bold ))
          ],),
   
   
   
                      SizedBox(height: 5.5,),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 3.5),
                            child: Icon(Ionicons.ios_timer,color:logoMainColor, size: 12.0),
                          ),
                          Text('15mins, ',style: TextStyle(color:  Color(0xFFa4a4a4),fontSize: 12.0)),
                          Text('since: 11:40pm',style: TextStyle(color: Color(0xFFa4a4a4),fontSize: 12.0,)),
                        ],
                      )
                                ],
                              ),
                                      
                                      
                                      ],
                                    ),
                                  ),
                                
                              
                                              ),
                        
                      ],
                    ),
                  
                  
                    Positioned(
              top: 65.0,
              left: 45.0,
            child: Transform.rotate(
              angle:3.14  * 0.23,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.5),
                    color:  Color(0xFFf7f7f9).withOpacity(0.93),
                ),
                
                height: 20,
                width: 20,
                
              ),
            ),
          ),
   
   
   
                  
                  ],
                ),
   );
           
  }

  Widget isSearchingLocationByTextWidget(){
        
      return Container(child: loadingIndicator(width: 30.0,height: 30.0,valueColor: warmPrimaryColor));
      }       
  
                      
Widget locationSuggestionWidget({name = '', city = '',required  Function() onTap}){
     return  InkWell(
                      onTap: onTap,
                      child: Row(
                     children: [
                      
                            Container(
                              // width: 20.0,
                              // height:20.0,
                              child: Icon(Ionicons.ios_location,size: 14.0),
                              padding: EdgeInsets.all(7.0),
                              margin: EdgeInsets.only(top: 15.0,left: 15.0,right: 10.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFFC0C0C0).withOpacity(0.5) ,
                                  shape: BoxShape.circle,
                              ),
                        
                      
                      
                      ),
                      Expanded(
                                                          child: 
                                                          Container(
                          margin: EdgeInsets.only(right: 20.0),
                          padding: EdgeInsets.only(top: 20.0, bottom: 10.0,right: 10.0,),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color:Color(0xFFC0C0C0).withOpacity(0.3))),
                          ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name, style: TextStyle( color: warmPrimaryColor.withOpacity(0.9),fontSize: 13.0, fontWeight: FontWeight.bold)),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child:  Text(city, style: TextStyle( color:Color(0xFFC0C0C0).withOpacity(0.8),fontSize: 11.0, )),
                            ),
                          ],
                        ),
                        ),
                      ),
                      
                      ]
                      ),
                                );
                      
                      }
                            
                            
 Future<Position> _determinePosition() async {
                      bool serviceEnabled;
                      LocationPermission permission;
                      
                  
                      serviceEnabled = await Geolocator.isLocationServiceEnabled();
                      if (!serviceEnabled) {
                        return Future.error('Location services are disabled.');
                      } else {
                        await Geolocator.requestPermission();
                        if (Platform.isAndroid) {
                          await Geolocator.openLocationSettings();
                        
                        } else if (Platform.isIOS) {
                          await Geolocator.openAppSettings();
                        }
                      }
                  
                      permission = await Geolocator.checkPermission();
                      if (permission == LocationPermission.deniedForever) {
                        return Future.error(
                            'Location permissions are permantly denied, we cannot request permissions.');
                      }
                  
                      if (permission == LocationPermission.denied) {
                        permission = await Geolocator.requestPermission();
                        if (permission != LocationPermission.whileInUse &&
                            permission != LocationPermission.always) {
                          return Future.error(
                              'Location permissions are denied (actual value: $permission).');
                        }
                      }
                  
                      return await Geolocator.getCurrentPosition();
                    }
            
 
                      
Future<bool> chooseLocationWithLatLng(double latitude, double longitude)async {
      
               
                  // PlacesSearchResponse response = await places.searchNearbyWithRankBy( Location(latitude, longitude), "distance", keyword: '' );
                   PlacesSearchResponse response = await places.searchNearbyWithRankBy( Location(lat:latitude, lng:longitude), "distance", keyword: '' );
                  if(response.isDenied ){
                    print('Response not found, please try again later.');
                  return false ;
                  }
      
                  if(response.isInvalid){
                    print('Response not found, please try again later2.');
                  return false;
                  }
                  if( response.isNotFound){
                    print('Response not found, please try again later3.');
                  return false;
                  }
                  List<PlacesSearchResult> placesRes = response.results;
      
      
                  setState(() {
      
                  if( placesRes.first.name != selectedLocationAddr){
                      selectedLocationAddr =  placesRes.first.name;
                      selectedLocationPlaceID =  placesRes.first.placeId;
                      selectedLocationLat = placesRes.first.geometry!.location.lat;
                      selectedLocationLng = placesRes.first.geometry!.location.lng;
                  }

                  });
      
      return true;
      }

      
 List<Widget> searchingLocationsIndicators() {
      return 
     List.generate(10, (index) => loadingQueryLocationsIndicator());
      
      }


 Widget loadingQueryLocationsIndicator(){
         return   Container(width: 250.0,padding: EdgeInsets.symmetric(vertical: 15.0),child: Row(
            children: [
              Container(
                width: 25.0,
                height: 25.0,
               
                margin: EdgeInsets.only(left: 20.0,right: 10.0),
            
              decoration: BoxDecoration(
                 color: Color(0xFFC0C0C0).withOpacity(0.5) ,
              borderRadius: BorderRadius.circular(8.0))),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                  Container(
                width: 150.0,
                height: 10.0,
                  
              decoration: BoxDecoration(
                  color: Color(0xFFC0C0C0).withOpacity(0.5) ,
              borderRadius: BorderRadius.circular(3.5))),
                 Container(
                   margin: EdgeInsets.only(top: 10.0),
                width: 100.0,
                height: 10.0,
                  
              decoration: BoxDecoration(
                 color: Color(0xFFC0C0C0).withOpacity(0.5),
              borderRadius: BorderRadius.circular(5.0))),
              ]),
              
              
            ]));
       }
    
    
void searchByPlaceID(String placeId)async {
              print('Called in the app');
      PlacesDetailsResponse response = await places.getDetailsByPlaceId(placeId);
          if(response.isDenied ){
                  print('Response not found, please try again later.');
                return ;
                }
      
          if(response.isInvalid){
                  print('Response not found, please try again later2.');
                return ;
                }
          if( response.isNotFound){
                  print('Response not found, please try again later3.');
                return ;
                }
      
      PlaceDetails placesRes = response.result;
      
      print(placesRes.adrAddress);
      print(placesRes.geometry!.location.lat);

            if(placesRes.name.isEmpty ){
              print('Data missed please try again');
        return;
            }
            print(placesRes.name);
      
            print("placesRes.first.name");
            setState(() {
      
            if( placesRes.name != selectedLocationAddr){
            selectedLocationAddr =  placesRes.name;
            }
            });
                          }
      

  Widget loadingShimmer({length = 10}){

    return AnimatedPositioned(
                       duration: const Duration(milliseconds: 700),
                       bottom: _widgetsFlag == WidgetsFlag.showLoadingShimmer ? 0.0: -_h,
                       curve: Curves.easeIn,
                       child: CustomAnimation<double>(
                        tween: Tween(begin: 0.3,end: 1.0),
                        control: _widgetsFlag == WidgetsFlag.showLoadingShimmer ? CustomAnimationControl.mirror : CustomAnimationControl.play,
                         builder: (context, child,value) {
                           return Material(
                              elevation: 35.0 * value,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                              color:const Color(0xFFf7f7f9).withOpacity(0.93),
                              child: Container(
                               
                                  width: _w ,
                                  height:  _h * 0.7,
                                padding:const EdgeInsets.all(15.0),
                                decoration:const BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                                ),
                                child:
                                 Column(
                                  children: [
                            
                                 Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF999ab7),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                       Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: Text('loading please wait...',style: TextStyle(fontSize: 12.5,color: Color(0xFF999ab7),fontWeight: FontWeight.bold )),
                              ),
                                    ],
                                  ),
                                  
                                
                            
                                          
                  Opacity(
                    opacity: value,
                    child: SizedBox(
                      height: _h * 0.6,
                      child: ListView(
                        children: List.generate(length, (index) =>  Container(
                          width: _w ,
                          margin: EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(15),
                            color: white,
                              ),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(15),
                            color: white,
                            shadowColor: Color(0xFFf7f7f9),
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              width: _w,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                            
                                      Row(
                            
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                        width: 25,
                                        height: 25,
                                      
                                        decoration: BoxDecoration(
                                          color: fadedHeadingsColor,
                                         shape: BoxShape.circle,
                                       
                                      ),),
                                        Container(
                                           margin: EdgeInsets.only(left: 3.0),
                                      padding: EdgeInsets.all(7.0),
                                        width: _w * 0.5,
                                        height: 10,
                                      
                                        decoration: BoxDecoration(
                                          color: fadedHeadingsColor,
                                          borderRadius: BorderRadius.circular(15.0),
                                       
                                      ),),
                                        ],
                                      ),
                            
                                      Row(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.symmetric(vertical: 7.0),
                                        width: _w * 0.1,
                                        height: 10,
                                      
                                        decoration: BoxDecoration(
                                          color: fadedHeadingsColor,
                                          borderRadius: BorderRadius.circular(15.0),
                                       
                                      ),),
                  
                                          Container(
                                        width: _w * 0.3,
                                        height: 10,
                                        margin: EdgeInsets.only(right: 3.0,left: 7.0),
                                        decoration: BoxDecoration(
                                          color: fadedHeadingsColor,
                                          borderRadius: BorderRadius.circular(15.0),
                                       
                                      ),),
                                        
                                          
                                        ],
                                      ),
                                      Row(
                                        children: [
                                       Container(
                                      width: 25,
                                      height: 25,
                                       padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        color: fadedHeadingsColor,
                                        shape: BoxShape.circle
                                       
                                      ),),
                            
                                         Container(
                                        width: _w * 0.1,
                                        height: 10,
                                         margin: EdgeInsets.symmetric(horizontal: 7),
                                        decoration: BoxDecoration(
                                          color: fadedHeadingsColor,
                                          borderRadius: BorderRadius.circular(15.0),
                                       
                                      ),),
                            
                                         Container(
                                      width: _w * 0.1,
                                      height: 10,
                                     
                                      decoration: BoxDecoration(
                                        color: fadedHeadingsColor,
                                        borderRadius: BorderRadius.circular(15.0),
                                       
                                      ),),
                                        ],
                                      ),
                                      SizedBox(height: 13.0),
                                       Container(
                                      width: _w * 0.6,
                                      height: 10,
                                     
                                      decoration: BoxDecoration(
                                        color: fadedHeadingsColor,
                                        borderRadius: BorderRadius.circular(15.0),
                                       
                                      ),),
                                     
                                    ],
                                  ),
                  
                                  Expanded(child: SizedBox()),
                                 
                                    Container(
                                      width: 75,
                                      height: 75,
                                     
                                      decoration: BoxDecoration(
                                        color: fadedHeadingsColor,
                                        borderRadius: BorderRadius.circular(15.0),
                                       
                                      ),
                                    ),
                                  
                                ],
                              ),
                            ),
                          ),
                                  ),
                       )
                      ),
                    ),
                  )
       
                                    ],
                                  ),
                                  ),
                                  );
                         }
                       ),
                     );

         
}



  Widget  showMajorError(onTap) {

     return   AnimatedPositioned(
                       duration: Duration(seconds: 1),
                      
                       bottom: _widgetsFlag == WidgetsFlag.showMajorError ? 0.0: -_h,
                       curve: Curves.bounceIn,
                       child:
                        PlayAnimation<double>(
                         tween: Tween(begin: 0.0,end: 1.0),
                         builder: (context, child,value) {
                           return Material(
                              elevation: 35.0 * value,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                              color: Color(0xFFf7f7f9).withOpacity(0.93),
                              child: Container(
                                padding: EdgeInsets.only(top: 15.0),
                                child: Column(
                                  children: [
                                     Container(
                                          width: 50,
                                          height: 5,
                                          margin: EdgeInsets.only(bottom:10),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF999ab7),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                    Container(
                                      
                                        width: _w ,
                                        height:  _h * 0.5 ,
                                      padding: EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                                      ),
                                      child: UtilityWidgets.majorErrorWidget(majorRequestError , onTap: onTap)
                                    
                                        ),
                                  ],
                                ),
                              ),
                                  );
                         }
                       ),
                    
                    
                     );

         
  }



 Widget completeDeliveryVehicleInfo(){

   return   AnimatedPositioned(
                       duration:const Duration(milliseconds: 700),
                      bottom:_widgetsFlag == WidgetsFlag.showCompleteDeliveryVehicleInfoWidget ? 0.0:  -_h,
                       curve: Curves.bounceIn,
                       child: PlayAnimation<double>(
                         tween: Tween(begin: 0.0,end: 1.0),
                         builder: (context, child,value) {
                           return Material(
                              elevation: 35.0 * value,
                              borderRadius:const  BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                              color:const Color(0xFFf7f7f9).withOpacity(0.93),
                              child: SizedBox(
                           
                                width: _w,
                                height: _h * 0.45,
                                child: Column(

                                  children: [

                                      Container(
                                              width: 50,
                                              height: 5,
                                              margin:const  EdgeInsets.only(top:15 ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF999ab7),
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                            ),
                                         const   Expanded(child: SizedBox()),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                         Container(margin:const EdgeInsets.only(bottom: 15.0),child: const Text('Almost done',style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold))),
                                     Stack(
                                       alignment: Alignment.center,
                                           children: [
                                             SizedBox(
                                               width: 75,
                                               height: 75,
                                               child: Image.asset(Constants.DELIVERY_BIKE_ICON,fit: BoxFit.cover)

                                             ),
                                         const Icon(AntDesign.exclamationcircle,color: logoMainColor,size: 17.0),
                                           ],
                                         ),


                                         Container(margin:const EdgeInsets.only(top: 20.0),child: const Text(' Complete your delivery vehicle info to continue',style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold))),

                                        const  SizedBox(height: 35.0,),
                                         UtilityWidgets.doubleButton('Complete Profile', () { 

                                           Navigator.push(context, CupertinoPageRoute(builder: (context)=> SettingsRoute(completeDeliveryVehicleInfo: true)));
                                         },screenWidth: _w,textColor: logoMainColor,buttonBackground: logoMainColor)

                                    
                                      ],
                                    ),

                                    const SizedBox(height: 25.0),
                                  ],
                                ),
                              ),
                                  );
                         }
                       ),
                     );

     
  }

   Widget deliveryPersonelOfflineWidget(){

   return   AnimatedPositioned(
                       duration: const Duration(milliseconds: 700),
                      bottom:_widgetsFlag == WidgetsFlag.showDeliveryPersonelOfflineWidget ? 0.0 :  -_h,
                       curve: Curves.bounceIn,
                       child: PlayAnimation<double>(
                         tween: Tween(begin: 0.0,end: 1.0),
                         builder: (context, child,value) {
                           return Material(
                              elevation: 35.0 * value,
                              borderRadius:const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                              color: Color(0xFFf7f7f9).withOpacity(0.93),
                              child: Container(
                           
                                width: _w,
                                height: _h * 0.45,
                                child: Column(

                                  children: [

                                      Container(
                                              width: 50,
                                              height: 5,
                                              margin: EdgeInsets.only(top:15 ),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF999ab7),
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            Expanded(child: SizedBox()),
                                   
                                   
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                       

                                            
                                       
                                         Icon(EvilIcons.user,color: errorColor.withOpacity(0.35),size: 20.5),
                                      Container(margin: const EdgeInsets.only(top: 4.0),child:const Text('Currently Offline on the app',style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold))),



                                       const  SizedBox(height: 40.0),

                                         Container(margin:const EdgeInsets.only(top: 20.0),child: const Text('Please turn-off Offline mode',style: TextStyle(fontSize: 14.5,color: errorColor, 
                                         fontWeight: FontWeight.bold))),

                                          Container(margin:const EdgeInsets.only(top: 5.0),child:const Text('To receive delivery requests',style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold))),

                                          

                                    
                                      ],
                                    ),

                                      Expanded(child: SizedBox()),

                                  ],
                                ),
                              ),
                                  );
                         }
                       ),
                     );

     
  }


   Widget locationDisabledWidget(){

   return   AnimatedPositioned(
                       duration:const Duration(milliseconds: 700),
                      bottom:_widgetsFlag == WidgetsFlag.showLocationDisabledWidget ? 0.0 :  -_h,
                       curve: Curves.bounceIn,
                       child: PlayAnimation<double>(
                         tween: Tween(begin: 0.0,end: 1.0),
                         builder: (context, child,value) {
                           return Material(
                              elevation: 35.0 * value,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                              color: Color(0xFFf7f7f9).withOpacity(0.93),
                              child: 
                              Container(
                           
                                width: _w,
                                height: _h * 0.45,
                                child: 
                                Column(

                                  children: [

                                      Container(
                                              width: 50,
                                              height: 5,
                                              margin: EdgeInsets.only(top:15 ),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF999ab7),
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          const  Expanded(child: SizedBox()),
                                   
                                   
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                       

                                            
                                       
                                         Icon(Feather.navigation,color: errorColor.withOpacity(0.35),size: 35.5),
                                      Container(margin: const EdgeInsets.only(top: 4.0),child:const Text('Location Disabled',style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold))),



                                       const  SizedBox(height: 40.0),

                                         Container(margin:const EdgeInsets.only(top: 20.0),child: const Text('Turn On ',style: TextStyle(fontSize: 14.5,color: logoMainColor, 
                                         fontWeight: FontWeight.bold))),

                                          Container(margin:const EdgeInsets.only(top: 5.0),child:const Text('To receive delivery requests',style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold))),

                                          

                                    
                                      ],
                                    ),

                                      Expanded(child: SizedBox()),

                                      UtilityWidgets.doubleButton('Enable Location', () { 
                                        goToCurrentLocation();
                                      })

                                  ],
                                ),
                              ),
                                  );
                         }
                       ),
                     );

     
  }




 Widget deliveryPersonelIdleStatusWidget(){


   var branchOfficePersonelNameAbbr = '';
    if(_deliveryPersonel.deliveryPersonelName.isNotEmpty){
      if(_deliveryPersonel.deliveryPersonelName.contains(' ')){
        var splittedBranchName = _deliveryPersonel.deliveryPersonelName.split(' ');
        branchOfficePersonelNameAbbr = splittedBranchName.first.split('').first + splittedBranchName[1].split('').first;
      }else{
        var splittedName =  _deliveryPersonel.deliveryPersonelName[1].split('');
      branchOfficePersonelNameAbbr =  splittedName.first +  splittedName[1] ;
      }
    }

   

     String path = FirebaseFileUploader().fromStringToDownloadLink(_deliveryPersonel.branchDeliveryPersonelAvatarUrl);
  
  Image? avatar = _deliveryPersonel.branchDeliveryPersonelAvatarUrl.isNotEmpty ? Image.network(path) : null;
        if(avatar != null){
          
        _deliveryPersonelModel.setDeliveryPersonelAvatar(avatar);
        }
 



   return  AnimatedPositioned(
                           duration:const Duration(milliseconds: 700),
                          bottom: _widgetsFlag == WidgetsFlag.showIdleDeliveryPersonelStateWidget ?  0.0 : -_h,
                           curve: Curves.bounceIn,
                           child: PlayAnimation<double>(
                             tween: Tween(begin: 0.0,end: 1.0),
                             builder: (context, child,value) {
                               return Material(
                                 
                                  elevation: 35.0 * value,
                                  borderRadius:const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15.0)),
                                  child: SizedBox(
                               
                                    width: _w,
                                    height: _h * 0.45,
                                    child:  
                               
            
                                  Stack(
                          children: [

                              AnimatedPositioned(
                           duration:const Duration(milliseconds: 700),
                          bottom: _widgetsFlag == WidgetsFlag.showIdleDeliveryPersonelStateWidget ?  0.0 : -_h,
                           curve: Curves.bounceIn,
                           child: PlayAnimation<double>(
                             tween: Tween(begin: 0.0,end: 1.0),
                             builder: (context, child,value) {
                               return Material(
                                 color:white ,
                                  elevation: 35.0 * value,
                                  borderRadius:const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15.0)),
                                  child: Container  (
                                  //  recentlyDeliveredParcelWidget
                                    width: _w,
                                    height: _h * 0.45,
                                    padding:const EdgeInsets.all(true ? 15.0 : 30.0),
                                    child:_isLoadingRecentParcelDelivery ? coreLoadingShimmer(_isLoadingRecentParcelDelivery) : 
                                      (_recentParcel.parcelDocID.isEmpty ? 
                                        Column(

                                  children: [

                                      Container(
                                              width: 50,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                color:const Color(0xFF999ab7),
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                            ),
                                        SizedBox(height: _h * 0.05),
                                   
                                   
                                  _isLoadingRecentParcelDelivery ? coreLoadingShimmer(_isLoadingRecentParcelDelivery) :   Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                       

                                            
                                       
                                        const Icon(Feather.package,size: 35.5),
                                      Container(margin: const EdgeInsets.only(top: 4.0),child:const Text('Empty deliveries',style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold))),



                                       const  SizedBox(height: 40.0),

                                         Container(margin:const EdgeInsets.only(top: 20.0),child: const Text('No deliveries yet',style: TextStyle(fontSize: 14.5,color: logoMainColor, 
                                         fontWeight: FontWeight.bold))),

                                          Container(margin:const EdgeInsets.only(top: 5.0),child:const Text('recent deliveries will appear here',style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold))),

                                          

                                    
                                      ],
                                    ),

                                      

                                  ],
                                ) : recentlyDeliveredParcelWidget()
                                      )
            
                                     
                                    
                                   
                               
                                  ),
                                      );
                             }
                           ),
                         ),
     
     

        AnimatedPositioned(
                           duration:const Duration(milliseconds: 700),
                          bottom: _widgetsFlag == WidgetsFlag.showIdleDeliveryPersonelStateWidget ?  0.0 : -_h,
                           curve: Curves.bounceIn,
                           child: PlayAnimation<double>(
                             tween: Tween(begin: 0.0,end: 1.0),
                             builder: (context, child,value) {
                               return Material(
                                 color:const Color(0xff01394a),
                                  elevation: 35.0 * value,
                                  borderRadius:const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15.0)),
                                  child: Container(
                               
                                    width: _w,
                                    height: _h * 0.15,
                                    padding:const EdgeInsets.all(10.0),
                                    child: Column(

                                      children: [
                                     
                                        Row(
                                          children: [

                                            // ClipRRect(
                                            //   borderRadius: BorderRadius.circular(15.0),
                                            //   child: SizedBox(
                                            //      width: 55,
                                            //      height: 55,
                                            //      child: Image.asset('assets/images/test_parcel_3.jpg' ,fit: BoxFit.cover)
                                            
                                            //    ),
                                            // ),

       _deliveryPersonel.branchDeliveryPersonelAvatarUrl.isNotEmpty ?   SizedBox( width: 55,
                  height: 55,child: ClipRRect(borderRadius: BorderRadius.circular(10),child:  true ? Image.asset('assets/images/test_parcel_3.jpg',fit: BoxFit.cover) : FadeInImage(fit: BoxFit.cover,placeholder:Image.asset(Constants.LOADING_SPINNER,).image ,image:avatar!.image))):
           
           
              Container(
                padding:const EdgeInsets.all(15.0),
              
                decoration:const BoxDecoration(
                  color: logoMainColor ,
                  shape: BoxShape.circle,
                ),
                child: Text(branchOfficePersonelNameAbbr,style:const TextStyle(color:white,fontWeight: FontWeight.bold )),
              ),


                                       const   SizedBox(width: 10.0),

                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:  [
                                                Text(_deliveryPersonel.deliveryPersonelName,style: TextStyle(color: white.withOpacity(0.7),fontWeight: FontWeight.bold,fontSize: 12.5 )),

                                              const  SizedBox(height: 7.0),

                                               Row(
                                                 children: [
                                                   const Icon(FontAwesome.star_half_o,color: logoMainColor,size: 17.0),
                                                   const  SizedBox(width: 5.0),
                                                    Text(_deliveryPersonel.deliveryPersonelRating == 0 && _deliveryPersonel.totalNumberOfParcelsDelivered + _deliveryPersonel.totalNumberOfUnsuccessfulDeliveries == 0 ? '5.0' : calculateDeliveryPersonelRating(_deliveryPersonel.deliveryPersonelRating, _deliveryPersonel.totalNumberOfUnsuccessfulDeliveries + _deliveryPersonel.totalNumberOfParcelsDelivered),style: TextStyle(color: white.withOpacity(0.2),fontWeight: FontWeight.bold,fontSize: 11.5 )),

                                                  const  SizedBox(width: 8.0),
                                                    Text('${_deliveryPersonel.totalNumberOfParcelsDelivered + _deliveryPersonel.totalNumberOfUnsuccessfulDeliveries} deliveries',style: TextStyle(color: white.withOpacity(0.2),fontWeight: FontWeight.bold,fontSize: 11.5 )),
                                                 ],
                                               ),

                                               
                              ],
                                            ),

                                         const   Expanded(child: SizedBox()),

                                   Material(
                                  color: logoMainColor,
                                  elevation: 35.0 * value,
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    padding:const EdgeInsets.all(10.0),
                                    child: const Text('Refresh location',style: TextStyle(color: white,fontSize: 14.5,fontWeight: FontWeight.bold)),

                                  )
                                  )     

                                          ],
                                        ),


                                   
                                      ],
                                    ),
                                  ),
                                      );
                             }
                           ),
                         ),
     
      
      ],
    )

                
                              )
                                 );
                                    }
                                    )
                                      );     
  



 }

  Widget recentlyDeliveredParcelWidget(){
    return   Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding:const EdgeInsets.all(8.0),
                                              margin:const  EdgeInsets.only(right: 15.0),
                                              decoration:const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xfff4f9fa),
                                              ),
                                               child:const Icon(EvilIcons.clock,size: 25.0)
                                            ),

                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:  [
                                              const  Text("Donut' Center(30 mins)",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                                             const SizedBox(height: 4.0),
                                                Text("Restaurant",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5,color: fadedHeadingsColor.withOpacity(0.35)),  )                                             ]
                                            ),
                                          ]
                                        ),
                                   
                                     const     SizedBox(height: 5.0),
                                         Container(
                                           width: _w,
                                           alignment: Alignment.centerLeft,
                                           margin:const EdgeInsets.only(left: 20.0),
                                           child: Column(
                                           children: List.generate(8,(i)=> Container(
                                              width: 3.5,
                                              height: 3.5,
                                              margin:const EdgeInsets.symmetric(vertical: 1.0),
                                             decoration: BoxDecoration(shape: BoxShape.circle,color: fadedHeadingsColor.withOpacity(0.35)),))
                                       ),
                                         ),

                                        const     SizedBox(height: 5.0),

                                        Row(
                                          children: [
                                            Container(
                                              padding:const EdgeInsets.all(8.0),
                                              margin:const  EdgeInsets.only(right: 15.0),
                                              decoration:const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xfff4f9fa),
                                              ),
                                               child:const Icon(Feather.navigation,size: 25.0)
                                            ),

                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:  [
                                              const  Text("Ave 2019, 3rd Floor,DU",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                                             const SizedBox(height: 4.0),
                                                Text("Your office Address",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5,color: fadedHeadingsColor.withOpacity(0.35)),  )                                             ]
                                            ),
                                          ]
                                        ),
                                   
                                      ],
                                    );
                               
  }


  Widget emptyActiveDeliveriesWidget(){

   return   AnimatedPositioned(
                       duration: Duration(seconds: 1),
                      bottom:  -_h,
                       curve: Curves.bounceIn,
                       child: PlayAnimation<double>(
                         tween: Tween(begin: 0.0,end: 1.0),
                         builder: (context, child,value) {
                           return Material(
                              elevation: 35.0 * value,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                              color: Color(0xFFf7f7f9).withOpacity(0.93),
                              child: Container(
                           
                                width: _w,
                                height: _h * 0.45,
                                child: Column(

                                  children: [

                                      Container(
                                              width: 50,
                                              height: 5,
                                              margin: EdgeInsets.only(top:15 ),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF999ab7),
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            Expanded(child: SizedBox()),
                                 Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                       

                                            
                                       
                                         SizedBox(
                                           width: 75,
                                           height: 75,
                                           child: Image.asset(Constants.EMPTY_GREYED_PARCEL_BOX,fit: BoxFit.cover)

                                         ),


                                         Container(margin: const EdgeInsets.only(top: 20.0),child:const Text('No active deliveries for now',style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold))),

                                       const   SizedBox(height: 35.0,),
                                         UtilityWidgets.doubleButton('Retry', () { 

                                           fetchActiveDelivery();
                                         },screenWidth: _w,)

                                    
                                      ],
                                    ),

                                      Expanded(child: SizedBox()),

                                  ],
                                ),
                              ),
                                  );
                         }
                       ),
                     );

     
  }



  Widget showSettleBillWidget() {

   
    DateTime _timestamp = DateTime.fromMillisecondsSinceEpoch(111111);
    DateTime _currentTimestamp = DateTime.now();
    var stringedOverallCost =1.toStringAsFixed(2);
    var amount ;
    var fractionalAmount;
    var one = 1;
    if(one != 0){
       myPrint('entered here $stringedOverallCost');
        amount =stringedOverallCost.split('.')[0];
      fractionalAmount = stringedOverallCost.split('.')[1];
    }else{
      myPrint('entered here $stringedOverallCost');
     amount = '-999';
    fractionalAmount = '00';
    }
    return  AnimatedPositioned(
                       duration: Duration(seconds: 1),
                       bottom:  -_h,
                       curve: Curves.easeIn,
                       child: PlayAnimation<double>(
                        tween: Tween(begin: 0.0,end: 1.0),
                         builder: (context, child,value) {
                           return Stack(
                             clipBehavior: Clip.none,
                             children: [
                               Material(
                                  elevation: 65.0 * value,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                                  color: Color(0xFFf7f7f9).withOpacity(0.93),
                                  child: Container(
                                   
                                      width: _w ,
                                      height:  _h * 0.7,
                                   
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30.0)),
                                    ),
                                    child:
                                     Column(
                                      children: [
                                
                                    
                                         SizedBox(height: 55.0),

                             const Text('Company Name',style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold)),

                              Container(
                                width: _w,
                                margin: EdgeInsets.only(top: 20.0,bottom: 20.0,left: 5.0),
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(children: [

                                  Container(
                                    width: _w * 0.15,
                                    height: 1.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xffd1d3df),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),


                                   Container(
                                    width: _w * 0.55,
                                   
                                    padding: EdgeInsets.symmetric(vertical: 7.0),
                                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                                    alignment: Alignment.center,
                                    child: Text('Usage & Billing',style: TextStyle(color: fadedHeadingsColor,fontSize: 14.5,fontWeight: FontWeight.bold)),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.4, color: Color(0xffd1d3df)),
                                     
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),

                                   Container(
                                    width: _w * 0.15,
                                    height: 1.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xffd1d3df),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),

                                ],)),

                                Text('${weekdayFormator(_timestamp.weekday)} ${_timestamp.day}/${_timestamp.month} ${Constants.ARROW_RIGHT} ${weekdayFormator(_currentTimestamp.weekday)} ${_currentTimestamp.day}/${_currentTimestamp.month}, ${_currentTimestamp.year}',style: TextStyle(color: Color(0xffcfd1de),fontSize: 11.5,fontWeight: FontWeight.bold)),


                                SizedBox(height: 25.0),

                                RichText(text: TextSpan(
                                  text: '${amount}',
                                  style: TextStyle(color: errorColor,fontSize: 30.0,fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(text:'.${fractionalAmount } \t${Constants.CEDI_SYMBOL}',style: TextStyle(color: Color(0xfffa7f95),fontSize: 20.5) ),
                                  ]
                                ),),

                                 SizedBox(height: 15.0),


                                Expanded(
                                  child: Container(
                                    width: _w,
                                    color: Color(0xffd6dbdd),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [

                                        
                                        UtilityWidgets.doubleButton('Continue', () {
                                          Navigator.pushNamed(context,Constants.BILL_DETAILS_CONFIRMATION_ROUTE);
                                         }),

                                         SizedBox(height: 25.0,),
                                      ],
                                    )
                                  ),
                                ),
                                    



                                    
                                      ],
                                      ),
                                      ),
                                      ),
                           
                              Positioned(
                                top: -35.0,
                                left: _w * 0.4,
                                child: Container(
                                  width: 75.0,
                                  height: 75.0,
                                  child: Icon(Entypo.credit_card,color: logoMainColor,size: 25.0),
                                  
                                decoration: BoxDecoration(
                                  color: Color(0xff01394a),
                                  shape: BoxShape.circle
                                ),
                              
                                ),
                              ),

                             
                           
                             ],
                           );
                         }
                       ),
                     );

      
  
  
  }

 Widget coreLoadingShimmer(toggle){
   return  Visibility(
     visible: toggle,
     child: CustomAnimation<double>(
        tween: Tween(begin: 0.0,end: 1.0),
        curve: Curves.easeInOut,
        duration:const Duration(milliseconds: 700),
        control:toggle ? CustomAnimationControl.mirror : CustomAnimationControl.play, 
        builder: (context, child,value) {
         return Opacity(
                          opacity: value,
                          child: SizedBox(
                            height: _h * 0.4,
                            child: ListView(
                              children: List.generate(3, (index) =>  Container(
                                width: _w ,
                                margin: EdgeInsets.only(bottom: 10.0),
                                decoration: BoxDecoration(
                                    borderRadius:  BorderRadius.circular(15),
                                  color: white,
                                    ),
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(15),
                                  color: white,
                                  shadowColor: Color(0xFFf7f7f9),
                                  child: Container(
                                    padding: EdgeInsets.all(15.0),
                                    width: _w,
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                  
                                            Row(
                                  
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10.0),
                                              width: 25,
                                              height: 25,
                                            
                                              decoration: BoxDecoration(
                                                color: fadedHeadingsColor,
                                               shape: BoxShape.circle,
                                             
                                            ),),
                                              Container(
                                                 margin: EdgeInsets.only(left: 3.0),
                                            padding: EdgeInsets.all(7.0),
                                              width: _w * 0.5,
                                              height: 10,
                                            
                                              decoration: BoxDecoration(
                                                color: fadedHeadingsColor,
                                                borderRadius: BorderRadius.circular(15.0),
                                             
                                            ),),
                                              ],
                                            ),
                                  
                                            Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.symmetric(vertical: 7.0),
                                              width: _w * 0.1,
                                              height: 10,
                                            
                                              decoration: BoxDecoration(
                                                color: fadedHeadingsColor,
                                                borderRadius: BorderRadius.circular(15.0),
                                             
                                            ),),
                        
                                                Container(
                                              width: _w * 0.3,
                                              height: 10,
                                              margin: EdgeInsets.only(right: 3.0,left: 7.0),
                                              decoration: BoxDecoration(
                                                color: fadedHeadingsColor,
                                                borderRadius: BorderRadius.circular(15.0),
                                             
                                            ),),
                                              
                                                
                                              ],
                                            ),
                                            Row(
                                              children: [
                                             Container(
                                            width: 25,
                                            height: 25,
                                             padding: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              color: fadedHeadingsColor,
                                              shape: BoxShape.circle
                                             
                                            ),),
                                  
                                               Container(
                                              width: _w * 0.1,
                                              height: 10,
                                               margin: EdgeInsets.symmetric(horizontal: 7),
                                              decoration: BoxDecoration(
                                                color: fadedHeadingsColor,
                                                borderRadius: BorderRadius.circular(15.0),
                                             
                                            ),),
                                  
                                               Container(
                                            width: _w * 0.1,
                                            height: 10,
                                           
                                            decoration: BoxDecoration(
                                              color: fadedHeadingsColor,
                                              borderRadius: BorderRadius.circular(15.0),
                                             
                                            ),),
                                              ],
                                            ),
                                            SizedBox(height: 13.0),
                                             Container(
                                            width: _w * 0.6,
                                            height: 10,
                                           
                                            decoration: BoxDecoration(
                                              color: fadedHeadingsColor,
                                              borderRadius: BorderRadius.circular(15.0),
                                             
                                            ),),
                                           
                                          ],
                                        ),
                        
                                        Expanded(child: SizedBox()),
                                       
                                          Container(
                                            width: 75,
                                            height: 75,
                                           
                                            decoration: BoxDecoration(
                                              color: fadedHeadingsColor,
                                              borderRadius: BorderRadius.circular(15.0),
                                             
                                            ),
                                          ),
                                        
                                      ],
                                    ),
                                  ),
                                ),
                                        ),
                             )
                            ),
                          ),
                        );
       }
     ),
   );
       
                        
 }


}



enum WidgetsFlag{showActiveDeliveries,showLoadingShimmer,showMajorError,showDeliveryPersonelOfflineWidget,showCompleteDeliveryVehicleInfoWidget,showIdleDeliveryPersonelStateWidget,showLocationDisabledWidget}



//    void insertItem(int index, DeliveryPersonel anotherDeliveryPersonel) {

//     if(_deliveryPersonelModel.getBranchDeliveryPersonels.any((deliveryPersonel)=> deliveryPersonel.branchID == anotherDeliveryPersonel.branchID
//     )) return;

      
//   _deliveryPersonelModel.addToBranchDeliveryPersonels(index, anotherDeliveryPersonel);
//   key.currentState!.insertItem(index);
  
  
// }


//   void removeItem(int index) {
    
//   var removedBranchDeliveryPersonel =  _deliveryPersonelModel.removeFromBranchDeliveryPersonels(index);


//   key.currentState!.removeItem(
//     index,
//     (context, animation) => deliveryPersonelWidget(index: index, deliveryPersonel: removedBranchDeliveryPersonel)
//   );

// }


