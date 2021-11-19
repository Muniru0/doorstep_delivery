
import 'package:doorstep_delivery/constants/constants.dart';
import 'package:doorstep_delivery/services/models/courier_company_model.dart';
import 'package:doorstep_delivery/ui/base_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:doorstep_delivery/ui/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class ReferAFriendRoute extends StatefulWidget {
  const ReferAFriendRoute({ Key? key }) : super(key: key);

  @override
  _ReferAFriendRouteState createState() => _ReferAFriendRouteState();
}

class _ReferAFriendRouteState extends State<ReferAFriendRoute> {
  
  
  late double _w;
  late double _h;
  @override
  Widget build(BuildContext context) {

    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;

    return BaseView<DeliveryPersonelModel>(
      isBlankBaseRoute: true,
        child: Container(
          width: _w, 
          height: _h ,
          padding: EdgeInsets.only(top: 30.0),
           child: 
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children:[

              Container(
                width: _w,
                height: _h * 0.5,
                child: Image.asset(Constants.PARCEL_ICON,fit: BoxFit.cover)
              ),
               Expanded(child: SizedBox()),

              Container(
                width: _w,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Text('Refer A Friend',style: TextStyle(color: white, fontSize: 25.0, fontWeight: FontWeight.bold))
              ),

               Container(
                 width: _w,

                margin:const EdgeInsets.symmetric(vertical: 20.0,horizontal: 25.0),
                child: Text('Get increadible discounts and amazing gifts for you and your friend when they apply your code immediately after sign-up.',style: TextStyle(color: white, fontSize: 11.5, fontWeight: FontWeight.bold))
              ),

              //    Container(
              //    width: _w,
              //   alignment: Alignment.center,
              //   margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 25.0),
              //   child: Text('Referal Code\t\t #W123Mn',style: TextStyle(color: white, fontSize: 12.5, fontWeight: FontWeight.bold))
              // ),

              InkWell(
                onTap: (){
                  Clipboard.setData(ClipboardData(text:'#23WyKBM2' ));
                  UtilityWidgets.getToast('Copied  to Clipboard');
                },
                child: Container(
                              width: _w,
                              height: _h * 0.07,
                              margin: EdgeInsets.symmetric(horizontal: 25.0),
                              padding: EdgeInsets.only(left: 20.0),
                              decoration: BoxDecoration(
                                 color: Color(0xFFc1bdbd).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Row(
                                children: [
                                  Text('#23WyKBM2',style: TextStyle(color:white,fontWeight: FontWeight.bold,fontSize: 14.0),),
                                  Expanded(child: SizedBox()),
                                  Material(
                                  elevation: 2.0,
                                  borderRadius: BorderRadius.circular(13.0),
                                  child: Container(
                                    width: 95.0,
                                    height: _h * 0.07,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13.0)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                           Icon(Feather.copy,color: Color(0xFF5e5259),size: 17.0 ),
                                          
                                          SizedBox(width: 5.0,),
                                          Text('Copy',style: TextStyle(color: Color(0xFF564950),fontSize: 11.0,
                                  ),
                  
                ),
                                        ],
                                      ),
                  )),
                
                               
                                ],
                              )
                            ),
              ),

              SizedBox(height: 30.0),

              
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(13.0),
                      child: Container(
                        width: _w * 0.7,
                        margin: EdgeInsets.only(left: 15.0),
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('SHARE WITH FRIENDS',style: TextStyle(color: Color(0xFF5e5259),fontSize: 11.5,fontWeight: FontWeight.bold
                      ),

                      
                    ),
                    SizedBox(width: 5.0),
                    Icon(AntDesign.sharealt,color:Color(0xFF5e5259),size: 22.5 )
                            ],
                          ),
                      )),
                  ],
                ),
              
                
                Expanded(child: SizedBox())
                ]
           ),
          decoration: BoxDecoration(
            color: Color(0xFFcd9f6a),
            // gradient: LinearGradient(
            //   colors: [logoMainColor,logoBackgroundColor,white],
            //   stops: [0.6,.2,.2],
            //   begin: Alignment.bottomCenter,
            //   end: Alignment.topCenter, 
            // ),

           
          ),
        ),
    );
  }
}