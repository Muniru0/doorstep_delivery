

import 'dart:math';
import 'package:doorstep_delivery/services/data_models/branch_delivery_personel_data_model.dart';
import 'package:doorstep_delivery/services/data_models/parcel_data_model.dart';
import 'package:doorstep_delivery/services/models/courier_company_model.dart';
import 'package:doorstep_delivery/ui/base_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:simple_animations/simple_animations.dart';

class DeliveriesRoute extends StatefulWidget {
  const DeliveriesRoute({ Key? key }) : super(key: key);

  @override
  _DeliveriesRouteState createState() => _DeliveriesRouteState();
}

class _DeliveriesRouteState extends State<DeliveriesRoute> {
 

 late double _w;
 late double _h;

  late bool showSortWidget;

 late bool _dateIconSelected;

 late bool _frequecyIconSelected;

 late  bool _deliveryPersonelIconSelected;

 late bool _showSortWidget;

late  bool showSearchTextField;

late bool isAtBeginingOfList;

 @override
  void initState() {

     showSortWidget = false;
     _dateIconSelected = false;
     _frequecyIconSelected = false;
     showSearchTextField  = false;
     isAtBeginingOfList  = false;
     _deliveryPersonelIconSelected = false;
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {

    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;

    return BaseView<DeliveryPersonelModel>(
      isBlankBaseRoute: true,
        child: Container(
            width: _w,
            height: _h,
            padding: EdgeInsets.only(top: 20.0),
            color: Color(0xFFeeeeee),
            
            
            child:Stack(

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  true ?   PlayAnimation<double>(
                         tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, child,value) {
                            return Material(
                              elevation: (isAtBeginingOfList ? 5.0: 0.0) * value,
                              color: logoBackgroundColor,
                              child: 
                              Container(
                                width: _w,
                                
                                padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 20.0),
                                decoration: BoxDecoration(
                                  color: logoBackgroundColor,
                                  border: Border(bottom: BorderSide(width: 0.75, color: Colors.grey)),
                                ),
                                child:
                                   Row(
                                    children: [
                                
                                        InkWell(
                                              onTap: (){
                                            Navigator.pop(context);
                                              },
                                          child: Container(
                                          margin: EdgeInsets.only(right: 10.0),
                                          child: Icon(MaterialIcons.keyboard_arrow_left,size: 18.0),
                                                                              ),
                                        ),
                                    
                                        Text('Deliveries',style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold)),
                                        Expanded(child: SizedBox()),

                                          InkWell(
                                          onTap: (){
                                            setState(() {
                                                showSearchTextField = true;
                                            });
                                           
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: 5.6),
                                            child: Icon(Feather.search,size: 18,color: logoMainColor)
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                                 _showSortWidget = !_showSortWidget;
                                            });
                                           
                                          },
                                          child: Container(
                                            child: Icon(AntDesign.filter,size: 18,color: logoMainColor)
                                          ),
                                        ),
                                    ],
                                  ),
                                
                              ),
                           
                            );
                          }
                        )


                   :       Container(
                        margin: EdgeInsets.only(left: 15.0,right: 15.0,top: 40.0),
                        padding: EdgeInsets.only(bottom: 20.0),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.75,color: Color(0xFFd3d0d0))),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(11),
                                child: Icon(Ionicons.chevron_back,color: black, size: 16.5) ,
                                decoration: BoxDecoration(
                                  color: Color(0xFFd3d0d0),
                                  shape: BoxShape.circle
                                  ),
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              padding: EdgeInsets.all(6.5),
                              margin: EdgeInsets.only(right: 5.0),
                              decoration: BoxDecoration(
                                color: Color(0xFFefefef),
                                shape: BoxShape.circle

                              ),
                              child: Icon(EvilIcons.search,size: 26.5)
                            ),
                           
                            InkWell(
                              onTap: (){
                                setState(() {
                                  showSortWidget = !showSortWidget;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.5),
                                child: Icon(Feather.filter,color: black, size: 21.5),
                                decoration: BoxDecoration(
                                  color: Color(0xFFefefef),
                                  shape: BoxShape.circle
                                  ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(margin: EdgeInsets.only(left: 15.0,bottom: 25.0),child: Text('October',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.5))),
                                Expanded(child: SizedBox()),
                                Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                  padding: EdgeInsets.all(7.0)
                                  ,decoration: BoxDecoration(
                                    color: logoBackgroundColor,
                                    borderRadius: BorderRadius.circular(14.0),
                                ),child: Row(
                                  children: [
                                    Container(margin: EdgeInsets.only(right: 5.0),child: Icon(Feather.calendar,size: 14.5)),
                                    Text(' 27/Oct/21',style: TextStyle(fontSize: 11.0)),
                                  ],
                                ))
                              ],
                            ),

                            Container(
                            width: _w ,
                            height: _h * 0.73,
                            color:true ? Color(0xFFd3d0d0) : logoBackgroundColor,
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: (context,index)=>  parcelWidget(Parcel(parcelsQuantity: 3,parcelType: 'Cloth',parcelPrice: 11,parcelDeliveryPersonelRating: 3.6,parcelDeliveryPersonelName: 
                                'Yussif Muniru',receipientFullname: 'Yussif Muniru',parcelDestinationAddress: 'Maglo Mini-mart', parcelDeliveryTime:1635308412088 )), 
                                    
                                    ),
                                      ),
                            

                          ],
                        ),
                      ),

                     
                        Visibility(
                          visible: false,
                          child: Material(
                          elevation: 35.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xFFf7f7f9).withOpacity(0.93),
                          child: AnimatedContainer(
                             duration: Duration(milliseconds:700 ),
                             curve: Curves.ease,
                              width: _w ,
                              height:  _h * 0.9,
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
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
                            child: Text('You can sort the results by tapping on the icon on the top-right hand corner.',style: TextStyle(fontSize: 12.5,color: Color(0xFF999ab7),fontWeight: FontWeight.bold )),
                          ),
                                ],
                              ),
                              
                            
                                          
                                      
                            Container(
                            width: _w ,
                            height: _h * 0.8,
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(0.0),
                              itemCount: 10,
                              itemBuilder: (context,index)=>  liveParcelWidget(Parcel(parcelsQuantity: 3,parcelType: 'Cloth',parcelDeliveryTime: 25 ,parcelPrice: 11,parcelDeliveryPersonelRating: 3.6,parcelDeliveryPersonelName: 
                                'Yussif Muniru',receipientFullname: 'Yussif Muniru',parcelDestinationAddress: 'Maglo Mini-mart')), 
                                    
                                    ),
                                      ),
                                  
                                  
                          ],
                                          ),
                                          ),
                                          ),
                        ),
          
                      
                  ],
                ),
              Positioned.fill(child: Visibility(visible: showSortWidget,child: Container(color: black.withOpacity(showSortWidget ? 0.3: 0.0)  ))),
              AnimatedPositioned(
                duration: Duration(milliseconds: 700),
                curve: Curves.ease,
                bottom:showSortWidget ? -5.0 : -_h,
                child: Material(
                  elevation: 35.0,
                  borderRadius: BorderRadius.circular(25.0),
                  child: Container(
                    width: _w,
                    
                    decoration: BoxDecoration(
                       color: logoBackgroundColor,
                       borderRadius: BorderRadius.circular(25.0),
                    ),
                     
                      padding: EdgeInsets.all(15.0),child: Column(
                      children: [
                      Container(
                        width: _w,
                        padding: EdgeInsets.only(bottom: 15.0),
                        margin: EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(margin: EdgeInsets.only(left: 20.0,),child: Icon(Feather.x,size: 17.0)),
                          
                            Container(child: Text('Sort by',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                            
                             Opacity(opacity: 0.0,child: Container(margin: EdgeInsets.only(right: 20.0),child: Icon(Feather.x,size: 17.0)))
                          ],
                        ),
                      ),
              
                      Container(
                        width: _w,
                        height: _h * 0.4,
                       
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: ListView(
                         shrinkWrap: true,
                          children: [
                            Container(
                              width: _w,
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 12.5,),
                                    child: Text('Frequency(per)',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0 ))
                                  ),
                                  Expanded(child: SizedBox()),
                                  Container(child: IconToggle(size: 18.0,unselectedIcon: Feather.plus,
                                  duration: Duration(milliseconds: 700),selectedIcon: Feather.x,onChanged: (bool onChanged){
                                    setState(() {
                                        _frequecyIconSelected = onChanged;
                                    });
                                  },selected:_frequecyIconSelected ,unselectedColor: black,selectedColor: Colors.grey,),),
                                ],
                              ),
                            ),

                              AnimatedContainer(
                               duration: Duration(milliseconds: 700),
                               curve: Curves.easeInOut,
                              width: _w,
                              height:_frequecyIconSelected ? _h * 0.3 : 0.0,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  calenderDayWidget('Per Hour','number of parcels per hour',Ionicons.timer,(){}),
                                   calenderDayWidget('Per pay','Onumber of parcels per day',Ionicons.ios_time,(){}),
                                  calenderDayWidget('Per Week','number of parcels per week',Ionicons.ios_timer_outline,(){}),
                                  calenderDayWidget('Per Month','number of parcels per month',MaterialCommunityIcons.clock_time_four,(){}),
                                ],
                              ),
                            ),
                        

                            Container(
                              width: _w,
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 12.5,),
                                    child: Text('Date',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0 ))
                                  ),
                                  Expanded(child: SizedBox()),
                                  Container(child: IconToggle(size: 18.0,unselectedIcon: Feather.plus,selectedColor: Colors.grey,
                                  duration: Duration(milliseconds: 700),selectedIcon: Feather.x,onChanged: (bool onChanged){
                                    setState(() {
                                        _dateIconSelected = onChanged;
                                    });
                                  },selected:_dateIconSelected ,unselectedColor: black,),),
                                ],
                              ),
                            ),
                             AnimatedContainer(
                               duration: Duration(milliseconds: 700),
                               curve: Curves.easeInOut,
                              width: _w,
                              height:_dateIconSelected ? _h * 0.3 : 0.0,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  calenderDayWidget('Today','Oct 28',Feather.calendar,(){}),
                                   calenderDayWidget('Yesterday','Oct 27',EvilIcons.calendar,(){}),
                                  calenderDayWidget('Last Week','Oct 21 - 28',AntDesign.calendar,(){}),
                                  calenderDayWidget('Last Month','Aug 21 - Oct 28',FontAwesome.calendar,(){}),
                                ],
                              ),
                            ),
                        

                            Container(
                              width: _w,
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 12.5,),
                                    child: Text('Delivery Personels',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0 ))
                                  ),
                                  Expanded(child: SizedBox()),
                                  Container(child: IconToggle(size: 18.0,unselectedIcon: Feather.plus,
                                  duration: Duration(milliseconds: 700),selectedIcon: Feather.x,onChanged: (bool onChanged){
                                    
                                    setState(() {
                                        _deliveryPersonelIconSelected = onChanged;
                                    });
                                  },selected:_deliveryPersonelIconSelected ,unselectedColor: black,selectedColor: Colors.grey,),),
                                ],
                              ),
                            ),

                            AnimatedContainer(
                               duration: Duration(milliseconds: 700),
                               curve: Curves.easeInOut,
                              width: _w,
                              height:_deliveryPersonelIconSelected ? _h * 0.3 : 0.0,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  calenderDayWidget('Yussif Muniru','1.2k parcels',Feather.user,(){}),
                                   calenderDayWidget('Ibrahim Dawda','1.0k parcels',EvilIcons.user,(){}),
                                  calenderDayWidget('Salifu Eliasu','2.0k parcels',AntDesign.user,(){}),
                                  calenderDayWidget('Hamida Nuhu','700 parcels',FontAwesome.user,(){},hasBottomMargin: true),
                                  SizedBox(height: 70,),
                                ],
                              ),
                            ),
                                                   

                          
                        
                          ],
                        ),
                      ),
              
                    ]
                     ,)),
                ),
              ),
            
              ],
            ),
          ) ,
    );
  }


