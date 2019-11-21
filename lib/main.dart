import 'package:flutter/material.dart';
import 'package:love_book/locator.dart';
import 'package:love_book/ui/routes/routes.dart';
import 'package:love_book/ui/views/login_view.dart';
import 'package:love_book/ui/views/splash_view.dart';
import 'package:love_book/utils/color.dart' as c;
import 'package:provider/provider.dart';

import 'core/viewmodels/auth_model.dart';
import 'ui/views/home_view.dart';

void main() {
  setupLocator();
  Routes.createRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: locator<AuthModel>(),
        ),
      ],
      child: MaterialApp(
        title: 'Lovebook',
        theme: ThemeData(
          primaryColor: c.Colors.primaryColor,
          textTheme: TextTheme(
            subtitle: TextStyle(fontFamily: 'Ubuntu'),
            button: TextStyle(color: Colors.white, fontFamily: 'Ubuntu'),
            title: TextStyle(fontSize: 28, fontFamily: 'Ubuntu'),
          ),
          /*buttonTheme: ButtonThemeData(
            buttonColor: theme.primaryColor,
            textTheme: ButtonTextTheme.primary,
          ),*/
        ),
        onGenerateRoute: Routes.sailor.generator(),
        navigatorKey: Routes.sailor.navigatorKey,
        home: Consumer<AuthModel>(
          builder: (ctx, model, child) {
            print('REBUILD------${model.authState}');
            switch (model.authState) {
              case AuthState.Loading:
                return SplashView();
              case AuthState.Unauthenticated:
                return LoginView();
              case AuthState.Authenticated:
                return HomeView();
              default:
                return LoginView();
            }
          },
        ),
      ),
    );
  }
}

