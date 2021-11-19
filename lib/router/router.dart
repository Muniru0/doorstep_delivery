

import 'package:doorstep_delivery/constants/constants.dart';
import 'package:doorstep_delivery/ui/routes/forgot_password_route.dart';
import 'package:doorstep_delivery/ui/routes/home_route.dart';
import 'package:doorstep_delivery/ui/routes/login_route.dart';
import 'package:doorstep_delivery/ui/routes/otp_verification_route.dart';
import 'package:doorstep_delivery/ui/routes/password_updated_success_route.dart';
import 'package:doorstep_delivery/ui/routes/re_authentication_route.dart';
import 'package:doorstep_delivery/ui/routes/set_new_password_route.dart';
import 'package:doorstep_delivery/ui/routes/settings_route.dart';
import 'package:doorstep_delivery/ui/routes/signup_route.dart';
import 'package:doorstep_delivery/ui/routes/unknown_route.dart';
import 'package:doorstep_delivery/ui/routes/waiting_company_authorization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



Route<dynamic> generateRoute(RouteSettings settings) {

  switch (settings.name) {

          case Constants.SIGNUP_ROUTE:
          return CupertinoPageRoute(builder: (context) => const SignUpRoute());
          
          case Constants.OTP_VERIFICATION_ROUTE:
          return CupertinoPageRoute(builder: (_) => const OTPVerificationRoute()); 

           case Constants.RE_AUTH_ROUTE:
          return CupertinoPageRoute(builder: (context) =>const ReAuthRoute());
          
          case Constants.LOGIN_ROUTE:
          return CupertinoPageRoute(builder: (context) =>const LoginRoute());


          case Constants.FORGOT_PASSWORD_ROUTE:
          return CupertinoPageRoute(builder: (context) => ForgotPasswordRoute());

       
          case Constants.SET_NEW_PASSWORD_ROUTE:
          return CupertinoPageRoute(builder: (context) => const SetNewPasswordRoute());

          case Constants.WAITING_DIRECTOR_AUTHORIZATION_ROUTE :
          return CupertinoPageRoute(builder: (context) =>const WaitingCompanyAuthorizationRoute());

          case Constants.HOME_ROUTE:
          return CupertinoPageRoute(builder: (context) =>  HomeRoute()); 

          case Constants.PASSWORD_UPDATED_SUCCESSFULLY_ROUTE:
          return CupertinoPageRoute(builder: (context) =>const PasswordUpdatedSuccessfullyRoute());


          case Constants.SETTINGS_ROUTE:
          return CupertinoPageRoute(builder: (_) => SettingsRoute());



  //      case Constants.SELECT_LOCATION_ON_MAP_ROUTE:
  //     return CupertinoPageRoute(builder: (_) => SelectLocationOnMapRoute());

 
  //     case Constants.COURIER_DIRECTOR_HOME_ROUTE :
  //     return CupertinoPageRoute(builder: (context) => DirectorHomeRoute());
  //     case Constants.ADD_COMPANY_BASIC_INFO_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => AddCompanyBasicInfoRoute()); 
  //     case Constants.WELCOME_ROUTE:
  //     return CupertinoPageRoute(builder: (_) => WelcomeRoute()); 
  //      case Constants.ADDING_COMPANY_ROUTE :
  //     return CupertinoPageRoute(builder: (_) => AddingCompanyRoute()); 
  //      case Constants.SELECT_LOCATION_ON_MAP_ROUTE: 
  //     return CupertinoPageRoute(builder: (_) => SelectLocationOnMapRoute());
  //     case Constants.ADD_COMPANY_BRANCH_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => AddCourierCompanyBranchRoute());
  //    case Constants.ADD_COURIER_SERVICE_BRANCH_ROUTE: 
  //     return CupertinoPageRoute(builder: (_) => AddCourierCompanyBranchRoute()); 
  //     case Constants.ALL_BRANCHES_ROUTE: 
  //     return CupertinoPageRoute(builder: (_) => ViewAllCompanyBranches()); 
  //    case Constants.ALL_DELIVERY_STAFFS_ROUTE:
  //     return CupertinoPageRoute(builder: (_) => AllDeliveryStaffRoute());  
  //     case Constants.SUCCESSFULLY_ADDED_COURIER_AGENT_ROUTE:
  //     return CupertinoPageRoute(builder: (_) => SuccessfulCourierAgentAdditionRoute());
  //    case Constants.REGISTRATION_ROUTE:
  //     return CupertinoPageRoute(builder: (_) => RegisterRoute());
       
  //     case Constants.ALL_PARCELS_ROUTE :
  //     return CupertinoPageRoute(builder: (_) => AllParcelsListRoute()); 
  //     case Constants.SENT_PARCELS_ROUTE:
  //     return CupertinoPageRoute(builder: (_) => SentParcelsRoute());  
  //      case Constants.DELIVERED_PARCELS_ROUTE:
  //     return CupertinoPageRoute(builder: (_) => DeliveredParcelsRoute());
  //       case Constants.ONGOING_ACTIVITIES_ROUTE :
  //     return CupertinoPageRoute(builder: (_) => OnGoingActivitiesRoute());  
  //     case Constants.PARCEL_DETAILS_ROUTE :
  //     return CupertinoPageRoute(builder: (_) => ParcelDetailsRoute());
  //     case Constants.LOGIN_ROUTE:
  //     return CupertinoPageRoute(builder: (_) => LoginRoute());  
  //       case Constants.RE_AUTH_ROUTE:
  //     return CupertinoPageRoute(builder: (_) => ReAuthRoute());  
  //    case Constants.APP_INFO_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => AppInfoRoute());
  //   case Constants.SETTINGS_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => SettingsRoute(), fullscreenDialog: true);
  //   case Constants.PARCELS_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => ParcelsRoute());
  //    case Constants.ENTER_COURIER_SERVICE_INFO_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => CourierServiceInfoRoute());
  //  case Constants.CONFIRM_COURIER_SERVICE_INFO_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => ConfirmCourierServiceInfoRoute());
  //    case Constants.CONFIRM_PARCEL_DETAILS_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => ConfirmParcelDetailsRoute());
  //      case Constants.SUCCESSFUL_PARCEL_SENT_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => SuccessfulParcelRoute());
  //      case Constants.CONFIRM_PARCEL_PICKUP_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => ConfirmParcelPickUpRoute());
  //      case Constants.SENDING_OFFICER_HOME_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => SendingOfficerHomeRoute());
  //      case Constants.RECEIVING_OFFICER_HOME_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => ReceivingOfficerHomeRoute());
  //     case Constants.SENDING_OFFICER_SETTINGS_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => SendingOfficerSettingsRoute(), fullscreenDialog: true);
  //      case Constants.RECEIVING_OFFICER_SETTINGS_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => ReceivingOfficerSettingsRoute(), fullscreenDialog: true);
  //     case Constants.COURIER_MANAGER_SETTINGS_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => CourierManagerSettingsRoute(), fullscreenDialog: true);
  //      case Constants.SUCCESSFUL_PARCEL_PICK_UP_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => SuccessfulParcelPickUpRoute());
  //      case Constants.PARCELS_FILTER_ROUTE:
  //     return CupertinoPageRoute(builder: (context) => ParcelsFilterRoute());
  //      case Constants.EMAIL_VERIFICATION_ROUTE :
  //     return CupertinoPageRoute(builder: (context) =>EmailVerificationRoute());
  //      case Constants.FORGOT_PASSWORD_ROUTE :
  //     return CupertinoPageRoute(builder: (context) => ForgotPasswordRoute());
  //      case Constants.SET_NEW_PASSWORD_ROUTE :
  //     return CupertinoPageRoute(builder: (context) => SetNewPasswordRoute());
  //      case Constants.PASSWORD_UPDATED_SUCCESSFULLY_ROUTE :
  //     return CupertinoPageRoute(builder: (context) => PasswordUpdatedSuccessfullyRoute());
  //     case Constants.PARCEL_SENDING_OFFICERS_ROUTE :
  //     return CupertinoPageRoute(builder: (context) => ManageSendingOfficersRoute());
  //     case Constants.PARCEL_RECEIVING_OFFICERS_ROUTE :
  //     return CupertinoPageRoute(builder: (context) => ForgotPasswordRoute());
  //     case Constants.PARCEL_DELIVERY_OFFICERS_ROUTE :
  //     return CupertinoPageRoute(builder: (context) => ForgotPasswordRoute());

      


      
      
  }
  return CupertinoPageRoute(builder: (context)=>UnknownRoute());
  
}
