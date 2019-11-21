import 'package:love_book/ui/views/auth/login_view.dart';
import 'package:love_book/ui/views/auth/signup_view.dart';
import 'package:love_book/ui/views/search_view.dart';
import 'package:sailor/sailor.dart';

class Routes {
  static const LOGIN_VIEW = '/login';
  static const SIGNUP_VIEW = '/signup';
  static const SEARCH_VIEW = '/search';

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
      SailorRoute(
        name: SEARCH_VIEW,
        builder: (context, args, params) {
          return SearchView();
        },
      ),
    ]);
  }
}
