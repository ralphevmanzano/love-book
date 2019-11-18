import 'package:get_it/get_it.dart';
import 'package:love_book/core/service/auth_service.dart';
import 'package:love_book/core/service/user_service.dart';
import 'package:love_book/core/viewmodels/auth_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => AuthModel());
  locator.registerLazySingleton(() => UserService());
}
