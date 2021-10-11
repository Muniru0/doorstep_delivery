
// import 'package:Business4pay/models/auth_model.dart';
// import 'package:Business4pay/models/base_model.dart';
// import 'package:Business4pay/models/business_model.dart';

// import 'package:Business4pay/models/courier_company_model.dart';
// import 'package:Business4pay/models/courier_industry_model.dart';
// import 'package:Business4pay/models/courier_manager_model.dart';
// import 'package:Business4pay/models/parcels_model.dart';
// import 'package:Business4pay/models/user_model.dart';
// import 'package:Business4pay/ui/routes/courier_industry/manager_home_route.dart';
import 'package:doorstep_delivery/services/models/base_model.dart';
import 'package:doorstep_delivery/services/models/user_model.dart';
import 'package:get_it/get_it.dart';


GetIt register = GetIt.I;
void setupRegister(){

  // registering services
   register.registerSingleton<BaseModel>(BaseModel());
  // register.registerSingleton<BusinessModel>(BusinessModel());
  // register.registerSingleton<CourierIndustryModel>(CourierIndustryModel());
  // register.registerSingleton<AuthModel>(AuthModel());
  // register.registerSingleton<ParcelsModel>(ParcelsModel());
  // register.registerSingleton<CourierManagerModel>(CourierManagerModel());
   register.registerSingleton<UserModel>(UserModel());
  // register.registerSingleton<CompanyModel>(CompanyModel());

  // registering models
  // register.registerFactory<ErrorModel>(() => ErrorModel());

}
