import 'package:doorstep_delivery/constants.dart';
import 'package:doorstep_delivery/model_registry.dart';
import 'package:doorstep_delivery/services/models/auth_model.dart';
import 'package:doorstep_delivery/services/models/user_model.dart';
import 'package:doorstep_delivery/ui/base_route.dart';
import 'package:doorstep_delivery/ui/routes/login_route.dart';
import 'package:doorstep_delivery/ui/utils/colors_and_icons.dart';
import 'package:doorstep_delivery/ui/utils/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:validators/validators.dart';

class SignUpRoute extends StatefulWidget {

  final bool fromOnBoardingRoute;
  const SignUpRoute({this.fromOnBoardingRoute = false,Key? key}): super(key: key);

  @override
  _SignUpRouteState createState() => _SignUpRouteState();
}

class _SignUpRouteState extends State<SignUpRoute> {
 late double _w;
 late double _h;

 late bool emailHighlighted;

  TextEditingController fullnameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController(); 
  TextEditingController confirmPasswordController = TextEditingController();

  late String validationError;
 
  late AuthModel _authModel;

  late OverlayEntry _genderOverlayEntry;
 late OverlayEntry _roleOverlayEntry;
 late OverlayEntry _activeOverlayEntry;
  CustomAnimationControl animControl = CustomAnimationControl.play;

  TextEditingController dateOfBirthController = TextEditingController();

late  String selectedGender ;

late  String selectedRole;

  FocusNode focusNode = FocusNode();

late  bool companiesSearchError;

 late UserModel _userModel;

late  bool isFetchingCompanies;

late  bool noCourierCompaniesFound;

 late String selectedTownOrCity;
 late OverlayEntry _townOrCityOverlayEntry;
  OverlayState? overlayState;
 late OverlayEntry _signupConfirmationOverlayEntry;

 late List choices;

 late bool showCompanySearchDialog;

  TextEditingController addressController = TextEditingController();

