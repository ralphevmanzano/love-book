import 'package:get_it/get_it.dart';
import 'package:love_book/core/service/auth_service.dart';
import 'package:love_book/core/service/dialog_service.dart';
import 'package:love_book/core/service/requests_service.dart';
import 'package:love_book/core/service/user_service.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';
import 'package:love_book/core/viewmodels/home_model.dart';
import 'package:love_book/core/viewmodels/requests_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => RequestsService());
  locator.registerLazySingleton(() => DialogService());
  
  locator.registerLazySingleton(() => AuthModel());
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => RequestsModel());
}
