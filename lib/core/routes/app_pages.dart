import 'package:flutter/cupertino.dart';
import 'package:stu_teach/core/routes/app_routes.dart';
import 'package:stu_teach/features/auth/presentation/pages/login/login_screen.dart';
import 'package:stu_teach/features/no_internet/no_inernet_screen.dart';
import 'package:stu_teach/features/onboarding/onboarding/pages/on_boarding_screen.dart';
import 'package:stu_teach/features/onboarding/splash/splash_screen.dart';


class RouteGenerate {
  Route? generate(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      /// PROJECT ///

      case AppRoutes.splashScreen:
        return simpleRoute(const SplashScreen());
      case AppRoutes.onBoarding:
        return simpleRoute(const OnBoardingScreen());
      case AppRoutes.noInternet:
        return simpleRoute(const NoInternetScreen());
      case AppRoutes.login:
        return simpleRoute(const LoginScreen());

    }
    return null;
  }

  simpleRoute(Widget route) => CupertinoPageRoute(builder: (context) => route);
}
