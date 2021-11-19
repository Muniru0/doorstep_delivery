


import 'package:doorstep_delivery/services/models/courier_company_model.dart';
import 'package:doorstep_delivery/ui/base_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class DeliveryPersonelProfileRoute extends StatefulWidget {
  const DeliveryPersonelProfileRoute({ Key? key }) : super(key: key);

  @override
  _DeliveryPersonelProfileRouteState createState() => _DeliveryPersonelProfileRouteState();
}

class _DeliveryPersonelProfileRouteState extends State<DeliveryPersonelProfileRoute> {
 
 late double _w;
 late double _h;

 
  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return BaseView<DeliveryPersonelModel>(
            isBlankBaseRoute:true,
            child: Container(
              width: _w,
              height: _h,
              padding: EdgeInsets.only(top: 20.0),
              color: logoBackgroundColor ,
              child: Stack(
                children: [
                  Column(
                    children: [
                       Container(
            width: _w,
            margin: EdgeInsets.only(bottom: 40.0),
            padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 20.0),
           
            child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
      
                  InkWell(
                        onTap: (){
                      Navigator.pop(context);
                        },
                    child: Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: Icon(MaterialIcons.chevron_left,size: 18.0),
                                                        ),
                  ),
              
                  Text('Profile',style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold)),
                  Expanded(child: SizedBox()),

                  
                  Opacity(
                    opacity: 0.0,
                    child: InkWell(
                      onTap: (){
                        },
                      child: Container(
                        child: Icon(AntDesign.filter,size: 18,color: logoMainColor)
                      ),
                    ),
                  ),
              ],
            ),
      
    ),


                  Container(
                    padding: EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: white,
                      border: Border.all(width: 0.2,color: Color(0xFFd4d3d8))
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(65/ 2),
                      child: Container(
                        width: 65,
                        height: 65,
                      
                        child: Image.asset('assets/images/test_parcel_1.jpg',fit: BoxFit.cover),
                      )
                    ),
                  ), 
                  
                    Container(margin: EdgeInsets.only(top: 20.0),child: Text('Yussif Muniru',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5,color: logoMainColor))), 
                    Container(
                      margin: EdgeInsets.only(bottom: 25.0),
                      child:Text('@Dr.Smile',style: TextStyle(color: Color(0xFFcdcdcf),fontSize: 11.5))
                    ),  

                    SizedBox(width: _w * 0.8,height: 0.3,child: Divider(thickness: 0.3,color: Color(0xFFcdcdcf))),

                    Container(
                      width: _w * 0.9,
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 35.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Container(
                          child:Column(
                            children: [
                              Text('126/750',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF38373a),fontSize: 12.0)),
                              Text('scans',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFd4d3d8),fontSize: 12.0)),
                            ],
                          ),
                        ),
                     

                        Container(
                          child:Column(
                            children: [
                              Text('126/750',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF38373a),fontSize: 12.0)),
                              Text('scans',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFd4d3d8),fontSize: 12.0)),
                            ],
                          ),
                        ),
                     
                     Container(
                          child:Column(
                            children: [
                              Text('1/6',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF38373a),fontSize: 12.0)),
                              Text('Users',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFd4d3d8),fontSize: 12.0)),
                            ],
                          ),
                        ),
                     
                    
                     
                     
                     
                      ],)
                    ),       
                    
                    ],
                  ),
              

                  Positioned(
                    bottom: -10.0,
                    left:10.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      elevation: 35.0,
                      child: Container(
                        width: _w * 0.95,
                        height: _h * 0.57,
                        padding: EdgeInsets.only(top: 25.0,left: 25.0,right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            deliveryVehicleDetailItem(icon: AntDesign.fork,title: 'Vehicle Type',value: 'MotorBike'),
                            SizedBox(height: 10.0,),
                            deliveryVehicleDetailItem(icon: MaterialIcons.branding_watermark,title: 'Vehicle Brand',value: 'Royal'),
                              SizedBox(height: 10.0,),
                             deliveryVehicleDetailItem(icon: Foundation.background_color,title: 'Vehicle Model',value: 'A200'),
                            SizedBox(height: 10.0,),
                             deliveryVehicleDetailItem(icon: AntDesign.fork,title: 'Vehicle License Plate',value: 'GW-1-W 8283 - 21'),
                              SizedBox(height: 10.0,),
                             deliveryVehicleDetailItem(icon: AntDesign.fork,title: 'Personel License Type',value: 'A'),
                              SizedBox(height: 10.0,),
                             deliveryVehicleDetailItem(icon: AntDesign.fork,title: 'Personel License Number',value: 'A334hd'),
                          

                            Container(
                              width: _w * 0.95,
                              padding: EdgeInsets.only(top: 20.0,left: 15.0,right: 25.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 25.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      color: logoMainColor,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 3.5),
                                          child: Icon(Feather.x, color: white,size: 17.0)
                                        ),
                                        Text('Deactivate',style: TextStyle(color: white, fontSize: 11.5, fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  ),
                               
                                  Expanded(child: SizedBox()),
                                Container(
                                    padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 35.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      color: errorColor,
                                    ),
                                    child: Row(
                                      children: [
                                       
                                        Text('Delete',style: TextStyle(color: white, fontSize: 11.5, fontWeight: FontWeight.bold)),
                            
                                         Container(
                                          margin: EdgeInsets.only(left: 3.5),
                                          child: Icon(Entypo.trash, color: white,size: 17.0)
                                        ),
                                      ],
                                    )
                                  )
                               
                               
                                ],
                              ),
                            )
                          ],
                        ),
                        ),
                    ),
                  ),
              
                ],
              ),
            )
    );
  }

  Widget deliveryVehicleDetailItem({icon,title,value}){

    return   Row(

            children: [
              Container(
                padding: EdgeInsets.all(13.0),
                margin: EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFf6f5f8),borderRadius: BorderRadius.circular(13.0)),
                child: Icon(icon,size: 15.5)
              ),
              Text(title,style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.bold)),
              Expanded(child: SizedBox()),
              Container(
                width: _w * 0.2,
                child: Text(value,style: TextStyle(color: logoMainColor,fontSize: 13.5)),
              ),
            ],
          );
        
  }
}