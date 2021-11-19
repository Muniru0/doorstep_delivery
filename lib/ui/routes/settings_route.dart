


import 'dart:async';

import 'package:doorstep_delivery/constants/constants.dart';
import 'package:doorstep_delivery/model_registry.dart';
import 'package:doorstep_delivery/services/data_models/branch_delivery_personel_data_model.dart';
import 'package:doorstep_delivery/services/models/courier_company_model.dart';
import 'package:doorstep_delivery/services/models/user_model.dart';
import 'package:doorstep_delivery/ui/base_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:doorstep_delivery/ui/utils/helper_functions.dart/functions.dart';
import 'package:doorstep_delivery/ui/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_animations/simple_animations.dart';

class SettingsRoute extends StatefulWidget {

  
   bool completeDeliveryVehicleInfo;

  SettingsRoute({this.completeDeliveryVehicleInfo = false});
  @override
  State<SettingsRoute> createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {

  late double _w;
  late double _h;

 final TextEditingController _textFieldController = TextEditingController();


  ScrollController? _sc;
  // final GlobalKey<Widget> _settingsPosition = GlobalKey<Widget>();



  OverlayEntry? _textFieldOverlayEntry;

  late bool _showBlurredOverlay;
  

  late DeliveryPersonelModel _deliveryPersonelModel;
  late UserModel _userModel;

  OverlayEntry? _deliveryVehicleTypeOverlayEntry;

  late bool _isOverlayOccupied;

  late bool _highlightDeliveryVehicleProfile;



  @override
  void initState() {
    _showBlurredOverlay = false;
    _isOverlayOccupied = false;
    _userModel = register<UserModel>();
    _deliveryPersonelModel = register<DeliveryPersonelModel>();
    _highlightDeliveryVehicleProfile = false;
    if(widget.completeDeliveryVehicleInfo){

      _highlightDeliveryVehicleProfile = true;  
    Future.delayed(const Duration(seconds:3 ),(){
      setState(() {
          _highlightDeliveryVehicleProfile = false;
      });
      
    });
    }
   
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
   
    return BaseView<DeliveryPersonelModel>(
      showBlurredOverlay: _showBlurredOverlay,
        child: Container(
          width: _w,
          height: _h,
          padding: const EdgeInsets.only(top: 15.0),
          color: logoBackgroundColor,
          child: Column(
            children: [
               UtilityWidgets.customAppBar(screenWidth: _w,onTap:(){},secondOnTap: (){},title: 'Settings'),
                   
              Container(
                width: _w,
                height: _h * 0.9,
                padding:const EdgeInsets.only(right: 20.0,left: 20.0),
               // color: logoBackgroundColor.withOpacity(0.7),
                child: 
                    ListView(
                      controller: _sc,
                      shrinkWrap: true,
                      children: [
                        
                          Row(
                          children: [
                            Container(
                              width: 45.0,
                              height: 45.0,
                              margin: const EdgeInsets.only(right: 20.0),
                              alignment: Alignment.center,
                              child: const Icon(Feather.edit_3,color: white,size: 13.5),
                              decoration: BoxDecoration(
                                color: logoMainColor,
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:const [
                               Text('Account',style:  TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold)),
                                SizedBox(height: 5.0),
                              Text('View your account details',style:  TextStyle(fontSize: 12.5,color: Color(0xff969ea9), fontWeight: FontWeight.bold)),
                           
                              ],
                            ),

                          ],
                        ),



                          const SizedBox(
                          height: 35.0,
                        ),

                        Container(
                          width: _w,
                          height: _h * 0.46,
                          padding: const EdgeInsets.all(15.0),
                          margin:const EdgeInsets.only(bottom: 20.0),
                          decoration:  BoxDecoration(
                            color: const Color(0xfff2f5fa),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                width: 55,
                height: 55,
                child: Image.asset(Constants.PARCEL_ICON,fit: BoxFit.cover,)),
            ),

            const SizedBox(width: 15.0),

              ScopedModelDescendant<DeliveryPersonelModel>(
               
                builder: (context, child,model) {
                  return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(model.getDeliveryPersonel.deliveryPersonelName ,style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold)),
                          const  SizedBox(height: 5.0),
                          InkWell(
                  onTap: (){
                   handleDeliveryVehicleInfoUpdate(DeliveryPersonelDataModel.DELIVERY_PERSONEL_EMAIL, 'Email', 'e.g doorstep@gmail.com', 'Enter your email',existingValue: model.getDeliveryPersonel.deliveryPersonelEmail);
                  },
                  child: Row(
                    children: [
                          
                       const Icon(FontAwesome.star_o,color: logoMainColor,size: 13.5),
                        const SizedBox(width: 2.5),
                        Text('${model.getDeliveryPersonel.deliveryPersonelRating}',style: const  TextStyle(fontSize: 10.5, color: logoMainColor,fontWeight: FontWeight.bold)),
                          
                        const SizedBox(width: 5.0),
                      Text(model.getDeliveryPersonel.deliveryPersonelEmail,style:   const TextStyle(fontSize: 11.5, color: Color(0xff969ea9),fontWeight: FontWeight.bold)),
                     const SizedBox(width: 10.0),
                     const  Icon(Feather.edit_3,color:logoMainColor ,size: 14.5)
                          
                   
                          
                   
                    ],
                  ),
                          ),
              
              
                          
                          ],
                        );
                }
              ),
          ],
        ),

       const SizedBox(height: 30.0,),
      
 ScopedModelDescendant<DeliveryPersonelModel>(
  
   builder: (context, child,model) {
     return infoWidget(onTap:(){},title: 'fullname',desc : model.getDeliveryPersonel.deliveryPersonelName,isEditable: false,);
   }
 ),
 ScopedModelDescendant<DeliveryPersonelModel>(
  
   builder: (context, child,model) {
     return infoWidget(onTap:(){
       handleDeliveryVehicleInfoUpdate(DeliveryPersonelDataModel.DELIVERY_PERSONEL_PHONE, 'Phone Number', 'Enter phone number', '029111111');
     },title: 'phone',desc : model.getDeliveryPersonel.deliveryPersonelPhone,);
   }
 ),  
 ScopedModelDescendant<DeliveryPersonelModel>(
 
   builder: (context, child,model) {
     return infoWidget(onTap:(){},title: 'City',desc : model.getDeliveryPersonel.deliveryPersonelTownOrcity,hasBorder: false,isEditable: false);
   }
 ), 

  

        
                            ],
                          ),
                        ),



         const   SizedBox(height: 15.0),

                              CustomAnimation<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              control:_highlightDeliveryVehicleProfile ? CustomAnimationControl.mirror : CustomAnimationControl.play ,
                              curve: Curves.easeInOut,
                              builder: (context, child,value) =>
                                
                          Row(
                          children: [
                            Container(
                              width: 45.0,
                              height: 45.0,
                              margin: const EdgeInsets.only(right: 20.0),
                              alignment: Alignment.center,
                              child: const Icon(MaterialIcons.delivery_dining ,color: white,size: 13.5),
                              decoration: BoxDecoration(
                                color: logoMainColor,
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                            ),

                            
                                
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:const [
                                     Text('Delivery Vehicle',style:  TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold)),
                                      SizedBox(height: 5.0),
                                    Text('Edit and mangaer your delivery  vehicle',style:  TextStyle(fontSize: 12.5,color: Color(0xff969ea9), fontWeight: FontWeight.bold)),
                                                       
                                    ],
                                  ),
                                
                             

                          ],
                        )

  ),



                   const   SizedBox(height: 25.0),
                      
                    
                     CustomAnimation<double>(
                       duration:const Duration(milliseconds: 700),
                       curve:Curves.easeInOut,
                      tween: Tween(begin: 0.0,end: 1.0),
                      control: _highlightDeliveryVehicleProfile ? CustomAnimationControl.mirror : CustomAnimationControl.play ,
                       builder: (context, child,value) {
                         return Container(
                              width: _w,
                              height: _h * 0.45,
                              padding: const EdgeInsets.all(15.0),
                              margin:const EdgeInsets.only(bottom: 20.0),
                              decoration:  BoxDecoration(
                                color:_highlightDeliveryVehicleProfile ? logoMainColor.withOpacity(value) : const Color(0xfff2f5fa),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ScopedModelDescendant<DeliveryPersonelModel>(
                               
                                builder: (context, child,model) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                   
                                    
                                  infoWidget(onTap:(){
                              
                                    handleDeliveryVehicleTypeUpdate();
                                   
                                  },title: 'Vehicle Type',desc :model.getDeliveryPersonel.dispatchVehicleType),
                                  
                                  
                                  infoWidget(onTap: (){
                                      handleDeliveryVehicleInfoUpdate(DeliveryPersonelDataModel.DISPATCH_VEHICLE_BRAND,'Vehicle brand', 'Royal , apsonic , luojia , etc','Name of delivery vehicle brand');
                                  },title: 'Vehicle Brand',desc :model.getDeliveryPersonel.dispatchVehicleBrand   ,),  
                              
                              
                                  infoWidget(onTap:(){
                              handleDeliveryVehicleInfoUpdate(DeliveryPersonelDataModel.DISPATCH_VEHICLE_MODEL,'vehicle model','RY-3045','Delivery vehicle model');
                                  },title: 'Vehicle Model',desc : model.getDeliveryPersonel.dispatchVehicleModel ),
                              
                              
                                  infoWidget(onTap:(){
                              
                                 handleDeliveryVehicleInfoUpdate(DeliveryPersonelDataModel.DISPATCH_VEHICLE_REGISTRATION_NUMBER,'Vehicle license number','License plate','Registration number');
                              
                                  },title: 'Vehicle License Number',desc : model.getDeliveryPersonel.dispatchVehicleRegistrationNumber,hasBorder: false),  
                              
                                  
                                    ],
                                  );
                                }
                              ),
                            );
                       }
                     ),

                  
                      
                    
                      ],
                    ),
                
              ),
            ],
          ),
        )
    );
  }

  Widget infoWidget({onTap,focusNode, controller,title = '',desc = '', bool hasBorder = true,bool edit = false, bool isEditable = true, textFieldValue,  cancelEditAction, }){


    return   InkWell(
      onTap:onTap ,
      child: Container(
                    width:_w ,
                    padding:const EdgeInsets.only(bottom: 20.0),
                    margin: EdgeInsets.only(bottom: hasBorder ? 15.0: 0.0),
                    decoration: BoxDecoration(
                      border:hasBorder ?  const Border(bottom: BorderSide(width: 0.3,color:Color(0xff969ea9) )): null,
                    ),
                    child: Row(
                        children: [
                          
                        
                         
                              Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(title,style:  const TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold,color: Color(0xff969ea9),)),
                            const SizedBox(height: 12.0),
                          Stack(
                            children: [
                             
                              Visibility(
                                visible: !edit,
                                child: SizedBox(
                                    width: _w * 0.7,
                                    child: Text(desc,style:  const TextStyle(fontSize: 14.5, 
                                    fontWeight: FontWeight.bold)),
                                  ),
                              ),
                           Visibility(
                             visible: edit,
                             child: AnimatedOpacity(
                                                                    duration:const Duration(milliseconds: 800),
                                                                    curve: Curves.easeInOut,
                                                                    opacity:edit ? 0.0 : 1.0 ,
                                                                   
                                                                    child: SizedBox(
                                      width: _w * 0.5,
                                      child: TextField(
                                                               
                                                                    controller: controller,
                                                                                      focusNode: focusNode,
                                                                                      style:const TextStyle(
                                      color: warmPrimaryColor,
                                      fontWeight : FontWeight.bold,
                                                                    ),
                                                                    autofocus: true,
                                                                    cursorColor: warmPrimaryColor,
                                                                    
                                                                    decoration: InputDecoration.collapsed(
                                      hintText: title,
                                      hintStyle:const TextStyle(
                                        color: Color(0xFFd7e0ef),
                                        fontSize: 13,
                                      ),
                                                                    ),
                                                                    onChanged: textFieldValue,
                                                              ),
                                                           
                                                           
                                                                    ),
                                                                  ),
                           ),
                                  

                              
                            ],
                          ),
    
                        
                        
    
    
                          
                          ],
                        ),
                            
                           const Expanded(child: SizedBox()),
                          Visibility(visible: isEditable,child:    InkWell(
                            onTap: cancelEditAction,
                            child: Icon(edit ? Feather.x_circle : Feather.edit_3,color:true ? logoMainColor : const Color(0xff969ea9),size: 14.5)))
                        ],
                      ),
                  ),
    );
                

                    
                
  }


    void handleDeliveryVehicleTypeChoiceProcessing(vehicleTypeChoice)async{


        _deliveryVehicleTypeOverlayEntry!.remove();
       
       UtilityWidgets.requestProcessingDialog(context);

     var res =   await    _deliveryPersonelModel.updateDeliveryPersonelInfo({DeliveryPersonelDataModel.DISPATCH_VEHICLE_TYPE:vehicleTypeChoice});

       Navigator.pop(context);
         setState(() {
          _showBlurredOverlay = false;
        });
        if(!res['result']){

        UtilityWidgets.requestErrorDialog(context,title: 'Operation',desc: res['desc'],cancelAction: (){
          Navigator.pop(context);
        },cancelText: 'Ok');
        return;
        }

        

       
      
       
       


    }



   void handleDeliveryVehicleTypeUpdate() {
        if(_isOverlayOccupied){
          return;
        }

      setState(() {
            _showBlurredOverlay = true; 
            _isOverlayOccupied = true;
        });
      
        _deliveryVehicleTypeOverlayEntry = UtilityWidgets.choicesOverlay(context, CustomAnimationControl.play, overlayChoices: [
          OverlayChoice(choice: Constants.DELIVERY_VEHICLE_CHOICE_TYPE_BIKE,choiceAction: (){
            handleDeliveryVehicleTypeChoiceProcessing( Constants.DELIVERY_VEHICLE_CHOICE_TYPE_BIKE);
         
          },isSelected: _deliveryPersonelModel.getDeliveryPersonel.dispatchVehicleType == Constants.DELIVERY_VEHICLE_CHOICE_TYPE_BIKE),

           OverlayChoice(choice: Constants.DELIVERY_VEHICLE_CHOICE_TYPE_CAR,choiceAction: (){
            handleDeliveryVehicleTypeChoiceProcessing(Constants.DELIVERY_VEHICLE_CHOICE_TYPE_CAR);
         
          },isSelected: _deliveryPersonelModel.getDeliveryPersonel.dispatchVehicleType == Constants.DELIVERY_VEHICLE_CHOICE_TYPE_CAR),

          OverlayChoice(choice: Constants.DELIVERY_VEHICLE_CHOICE_TYPE_VAN,choiceAction: (){
            handleDeliveryVehicleTypeChoiceProcessing(Constants.DELIVERY_VEHICLE_CHOICE_TYPE_VAN);
         
          },isSelected: _deliveryPersonelModel.getDeliveryPersonel.dispatchVehicleType == Constants.DELIVERY_VEHICLE_CHOICE_TYPE_VAN),
          
          ]);
       
       

        
    Overlay.of(context)!.insert(_deliveryVehicleTypeOverlayEntry!);
        
  }



  void handleDeliveryVehicleInfoUpdate(infoType,title,hint,desc, {String existingValue = ''}) {
      
      setState(() {
            _isOverlayOccupied = true;
            _showBlurredOverlay = true; 
            if(existingValue.isNotEmpty){
                _textFieldController.text = existingValue;
            }
          
        });
      
        _textFieldOverlayEntry = UtilityWidgets.getOverlayWithTextField(context,title: title ,hint: hint,desc: desc,onChanged: (String value){},textFieldController: _textFieldController,disFromBottom: _h * 0.6,animControl: CustomAnimationControl.play,confirmAction: ()async{
          
                _textFieldOverlayEntry!.remove();
                setState(() {
                _showBlurredOverlay = false; 
              
            });

      UtilityWidgets.requestProcessingDialog(context);

     var res =   await    _deliveryPersonelModel.updateDeliveryPersonelInfo({infoType:_textFieldController.text.trim()});

       Navigator.pop(context);

        if(!res['result']){

        UtilityWidgets.requestErrorDialog(context,title: 'Operation',desc: res['desc'],cancelAction: (){},cancelText: 'Ok');
        return;
        }

        UtilityWidgets.requestSuccessDialog(context,title: 'Sucess',desc: 'Information updated successfully',cancelAction: (){
          Navigator.pop(context);
        },cancelText: 'Ok');

        

        },cancelAction: (){

                  _textFieldOverlayEntry!.remove();
                    setState(() {
                _showBlurredOverlay = false; 
            });

        });

        Overlay.of(context)!.insert(_textFieldOverlayEntry!);
  }





}