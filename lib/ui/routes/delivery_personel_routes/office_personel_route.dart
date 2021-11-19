import 'dart:math';
import 'package:doorstep_delivery/constants/constants.dart';
import 'package:doorstep_delivery/services/models/courier_company_model.dart';
import 'package:doorstep_delivery/ui/base_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:simple_animations/simple_animations.dart';




class OfficePersonel extends StatefulWidget {
  const OfficePersonel({ Key? key }) : super(key: key);

  @override
  _OfficePersonelState createState() => _OfficePersonelState();

}

class _OfficePersonelState extends State<OfficePersonel> {
 
 late double _w;
 late double _h;

  late bool _showSortWidget;

  late bool isAtBeginingOfList;

  late int sortByNumberOfParcels;

 late  int sortByDateAdded;

 late  int sortByBestRating;

 late bool showSearchTextField;

 @override
  void initState() {
     
    _showSortWidget = false; 
    isAtBeginingOfList = false;
    showSearchTextField = false;
    sortByNumberOfParcels = 0;
    sortByBestRating = 0;
    sortByDateAdded = 0;

    super.initState();
  }
 



Widget sortItemWidget(title, subtitle,iconData,onTap,{ bool isSelected = false, required onChanged(sortOrder), bool isDesc = false}){


  return   InkWell(
    onTap: onTap,
    child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              width: _w * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:isSelected ? white  : logoBackgroundColor,
              ),
              margin: EdgeInsets.only(bottom: 10.0),
              child: PlayAnimation<double>(
              tween: Tween(begin: 0.0 , end: 1.0),
                builder: (context, snapshot,value) {
                  return Material(
                     borderRadius: BorderRadius.circular(10),
                    color:isSelected ? white  : logoBackgroundColor,
                    elevation: isSelected ? 2.0 * value:  0.0 * value,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
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
                              child: IconToggle(unselectedIcon:Entypo.chevron_thin_up,unselectedColor:  logoMainColor ,selectedIcon: Entypo.chevron_thin_down,selectedColor: logoMainColor,onChanged:onChanged,selected: isDesc,duration:Duration(milliseconds: 700),size: 17.5),
                            ),
                          ),
                      ],),
                    ),
                  );
                }
              ),
            ),
  );
                        
 
                                
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
          child: Stack(
            children: [
            
              Column(
                children: [
                  Container(
                    width: _w,
                    child: Column(
                      children: [
                        PlayAnimation<double>(
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
                                    
                                        Text('OfficePersonel',style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold)),
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
                        ),


                        Container(
                          width: _w,
                          height: _h * 0.7,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 0.0),
                            itemCount: 10,itemBuilder: (context,i) => officePersonelWidget(officePersonel: OfficePersonel(),index: i,isLast: i == 9))
                        ),

                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: -10.0,
                child: Material(
              
                  borderRadius: BorderRadius.circular(25.0),
                  elevation: 35.0,
                  child:Container(
                      padding: EdgeInsets.all(15.0),
                    width: _w,height:_h * 0.235,
                  child:Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.1, color:Color(0xFFa4a4a4))),
                        ),
                        child: Row(children: [
                          Text('Total number of parcels',style: TextStyle(color: Color(0xFFa4a4a4), fontSize: 13.0,fontWeight: FontWeight.bold)),
                          Expanded(child: SizedBox()),
                          Text('19k',style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold,))
                        ],),
                      ),

                   Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.1, color:Color(0xFFa4a4a4))),
                        ),
                        child: Row(children: [
                          Text('Discount',style: TextStyle(color: Color(0xFFa4a4a4), fontSize: 13.0,fontWeight: FontWeight.bold)),
                          Expanded(child: SizedBox()),
                          Text('0%',style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold,color: logoMainColor))
                        ],),
                      ),

                  Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.1, color:Color(0xFFa4a4a4))),
                        ),
                        child: Row(children: [
                          Text('Total amount',style: TextStyle( fontSize: 15.0,fontWeight: FontWeight.bold)),
                          Expanded(child: SizedBox()),
                          Text('${Constants.CEDI_SYMBOL} 78k',style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold,))
                        ],),
                      ),

                 
                 
                  ],) ) ,
                ),
              ),
            Positioned.fill(child: Visibility(visible: _showSortWidget,child: Container(color: black.withOpacity(_showSortWidget ? 0.3: 0.0)  ))),
              AnimatedPositioned(
                duration: Duration(milliseconds: 700),
                curve: Curves.ease,
                bottom:_showSortWidget ? -5.0 : -_h,
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
                            InkWell(
                              onTap: (){
                                setState(() {
                                  _showSortWidget = false;
                                });
                              },
                              child: Container(margin: EdgeInsets.only(left: 20.0,),child: Icon(Feather.x,size: 17.0))),
                          
                            Container(child: Text('Sort by',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                            
                             Opacity(opacity: 0.0,child: Container(margin: EdgeInsets.only(right: 20.0),child: Icon(Feather.x,size: 17.0)))
                          ],
                        ),
                      ),
              
                      

                              Container(
                              width: _w,
                              height:_h * 0.3 ,
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  sortItemWidget('Number of parcels','double tap for desc or asc',Fontisto.shopping_package ,(){
                                    setState(() {
                                      if(sortByNumberOfParcels > 0){
                                        sortByNumberOfParcels = 0;
                                        return;
                                      }
                                      sortByNumberOfParcels = 1;
                                    });
                                  },onChanged: (sortOrder) {

                                    if(sortByNumberOfParcels == 0){
                                      return;
                                    }

                                     if(sortByNumberOfParcels == 2){
                                       
                                       setState(() {
                                         sortByNumberOfParcels = 1;
                                       });
                                       return;
                                     }

                                    setState(() {
                                      sortByNumberOfParcels = 2;
                                    });
                                    
                                  },isSelected: sortByNumberOfParcels > 0,isDesc:sortByNumberOfParcels > 1),
                                   sortItemWidget('Best rating and reviews','double tap for desc or asc',AntDesign.star,(){
                                       setState(() {
                                         if(sortByBestRating > 0){
                                           sortByBestRating = 0;
                                           return;
                                         }
                                      sortByBestRating = 1;
                                    });
                                   },onChanged: (sortOrder) {
                                     if(sortByBestRating == 0){
                                      return;
                                    }

                                     if(sortByBestRating == 2){
                                       setState(() {
                                         sortByBestRating = 1;
                                       });
                                      return;
                                    }



                                    setState(() {
                                      sortByBestRating = 2;
                                    });
                                    
                                  },isSelected: sortByBestRating > 0,isDesc:sortByBestRating > 1),
                                  sortItemWidget('Date Added','double tap for desc or asc',Feather.calendar,(){
                                     setState(() {
                                       if(sortByDateAdded == 1){
                                         sortByDateAdded = 0;
                                         return;
                                       }
                                      sortByDateAdded = 1;
                                    });
                                  },onChanged: (sortOrder) {
                                    
                                    
                                     if(sortByDateAdded == 0){
                                       
                                      return;
                                    }

                                     if(sortByDateAdded == 2){
                                       setState(() {
                                         sortByDateAdded = 1;
                                       });
                                      return;
                                    }

                                    setState(() {
                                      sortByDateAdded = 2;
                                    });
                                    
                                  },isSelected: sortByDateAdded > 0, isDesc:sortByDateAdded > 1)
                                ],
                              ),
                            ),
                        
                     

                          
                        Container(
                          margin: EdgeInsets.symmetric(vertical:20.0 ),
                          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 45.0),
                          decoration: BoxDecoration(
                            color:logoMainColor,
                            borderRadius: BorderRadius.circular(10)),
                          child: Text('Apply',style: TextStyle(color: white, fontSize: 13.5,)),
                        )
              
                    ]
                     ,)),
                ),
              ),
            
           
            ],
          ),
        ),
      
    );
  }

  Widget officePersonelWidget({required OfficePersonel officePersonel , int index = 0, bool isLast = false}) {

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


}