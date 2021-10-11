
import 'dart:ui';

import 'package:doorstep_delivery/constants.dart';
import 'package:doorstep_delivery/model_registry.dart';
import 'package:doorstep_delivery/services/models/auth_model.dart';
import 'package:doorstep_delivery/services/models/courier_company_model.dart';
import 'package:doorstep_delivery/services/models/user_model.dart';
import 'package:doorstep_delivery/ui/base_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:doorstep_delivery/ui/utils/helper_functions.dart/functions.dart';
import 'package:doorstep_delivery/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:scoped_model/scoped_model.dart';


class WaitingCompanyAuthorizationRoute extends StatefulWidget {
  const WaitingCompanyAuthorizationRoute({ Key? key }) : super(key: key);

  @override
  _WaitingCompanyAuthorizationRouteState createState() => _WaitingCompanyAuthorizationRouteState();
}

class _WaitingCompanyAuthorizationRouteState extends State<WaitingCompanyAuthorizationRoute> {
  
  late double _w;
  late double _h;
  late UserModel _userModel;
  late bool showLoadingIndicator;



  @override
  void initState() {
     _userModel  =register<UserModel>();
    showLoadingIndicator = false;
    super.initState();
   
  }


  @override
  Widget build(BuildContext context) {

    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return BaseView<CompanyModel>(
      
      isBlankBaseRoute: true,
      child:SizedBox(
        width:_w,
        height: _h,
        child: Column(
          children: [
           const SizedBox(height: 30.0,),
                    Row(
                      children:[
                   
                        Container(
                           margin:const EdgeInsets.only(left: 20.0),
                          child:const Text('DOORSTEP',style: TextStyle(color: brightMainColor,fontSize: 13.0,fontWeight: FontWeight.bold))
                        ),
                       const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: ()async{
                            UtilityWidgets.requestProcessingDialog(context,title: 'Sign-Out...');
                         Navigator.pushNamedAndRemoveUntil(context, Constants.RE_AUTH_ROUTE , (route) => false);
                          },
                          child: Container(
                            margin:const EdgeInsets.only(right: 20.0),
                            child:const Icon(Feather.lock,color: silverColor,size: 15.0),
                          ),
                        ),
                     
                     
                      ],
                                 ),

                                Container(
                                  margin:const EdgeInsets.only(top: 35.0),
                                  child:const Text('Awaiting Director Authorization',style: TextStyle(color: warmPrimaryColor,fontWeight: FontWeight.bold,fontSize: 14.5)),
                                ),
                             

                                 Container(
                                   margin:const EdgeInsets.only(top: 25.0,bottom: 10.0),
                                   width: 120,
                                   height: 120.0,
                                   child: Container(
                                     width: 30,
                                     height: 30,
                                     padding:const EdgeInsets.only(left: 20.0 ),
                                    
                                     alignment: Alignment.topRight,
                                     decoration: BoxDecoration(
                                     color:const Color(0xFFC0C0C0).withOpacity(0.5),
                                     borderRadius:BorderRadius.circular(7.0),

                                   ),
                                     child:Image.asset('assets/images/parcel_icon.png'),
                                   ),
                                 ),
                                 dot(color: brightMainColor.withOpacity(0.3)),
                                 dot(size: 7.5,color: brightMainColor.withOpacity(0.3)),
                                 dot(size: 10.0,color: brightMainColor.withOpacity(0.4)),
                                 dot(size: 11.5,color: brightMainColor.withOpacity(0.45)),
                                
              Stack(
                alignment:Alignment.center,
                children: [
                 Material(
                 elevation: 20.0,
                 borderRadius: BorderRadius.circular(20.0),
                 child: Container(
                 
                   width: _w * 0.9,
                   height: _h * 0.41,
                   padding:const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
                   child:Column(children: [
                   Text(_userModel.getUser.userRole,style:const TextStyle(color: brightMainColor, fontSize: 14.5,fontWeight: FontWeight.bold)),
                     

                      Container(
                        margin:const EdgeInsets.only(top: 10.0,bottom:15.0),
                       child:  RichText(text: TextSpan(
                         children: [
                           const TextSpan(text: 'staff: ',style: TextStyle(color: fadedHeadingsColor,fontSize: 12.5)),
                           TextSpan(text: _userModel.getUser.fullname,style:const TextStyle(color: warmPrimaryColor,fontSize: 14.5,fontWeight: FontWeight.bold))
                         ]
                       )) ,
                     ),
                     Container(
                       padding:const EdgeInsets.all(9.0),
                       margin:const EdgeInsets.only(bottom: 15.0),
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.0),
                       color:brightMainColor.withOpacity(0.8)
                       ),
                       child: Text("${DateTime.now().day} - ${monthFormator(DateTime.now().month)}",style: const TextStyle(color: white,fontSize: 13.0))
                     ),

                  managerDetailWidget(title: 'name',desc:_userModel.getUser.fullname),
                  managerDetailWidget(title: 'email',desc:_userModel.getUser.email),
                  managerDetailWidget(title: 'phone',desc:_userModel.getUser.phoneNumber),
                  managerDetailWidget(title: 'Town',desc:_userModel.getUser.townOrCity),
                  managerDetailWidget(title: 'D.O.B',desc:_userModel.getUser.dateOfBirth),
                  managerDetailWidget(title: 'Address',desc:_userModel.getUser.address),
                   ],) ,
                 ),
               ),

                
             
                ],
              ),     
        Material(
          elevation:15.0 ,
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.transparent,
          shadowColor: black.withOpacity(0.45),
          child:
                  ScopedModelDescendant<CompanyModel>(
                 
                    builder: (context, widget,model) {
                      return InkWell(
                        onTap: ()async{
                         // model.getStaffAuthorization
                        setState(() {
                          showLoadingIndicator = true;
                        });
                     Map<String,dynamic> res =   await  model.getCompanyStaff(userRole: _userModel.getUser.userRole,firebaseUid: _userModel.getUser.firebaseUid); 
                     
                       setState(() {
                          showLoadingIndicator = false;
                        });
                       
                     if(!res['result']){
                       UtilityWidgets.requestErrorDialog(context,title: 'Request ',desc: res['desc'],cancelAction: (){
                         Navigator.pop(context);
                       },cancelText: 'Ok');
                       return;
                     }   
                     if(res['company_data'] == null){
                       UtilityWidgets.getToast('Not yet authorized.',textColor:white,duration: '2');
                       return;
                     }
                     UtilityWidgets.requestSuccessDialog(context,title:'Authorization Success',desc: 'Please tap below to continue',cancelAction: (){
                       Navigator.pop(context);
                     },cancelText: 'Continue');
                        
                        },
                      
                              child: 
                                      Container(
                                      width: _w,
                                      height: 50.0,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                                      decoration: BoxDecoration(
                                        color:brightMainColor,
                                        borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          margin:const EdgeInsets.only(top: 15.0,left: 20.0, right: 20.0),
                                          child: 
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Text('CHECK AUTHORIZATION', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0,color: white )),
                                              const  SizedBox(width: 15.0),
                                                 Visibility(visible:showLoadingIndicator,child: loadingIndicator(valueColor: white))
                                                                 
                                                             
                                              ],
                                            ),
                                          
                                   
                            
                              ),
                          );
                    }
                  ),
        ),
      
      

          const Expanded(child: SizedBox()),
         
          ],
        ),
      ),
      
    );
  }



  Widget managerDetailWidget({title = '',desc = ''}){
    return Container(
      margin:const EdgeInsets.only(bottom: 11.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
             Container(
              //width:,
              margin:const EdgeInsets.only(left: 20.0),
              child: Text(title, style:const TextStyle(color: Color(0xFFC0C0C0),fontSize: 14.0))
            ),
        
       
        

          Container(
            width: _w * 0.5,
            alignment: Alignment.centerRight,
            //width: desc.length > 20 ? 120 : null,
           // margin: EdgeInsets.only(left: 10.0,right: 10.0),
            child: Text(desc,overflow: TextOverflow.ellipsis,style:const TextStyle(color:warmPrimaryColor,fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
  Widget dot({double size = 5,color}){
    return Container(
      margin:const EdgeInsets.only(bottom: 10.0),
      width:size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}


             
     
            
         