import 'package:get_it/get_it.dart';
import 'package:love_book/core/service/auth_service.dart';
import 'package:love_book/core/service/dialog_service.dart';
import 'package:love_book/core/service/requests_service.dart';
import 'package:love_book/core/service/user_service.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:love_book/core/viewmodels/user_model.dart';
import 'package:love_book/core/viewmodels/profile_model.dart';
import 'package:love_book/core/viewmodels/requests_model.dart';
import 'package:love_book/core/viewmodels/search_model.dart';
import 'package:love_book/ui/views/search_view.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => RequestsService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerFactory(() => UserService());
  
  locator.registerLazySingleton(() => AuthModel());
  locator.registerFactory(() => SearchModel());
  locator.registerFactory(() => UserModel());
  locator.registerFactory(() => RequestsModel());
  locator.registerFactory(() => ProfileModel());
}