Widget calenderDayWidget(title, subtitle,iconData,onTap,{ bool isSelected = false,bool hasBottomMargin = false}){


  return   InkWell(
    onTap: onTap,
    child: Container(
              margin: EdgeInsets.only(left: 20.0,bottom: hasBottomMargin ? 40.0: 20.0),
              child: Row(
                children: [
                Container(
                  child:Icon(iconData,color: logoMainColor,size: 17.0)
                  ),
                  
                    Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(title,style: TextStyle(color: logoMainColor,fontSize: 12.5,fontWeight: FontWeight.bold)),
          SizedBox(height: 3.5),
            Text(subtitle,style: TextStyle(color:fadedHeadingsColor,fontSize: 10.5,fontWeight: FontWeight.bold)),
          ],
          ),
          ),
                Expanded(child: SizedBox()),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                    opacity: isSelected ? 1.0 : 0.0,
                    child: Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Icon(Feather.check,color: logoMainColor,size: 20.5),
                    ),
                  ),
              ],),
            ),
  );
                        
 
                                
}



 Widget liveParcelWidget(Parcel parcel){

   var image = Random().nextInt(6);

   return  Container(
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
                                      color:logoMainColor,
                                    ),
                                    child: Icon(AntDesign.staro,color: white,size: 20.0)
                                  ),
                    
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 7),
                                    child: Text('${parcel.parcelDeliveryPersonelRating}',style:TextStyle(color: logoMainColor,fontSize: 13.5,fontWeight: FontWeight.bold)),
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
                            child: 
                            Container(
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

  Widget parcelWidget(Parcel parcel) {

    var image = Random().nextInt(6);

    var parcelDeliveryDateTime = DateTime.fromMillisecondsSinceEpoch(parcel.parcelDeliveryTime);
    var formattedParcelDeliveryDateTime = '${parcelDeliveryDateTime.hour % 12}:${parcelDeliveryDateTime.minute} ${parcelDeliveryDateTime.hour >= 12 ? 'pm' : 'am'}';

    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        children:[
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(13.0),
                  child: Container(
                  width: 75,
                  height: 75,
                  
                  child: Image.asset('assets/images/test_parcel_$image.jpg'  ,fit: BoxFit.cover),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    // image: DecorationImage(image: Image.asset('assets/images/test_parcel_1.png').image)
                  ),
                ),
                ),
                Positioned(
                  right: -10.0,
                  top:-10.0,
                  child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(parcel.parcelsQuantity.toString(),style: TextStyle(color: black,fontSize: 12.5,fontWeight: FontWeight.bold)),
                  decoration: BoxDecoration(
                  color: Color(0xFFeeeeee),
                  shape: BoxShape.circle,
                              )
                            ),
                ),
              ],
            ),
            SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                  child: Text('${parcel.parcelType}, size: ${parcel.parcelSize}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5))
                ),
                 Container(
                   margin: EdgeInsets.symmetric(vertical: 7.0),
                   child: Row(
                     children: [
                       Container(child: Icon(AntDesign.star,size: 12.0,color: logoMainColor)),
                       RichText(text: TextSpan(
                         text:' ${parcel.parcelDeliveryPersonelRating}, ',style: TextStyle(color: logoMainColor,fontSize: 13.5),
                         children: [
                         TextSpan(
                           text: ' ${parcel.parcelDeliveryPersonelName}',style: TextStyle(color: Color(0xFF9e9e9e),fontSize: 13.5)
                         ),
                       ],))
                       
                     ],
                   ),
                 ),
                Container(child: Text('$formattedParcelDeliveryDateTime, ${parcel.parcelDestinationAddress }',style: TextStyle(color: black,fontSize: 12.5 ))),
              ]
            ),
                Expanded(child: SizedBox()),
                Container(child: Text('₵ ${parcel.parcelPrice}',style: TextStyle(fontWeight: FontWeight.bold)))              
        ]
      ),
    );
  }
 
}