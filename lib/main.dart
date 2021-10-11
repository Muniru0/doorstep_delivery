import 'package:doorstep_delivery/model_registry.dart';
import 'package:doorstep_delivery/services/data_models/user_data_model.dart';
import 'package:doorstep_delivery/services/models/user_model.dart';
import 'package:doorstep_delivery/ui/routes/app_init_error_route.dart';
import 'package:doorstep_delivery/ui/routes/blocked_route.dart';
import 'package:doorstep_delivery/ui/routes/home_route.dart';
import 'package:doorstep_delivery/ui/routes/is_loading_route.dart';
import 'package:doorstep_delivery/ui/routes/login_route.dart';
import 'package:doorstep_delivery/ui/routes/onboarding_route.dart';
import 'package:doorstep_delivery/ui/routes/otp_verification_route.dart';
import 'package:doorstep_delivery/ui/routes/re_authentication_route.dart';
import 'package:doorstep_delivery/ui/routes/signup_route.dart';
import 'package:doorstep_delivery/ui/routes/test_route.dart';
import 'package:doorstep_delivery/ui/routes/unknown_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doorstep_delivery/router/router.dart' as routes;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
 await Firebase.initializeApp();
  setupRegister();



 //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doorstep Delivery',
      theme: buildTheme(),
      debugShowCheckedModeBanner: false,
      onUnknownRoute: (settings) {
          return CupertinoPageRoute(builder: (_) =>const UnknownRoute());
        },
       home:  FutureBuilder(
         future: register<UserModel>().init(),
         builder: (context, snapshot) {

    
            return const TestRoute();
        
        if (snapshot.hasError) {
          return const AppInitErrorRoute();
        }
          
          if(snapshot.connectionState == ConnectionState.waiting){
          
            return const IsLoadingRoute();
          }

         

      //   return const SignUpRoute();

         if (snapshot.connectionState == ConnectionState.done) {
                    Map? snapshotData = snapshot.data! as Map<String,dynamic>;
                    if (!snapshot.hasData || !snapshotData['result']) {
                    
                        return const OnboardingRoute();
                    }
                   
                    Map? res = snapshot.data! as Map<String, dynamic>;
                  
                    MyUser _user = res['user_data']; 
                   
                  
                 
                    // if the user is blocked the
                    if (_user.blocked) {
                      return BlockedRoute();
                    }

                    if(res['show_onboarding']){
                        return const OnboardingRoute();
                    }

                    if(!res['phone_verification']){

                      return const OTPVerificationRoute();
                    }

                    if(res['firebase_user'] != null && _user.firebaseUid.isNotEmpty){
                     
                       return const ReAuthRoute();
                    }

            }

            return const LoginRoute();
         }

         
       ),
      onGenerateRoute: routes.generateRoute,
      
    );
  }



   ThemeData buildTheme() {
    return ThemeData(fontFamily: "WorkSans", visualDensity: VisualDensity.adaptivePlatformDensity).copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
        },
      ),
    );
  }
}



