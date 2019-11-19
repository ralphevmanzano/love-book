import 'package:love_book/ui/views/login_view.dart';
import 'package:love_book/ui/views/signup_view.dart';
import 'package:sailor/sailor.dart';

class Routes {
  static const LOGIN_VIEW = '/login';
  static const SIGNUP_VIEW = '/signup';

  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoutes([
      SailorRoute(
        name: LOGIN_VIEW,
        builder: (context, args, params) {
          return LoginView();
        },
      ),
      SailorRoute(
        name: SIGNUP_VIEW,
//        defaultTransitions: [SailorTransition.slide_from_right],
//        defaultTransitionDuration: Duration(milliseconds: 200),
        builder: (context, args, params) {
          return SignupView();
        },
      ),
    ]);
  }
}
