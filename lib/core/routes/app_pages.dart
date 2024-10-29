import 'package:flutter/cupertino.dart';
import 'package:stu_teach/core/routes/app_routes.dart';
import 'package:stu_teach/features/auth/presentation/pages/login/teacher_auth_screen.dart';
import 'package:stu_teach/features/auth/presentation/pages/student_auth/student_auth_screen.dart';
import 'package:stu_teach/features/main/presentation/pages/main_screen.dart';
import 'package:stu_teach/features/no_internet/no_inernet_screen.dart';
// import 'package:stu_teach/features/onboarding/onboarding/pages/on_boarding_screen.dart';
import 'package:stu_teach/features/onboarding/splash/splash_screen.dart';
import 'package:stu_teach/features/student_tab/student_tab_screen.dart';

class RouteGenerate {
  Route? generate(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      /// PROJECT ///

      case AppRoutes.splashScreen:
        return simpleRoute(const SplashScreen());
      // case AppRoutes.onBoarding:
      //   return simpleRoute(const OnBoardingScreen());
      case AppRoutes.noInternet:
        return simpleRoute(const NoInternetScreen());
      case AppRoutes.login:
        return simpleRoute(const LoginScreen());
      case AppRoutes.mainScreen:
        return simpleRoute(const MainScreen());
      case AppRoutes.studentLogin:
        return simpleRoute(const StudentAuthScreen());
      case AppRoutes.studentMainScreen:
        return simpleRoute(const StudentTabScreen());
    }
    return null;
  }

  simpleRoute(Widget route) => CupertinoPageRoute(builder: (context) => route);
}
