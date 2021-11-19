
import 'package:doorstep_delivery/services/models/courier_company_model.dart';
import 'package:doorstep_delivery/ui/base_route.dart';
import 'package:doorstep_delivery/ui/routes/delivery_personel_routes/dummy_stats_data_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class StatisticsRoute extends StatefulWidget {
  const StatisticsRoute({ Key? key }) : super(key: key);

  @override
  _StatisticsRouteState createState() => _StatisticsRouteState();
}

class _StatisticsRouteState extends State<StatisticsRoute> {
  
  
  late double _w;
  late double _h;

  final columnChartKey = GlobalKey<_StatisticsRouteState>();

 late bool isBarChart;


 @override
  void initState() {
    isBarChart = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;


    return BaseView<DeliveryPersonelModel>(
      isBlankBaseRoute: true,
      child:Container(
        width: _w,
        height: _h,
        color: Color(0xFFdfe4fb).withOpacity(0.3),
        padding: EdgeInsets.only(top: 20.0),
        child:Stack(
          children: [
            Container(
                 padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0) ,
                // color: black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: _w,
                    margin: EdgeInsets.only(bottom: 35.0),
                    padding: EdgeInsets.only(bottom: 35.0) ,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.1,color: Color(0xFF8a919f))),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(7.0),
                          margin: EdgeInsets.only(right: 12.0),
                          decoration: BoxDecoration(shape: BoxShape.circle,color: white),
                          child: Icon(Entypo.chevron_left,size: 17.0,color: logoMainColor),
                        ),

                        Container(
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(margin: EdgeInsets.only(bottom: 2.0),child: Text('Yussif Muniru',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.5))),
                             Text('11.5k Followers',style: TextStyle(color:Color(0xFFa6acc4),fontSize: 12.5,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                Text('Weekly Stats',style: TextStyle(color:Color(0xFF3a4453),fontSize: 14.0, fontWeight: FontWeight.bold )),
                
                Container(
                  margin: EdgeInsets.only(top: 23.0),
                  width: _w,
                  child: Row(
                    children: [
                      statsWidget(titleIcon: Feather.package,title: 'Total Parcels',stat: '1.863k',growthIndicator: AntDesign.arrowup,growthPercentage: '2.1%'),  
                      SizedBox(width: 15.0,),
                      statsWidget(titleIcon: MaterialCommunityIcons.truck_fast_outline,title: 'Sent Parcels',iconBackgroundColor:Color(0xFFffe9e9) ,iconColor: Color(0xFFf23839),stat: '3.834k',growthIndicator: AntDesign.arrowup,growthPercentage: '2.1%',isAtRightHand: true),  
                    ],
                  ),
                ),
                
                  Container(
                  margin: EdgeInsets.only(top: 15.0),
                  width: _w,
                  child: Row(
                    children: [
                      statsWidget(titleIcon: Fontisto.shopping_package,title: 'Received Parcels',stat: '2.03k',growthIndicator: AntDesign.arrowup,iconBackgroundColor:Color(0xFFffe7df) ,iconColor: Color(0xFFff6938),growthPercentage: '2.1%'),  
                      SizedBox(width: 15.0,),
                      statsWidget(titleIcon: Feather.package,title: 'Delivered Parcels',stat: '0.733k',iconBackgroundColor:Color(0xFFdff3ff) ,iconColor: Color(0xFF0a9ff6),growthIndicator: AntDesign.arrowup,growthPercentage: '2.1%',isAtRightHand: true),  
                    ],
                  ),
                ),
                
                
                ],
              ),
            ),
          
          
           Positioned(
             bottom: -10.0,
             child:
            Material(

             elevation: 35.0,
             borderRadius: BorderRadius.only(topRight: Radius.circular(35),topLeft: Radius.circular(35)),
             color: white,
             child: Container(
               width: _w,
               height: _h * 0.5,
               decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(35),topLeft: Radius.circular(35)),
                 color:  white,
               ),
                padding: EdgeInsets.only(top: 35.0,left: 25.0,right: 15.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children:[
                   Container(
                     width: _w,
                      margin: EdgeInsets.only(bottom: 20.0),
                     child: Row(
                      
                       children: [
                         Container(
                          
                           child: Text('Growth Stats',style: TextStyle(color: Color(0xFF36404e),fontSize: 14.5,fontWeight: FontWeight.bold))
                         ),

                         Expanded(child: SizedBox()),

                          Container(
                              margin: EdgeInsets.only(right: 10.0),
                          child: Icon(AntDesign.barchart,size: 21.0,color:isBarChart ? logoMainColor : Color(0xFF858c9b))
                         ),
                         Container(
                          margin: EdgeInsets.only(right: 15.0),
                          child: Icon(MaterialCommunityIcons.chart_timeline_variant,size: 21.0,color:!isBarChart ? logoMainColor :Color(0xFF858c9b) )
                         ),
                         


                       ],
                     ),
                   ),
                   

                   ColumnBarChart(key:columnChartKey),
                        
                  Visibility(
                    visible: false,
                    child: Container(
                    width: _w,
                    height: _h * 0.3,child: StatisticsBarRoute(lineColor: logoMainColor)),
                  ),

                 ]
               ),
             ),
           )),
          
          
          ],
        ),
        ) ,
      
    );
  }


  Widget statsWidget({titleIcon,title,stat,growthIndicator,growthPercentage,iconBackgroundColor = const Color(0xFFeceef9) ,Color iconColor = const Color(0xFF876ee7),isAtRightHand = false}){

               return  Material(
                          elevation: 1,
                           borderRadius: BorderRadius.circular(20),
                           color: Color(0xFFeceef9),
                          child:Container(
                        
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0,left: 10.0,right: 10.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFeceef9),
                          border: Border.all(width: 0.5,color: Color(0xFFfcfcfe)),
                          borderRadius: BorderRadius.circular(20)
                        ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      padding: EdgeInsets.all(7.0),
                                       decoration: BoxDecoration(
                                        color: iconBackgroundColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(titleIcon,color: iconColor,size: 13.5)
                                    ),
                                    Text(title,style: TextStyle(color: Color(0xFF868d9c),fontSize: 12.0, fontWeight: FontWeight.bold),),
                                  ],
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 30.0,bottom:10.0),
                                  child: Text(stat,style: TextStyle(fontSize: 22.5,fontWeight: FontWeight.bold),),
                                ),

                                Row(
                                  children: [
                                    Container(

                                      margin: EdgeInsets.only(right: 10.0),
                                     
                                      child: Icon(growthIndicator, color: logoMainColor,size: 17.5),
                                    ),

                                    Container(
                                      child: Text(growthPercentage,style: TextStyle(color: logoMainColor,fontWeight: FontWeight.bold,fontSize: 11.5)),
                                    ),

                                   Text(' vs last 7 days',style: TextStyle(color:Color(0xFF8a919f),fontSize: 11.5,fontWeight: FontWeight.bold )),
                                  ],
                                ),
                              ],
                            ),
                          ) ,
                        );
                      
  }


}