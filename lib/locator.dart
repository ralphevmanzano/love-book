import 'package:get_it/get_it.dart';
import 'package:love_book/core/services/auth_service.dart';
import 'package:love_book/core/services/dialog_service.dart';
import 'package:love_book/core/services/requests_service.dart';
import 'package:love_book/core/services/storage_service.dart';
import 'package:love_book/core/services/user_service.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:love_book/core/viewmodels/profile_model.dart';
import 'package:love_book/core/viewmodels/search_model.dart';
import 'package:love_book/core/viewmodels/home_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => RequestsService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => UserService());
  locator.registerFactory(() => StorageService());
  
  locator.registerLazySingleton(() => AuthModel());
  locator.registerLazySingleton(() => HomeModel());
  locator.registerFactory(() => SearchModel());
  locator.registerFactory(() => ProfileModel());
}