 late bool _showBlurredOverlay;
 late bool overlayStateOccupied;
  
  
  @override
  void initState() {
    
    super.initState();
   overlayState = Overlay.of(context);
    _showBlurredOverlay = false;
    overlayStateOccupied = false;
    emailHighlighted = true;
    validationError = '';
    selectedGender = '';
    selectedRole = '';
    companiesSearchError =false;
    isFetchingCompanies = false;
    noCourierCompaniesFound = false;  
    selectedTownOrCity = "";
    choices = [];
    showCompanySearchDialog = false;
    
    _authModel = register<AuthModel>();
    _userModel = register<UserModel>();
    
      
  }
  @override
  Widget build(BuildContext context) {
    _w = MediaQuery.of(context).size.width;
    _h = MediaQuery.of(context).size.height;
    return Scaffold(
      
      body: BaseView<AuthModel>(
        showBlurredOverlay: _showBlurredOverlay,
        isBlankBaseRoute: true,
              child: SizedBox(
        width: _w,
        height: _h,
        child: 
                ListView(
                  shrinkWrap: true,
                  children: [
                    InkWell(onTap: (){
                      if(Navigator.canPop(context)){
                Navigator.pop(context);
                      }else{
                     Navigator.push(context, CupertinoPageRoute(builder:(context)=>const  LoginRoute()));
                      }
                   
                    },
                        child: Container(
                        width: _w,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: _h * 0.05,left: 20.0),
                       
                      child:const Icon(Ionicons.ios_arrow_back,
                       color: primaryColor,
                        size: 17.0 ),
                      ),
                    ),

                    Container(
                      width: _w,
                      margin: EdgeInsets.only(top: _h * 0.07),
                      alignment: Alignment.center,
                      child: const Text("Create Account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27.0))
                    ),
                    Container(
                      margin:const EdgeInsets.only(top: 3.0, bottom:5.0),
                      alignment: Alignment.center,
                      child: Text("Create a new account", style: TextStyle(color: Colors.black.withOpacity(0.8) , fontSize: 14.0))
                    ),
                     Container(
                       width: _w * 0.8,
                      margin:const EdgeInsets.only(top: 3.0, bottom:5.0,),
                      alignment: Alignment.center,
                      child: Text("Note: Signup if you have never signup for any account on Doorstep.",textAlign: TextAlign.center, style: TextStyle(color: Colors.black.withOpacity(0.8) , fontSize: 11.0))
                    ),

                   
                  Container(
                    width: _w * 0.8,
                      margin:const EdgeInsets.only(top: 3.0, bottom:20.0),
                        alignment: Alignment.center,
                        child: Text(validationError,textAlign: TextAlign.center, style:const TextStyle(color: errorColor , fontSize: 14.0))
                    ),
                     

                   
                
                  inputField(controller: fullnameController,icon: Feather.user,title: 'Fullname',hint:'eg. Yussif Muniru-Wulon',onChanged: (String name){
                    
                     
                  }),
                  
                   inputField(controller:emailController ,icon: Feather.mail,title: 'Email',defaultValue: 'email',onChanged: (String email){
                     
                   }),
                  
                  inputField(controller: phoneController,icon: Feather.phone,title: 'Phone',onChanged: (String phone){
                     
                  }), 
                   inputField(controller: dateOfBirthController,icon: Feather.phone,title: 'YYYY-MM-DD',onChanged: (String birthDate){
                     
                  }),

                    genderField(),  
                    selectTownOrCity(),
                    selectUserRole(),
                      
                   inputField(controller: addressController,icon: Entypo.address,title: 'Address',onChanged: (String password){
                      
                    }),
                    inputField(controller: passwordController,icon: Feather.lock,obscureText: true,title: 'Password',onChanged: (String password){
                      
                    }),
                    
                    inputField(controller: confirmPasswordController,icon: Feather.lock,title: 'Confirm Password',hasMargin: false,obscureText: true,onChanged: (String confirmPassword){
                     
                    }),
                          
                        
                                      
            InkWell(
            onTap: (){
              if(FocusScope.of(context).hasFocus){
                  FocusScope.of(context).unfocus();
              }
              if(!validateSignupForm()){

              return;
              }
            showSignupConfirmationOverlay();
            },

        child: Container(
        width: _w,
        height: 50.0,
        alignment: Alignment.center,
        padding:const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color:primaryColor,
          borderRadius: BorderRadius.circular(5.0),
            ),
            margin:const EdgeInsets.only(bottom: 30.0,top: 35.0,left: 20.0, right: 20.0),
            child:const Text('CREATE ACCOUNT', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0,color: white )),
          ),
        ),
      
      
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Text("Already have an account? ",  style: TextStyle(
                            color: Color(0xFF898989) ,
                            fontSize: 14.0,
                          ),
                      ),
                    
                      InkWell(onTap: (){
                        if(Navigator.canPop(context)){
                          if(widget.fromOnBoardingRoute){
                              Navigator.pushNamed(context, Constants.LOGIN_ROUTE);
                              return;
                          }
                     Navigator.pop(context);

                        }else{
                      Navigator.push(context, CupertinoPageRoute(builder:(context)=>const LoginRoute()));
                        }
                    
                      },child:const Text("Login", style: TextStyle(color: primaryColor, fontSize: 14.0),)),
                    ],
                  ),
                 const SizedBox(height: 35.0)
                    ],
                  ),
            
                                  
                            
                          ),
                        ),
                        
                      );
                    }
                                                   
                
   bool validateSignupForm(){
         
          validationError = '';
          if(!validateFullname()){
          validationError = 'Please provide your fullname without special characters.';
          }else if(!isEmail(emailController.text)){
              validationError = 'Email invalid.';
          }else if(!isNumeric(phoneController.text) && !isLength(phoneController.text.trim(),10,10) ){
        validationError = 'Phone number invalid.';
          }else if(!isLength(passwordController.text.trim(),8)){
            validationError = 'Minimum password length is 8.';
          } else if(!isDate(dateOfBirthController.text.trim())){
            validationError = 'Please follow the format of the date.';
          } else if(passwordController.text.trim().length < 8 ){
              validationError = 'Please password must be atleast 8 characters long.';
      
          }
          else if(passwordController.text.trim() != confirmPasswordController.text.trim()){
              validationError = 'Password and confirm password are not the same.';
      
          }else if(selectedGender.isEmpty){
              validationError = 'Please select a gender.';
          }
          else if(selectedRole.isEmpty){
              validationError = 'Please select a role.';
          } else if(selectedTownOrCity.trim().isEmpty){
              validationError = 'Please select your town or city.';
          }

           else if(addressController.text.trim().isNotEmpty && addressController.text.trim().length < 5){
              validationError = 'Address too short.';
          }
      
      
            
              setState((){ });
            
        // if(validationError.isNotEmpty){
        //   UtilityWidgets.requestErrorDialog(context,title: 'Validation',desc:validationError,cancelAction: (){
        //     Navigator.pop(context);
        //   });
        // }
          
          return validationError.isEmpty;
        }                
      
      
   bool validateFullname(){
          var name = fullnameController.text.trim();
          
          if(isLength(name,3)){
                        
          
            var nameContainsSpecialChars = false;
            name.split(' ').forEach((nameFraction){

              if(!isAlpha(nameFraction) && !name.contains('-') ){
                nameContainsSpecialChars = true;
                
                return;
              }
            
            });
          if(nameContainsSpecialChars || !name.contains(' ')){
            
            return false;
          }
          
          
        }
      
                return true;
        }  
        
        
                                            
   Widget genderField(){
            return   InkWell(
              onTap: (){
      
                if(FocusScope.of(context).hasFocus){
                    FocusScope.of(context).unfocus();
                }
                

                if(overlayStateOccupied){
                  return;
                }
                    _genderOverlayEntry = UtilityWidgets.choicesOverlay(context, animControl,showCancelButton: true,cancelAction:(){
                        _genderOverlayEntry.remove();
                        if(overlayStateOccupied){
                          setState(() {
                             overlayStateOccupied = false;
                              _showBlurredOverlay = false;
                          });
                        }
                    },overlayChoices: [
                    OverlayChoice(
                          choice: Constants.GENDER_MALE,
                          choiceAction:() {
                            handleGenderSelection(Constants.GENDER_MALE);
                          },
                          isSelected: selectedGender == Constants.GENDER_MALE,
                          ),
                    OverlayChoice(
                            choice: Constants.GENDER_FEMALE,
                            choiceAction:(){
                              handleGenderSelection(Constants.GENDER_FEMALE);
                            } ,
                            isSelected: selectedGender == Constants.GENDER_FEMALE)
                        ]);
                       
                  Overlay.of(context)!.insert(_genderOverlayEntry);
              
              setState(() {
          overlayStateOccupied = true;
            _showBlurredOverlay = false;
        });
                  
},
child: Column(
    children: [
    Container(
                                // height: 50.0,
              width: _w,
                
                    padding:const EdgeInsets.symmetric(horizontal: 15.0),
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: 
                        Container(
                          padding:const EdgeInsets.all(7.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:const EdgeInsets.only(left: 25.0,bottom: 5.0),
                                child:const Text("Gender", style: TextStyle(color: Color(0xFFC0C0C0),fontWeight: FontWeight.bold, fontSize: 14.0)),
                              ),
          
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin:const EdgeInsets.only(right: 7.0),
                                    child:const Icon(Ionicons.transgender_outline , color: primaryColor,size: 15.0),
                                  ),
                
              Container(
                      width: _w * 0.7,
                      padding:const EdgeInsets.only(right: 15.0), 
                      child: Container(
              child: selectedGender.isEmpty ? const Text("gender", style: TextStyle(color: Color(0xFFd7e0ef), )) : Text(selectedGender, style: const TextStyle(color: warmPrimaryColor, fontWeight: FontWeight.bold))
            ),
                                  
                                  
                                ),
                  
                
                                  
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            
                          ),
                          const  SizedBox(height: 30.0 ),
                                      ],
                                    ),
            );
                                      
      
        }                            

  handleGenderSelection(String gender) {
          
          if(selectedGender != gender){
      
            setState((){ selectedGender = gender;
              _showBlurredOverlay = true;
            });
      
          }
           
       
            _genderOverlayEntry.remove();
            setState(() {
              overlayStateOccupied = false; _showBlurredOverlay = false;
            });
          
        
        }


   void toggleBlurredOverlay (){
     setState(()=> _showBlurredOverlay = !_showBlurredOverlay);
      
   }

   showSignupConfirmationOverlay(){
        
         if(!_showBlurredOverlay){ setState(() =>
           
           _showBlurredOverlay = true
         );
         }

         if(overlayStateOccupied){ return;}
         
        _signupConfirmationOverlayEntry =  UtilityWidgets.signupConfirmationOverlay(context,  animControl, distanceFromBottom: 300.0 ,credential: phoneController.text.trim(),termsOfUseTap:(){
          Navigator.pushNamed(context,Constants.TERMS_AND_CONDITIONS_ROUTE);
        } ,handleConfirmation: ()async{
           
                     _signupConfirmationOverlayEntry.remove();                 
                               setState(() {
                                  overlayStateOccupied = false;
                               });   
                            UtilityWidgets.requestProcessingDialog(context,title: 'creating account',);
                    
                        
                         
                               // signup the user
                              Map<String,dynamic>? res =  await  _authModel.signupUserWithEmailAndPassword(emailController.text.trim(),passwordController.text.trim(),fullname: fullnameController.text.trim(),userRole: selectedRole,dateOfBirth: dateOfBirthController.text.trim(), 
                               address:addressController.text.trim(),
                               phone: phoneController.text.trim(),gender: selectedGender, townOrCity: selectedTownOrCity );
                    
                    
                                  if(Navigator.canPop(context)){
                                    Navigator.pop(context);
                                  }
                    
                                  
                           // show the error if the account creation failed.       
                              if(!res!['result']){
                              UtilityWidgets.requestErrorDialog(context,title: 'Account Creation',desc: res['desc'],cancelAction: (){
                                      if(Navigator.canPop(context)){
                                         Navigator.pop(context);
                                      }
                                      setState(() {
                                        _showBlurredOverlay = false;
                                      });
                              });
                              return;
                              }
                             

                  
                    // refresh the user model
                     _userModel.refreshUserModel(user: res['desc']);
                       
                  // send an otp code to verify the user's phone
                   res = await  _authModel.sendOTPCode(phoneNumber: _userModel.getUser.phoneNumber);
                   
                   // show the error if the otp sending failed
                    if(!res['result']){
                    UtilityWidgets.requestErrorDialog(context,title: 'Sending Code',desc: res['desc'],cancelAction: (){
                      Navigator.pop(context);
                    } );

                    return;
                    }


                  // move the otp verification screen if the otp was sent successfully
                 Navigator.pushNamedAndRemoveUntil(context, Constants.OTP_VERIFICATION_ROUTE,(route) => false);
                          
                                          
                                      
        },handleCancellation: (){
            _signupConfirmationOverlayEntry.remove();
            setState(() {
                 overlayStateOccupied = false;
                  _showBlurredOverlay = false;
            });
           
        });

   
       overlayState!.insert(_signupConfirmationOverlayEntry);
        setState(() {
          overlayStateOccupied = true;
        });
  
  
   }



   Widget selectTownOrCity(){
            return   InkWell(
              onTap: (){
      
                if(FocusScope.of(context).hasFocus){
                    FocusScope.of(context).unfocus();
                   
                }
               

                List<OverlayChoice> _overlayChoices  =[];
                
                Constants.ALLOWED_TOWN_OR_CITIES.forEach((String townOrCity) { 
                   _overlayChoices.add(OverlayChoice(
                          choice: townOrCity,
                          choiceAction:() {
                            handletownOrCitySelection(townOrCity);
                            if(overlayStateOccupied){
                              setState(() {
                                  overlayStateOccupied = false;
                                   _showBlurredOverlay = false;
                              });
                            }
                           
                      },
                      isSelected: selectedTownOrCity == townOrCity,
                      ));
            });

              if(overlayStateOccupied){
                return;
              }
                  _townOrCityOverlayEntry = UtilityWidgets.scrollableChoicesOverlay(context, animControl,title: "Town or City",showCancelButton: true, cancelAction: (){
                      _townOrCityOverlayEntry.remove();
                      setState(() {
                            overlayStateOccupied = false;
                              _showBlurredOverlay = false;
                      });
                    
                  },overlayChoices: _overlayChoices
                      
                      );
              
                      
                       Overlay.of(context)!.insert(_townOrCityOverlayEntry);
                      setState(() {
                        overlayStateOccupied = true;
                         _showBlurredOverlay = false;
                      });
                 
                      },
                          child: Column(
                              children: [
                   Container(
                      width: _w,
                          padding:const EdgeInsets.symmetric(horizontal: 15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: 
                                Container(
                                  padding:const EdgeInsets.all(7.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:const EdgeInsets.only(left: 25.0,bottom: 5.0),
                                        child:const Text("Town or city", style: TextStyle( color: Color(0xFFC0C0C0) ,fontWeight: FontWeight.bold, fontSize: 14.0)),
                                      ),
                  
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin:const EdgeInsets.only(right: 7.0),
                                            child:const Icon(FontAwesome.building_o, color: primaryColor,size: 15.0),
                                          ),
                  
                            Container(
                                    width: _w * 0.7,
                                    padding:const EdgeInsets.only(right: 15.0), 
                                    child: 
                                                                                                                Container(
                        child: selectedTownOrCity.isEmpty ? const Text("town or city", style: TextStyle( color: Color(0xFFd7e0ef), )) : Text(selectedTownOrCity, style: const TextStyle(color: warmPrimaryColor,fontSize: 14.0,fontWeight: FontWeight.bold ))
                      ),
    
                                    
                                  ),
                    
                                    
                                                      
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                
                                              ),
                                              const SizedBox(height: 30.0 ),
                                              ],
                                            ),
                                        );
                                                                  
                                  
                                    }                            
                            


  Widget selectUserRole(){
            return   InkWell(
              onTap: (){
      
                if(FocusScope.of(context).hasFocus){
                    FocusScope.of(context).unfocus();
                }
  
                List<OverlayChoice> _overlayChoices  =[];
                
             var m =  [Constants.COURIER_SERVICE_DIRECTOR_ROLE,Constants.COURIER_SERVICE_BRANCH_MANAGER_ROLE,Constants.COURIER_SERVICE_BRANCH_OFFICE_PERSONEL_ROLE].forEach((String role) { 
                   _overlayChoices.add(OverlayChoice(
                          choice: role,
                          choiceAction:() {
                            handleRoleSelection(role);
                      },
                      isSelected: selectedRole == role,
                      ));
            });

                  if(overlayStateOccupied){
                    return;
                  }
                          _roleOverlayEntry = UtilityWidgets.choicesOverlay(context, animControl,title: "Role",showCancelButton: true,cancelAction: (){
                            _roleOverlayEntry.remove(); 
                             if(overlayStateOccupied){
                               setState(() {
                                  overlayStateOccupied = false;
                                   _showBlurredOverlay = false;
                               });
                             }
                           
                          },overlayChoices: _overlayChoices
                                
                                );
              
              
                     Overlay.of(context)!.insert(_roleOverlayEntry);
                     setState(() {
                        overlayStateOccupied = true;
                        _showBlurredOverlay = false;
                      });
                     
                      },
                          child: Column(
                              children: [
                Container(
                      width: _w,
                          padding:const EdgeInsets.symmetric(horizontal: 15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: 
                                Container(
                                  padding:const EdgeInsets.all(7.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:const EdgeInsets.only(left: 25.0,bottom: 5.0),
                                        child:const Text("Role", style: TextStyle(color:Color(0xFFC0C0C0),fontWeight: FontWeight.bold, fontSize: 14.0)),
                                      ),
                  
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin:const EdgeInsets.only(right: 7.0),
                                            child:const Icon(Feather.user, color: primaryColor,size: 15.0),
                                          ),
                  
                            Container(
                                    width: _w * 0.7,
                                    padding:const EdgeInsets.only(right: 15.0), 
                                    child: 
                                                                                                                Container(
                                    child: selectedRole.isEmpty ? const Text("I am", style: TextStyle( color: Color(0xFFd7e0ef), )) : Text(selectedRole, style:const TextStyle(color: warmPrimaryColor ,fontSize: 14.0,fontWeight: FontWeight.bold))
                                                      ),
                                    
                                    
                                  ),
                    
                                    
                                                      
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                
                                              ),
                                              const  SizedBox(height: 30.0 ),
                                              ],
                                            ),
                                        );
                                                                  
                                  
                                    }                            
                                
                            
   void handleRoleSelection(String role) {
                          
        if(selectedRole != role){
    
          setState((){ selectedRole = role;
           _showBlurredOverlay = false;});
    
        }
        
          _roleOverlayEntry.remove();
          setState(() {
            overlayStateOccupied = false;
             _showBlurredOverlay = false;
          });
        
                  
     }
              
          
                                                
Widget inputField({controller,icon = "", title = '',hint = 'required', defaultValue = '', hasMargin = true, isActive,required Function (String value) onChanged,focusNode ,bool obscureText = false, isGender = false, onTap}){
                    
                      return   Column(
                    children: [
                      Container(
                              
                    width: _w,
                   padding:const EdgeInsets.symmetric(horizontal: 15.0),
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: 
                    Container(
                      padding:const EdgeInsets.all(7.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin:const EdgeInsets.only(left: 25.0,bottom: 5.0),
                            child: Text(title, style:const TextStyle(color: Color(0xFFC0C0C0),fontWeight: FontWeight.bold, fontSize: 12.0)),
                          ),
                    
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin:const EdgeInsets.only(right: 7.0),
                              child: Icon(icon, color: primaryColor,size: 14.0),
                            ),
                    
                        Container(
                          width: _w * 0.7,
                          padding:const EdgeInsets.only(right: 15.0), 
                          child: isGender ?     InkWell(
                            onTap:onTap,
                                child: Container(
                                child: selectedGender.isEmpty ? Text(defaultValue, style: const TextStyle(color: warmPrimaryColor,fontSize: 12.0 )) : Text(selectedGender, style:const TextStyle(color: primaryColor ))
                              ),
                                      ): 
                                      TextField(
                                        keyboardType: TextInputType.name ,
                                        controller:controller,
                                        focusNode: focusNode,
                                        textAlign: TextAlign.start,
                                        obscureText: obscureText,
                                        style:const TextStyle(
                                          color: warmPrimaryColor,
                                          fontSize: 13,
                                          fontWeight : FontWeight.bold,
                                        ),
                                        
                                        cursorColor: warmPrimaryColor,
                                        decoration: InputDecoration.collapsed(
                                          hintText: hint,
                                          hintStyle:const TextStyle(
                                            color: Color(0xFFd7e0ef),
                                            fontSize: 13,
                                          ),
                                        ),
                                        onChanged: onChanged,
                                      ),
                                   
                                    ),
                      
                    
                                      
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                
                              ),
                                SizedBox(height: hasMargin ? 30.0 : 0.0),
                              ],
                            );
                                                        
          }

 
      
 void handletownOrCitySelection(String townOrCity) {
                    
        if(selectedTownOrCity != townOrCity){
    
          setState((){ selectedTownOrCity = townOrCity;
           _showBlurredOverlay = false;
           });
    
        }
      
          _townOrCityOverlayEntry.remove();
          setState(() {
            overlayStateOccupied  = false;
             _showBlurredOverlay = false;
          });
        

        }


 void handleOverlayInsertion(OverlayEntry _overlayEntry){
  
    _activeOverlayEntry.remove();
    setState(() {
        overlayStateOccupied = false;
    });
    
    return;
  

}




}