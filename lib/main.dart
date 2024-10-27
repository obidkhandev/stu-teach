import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/core/routes/app_pages.dart';
import 'package:stu_teach/core/routes/app_routes.dart';
import 'package:stu_teach/core/services/app_version/app_update_service.dart';
import 'package:stu_teach/core/services/check_connection/check_connection_service.dart';
import 'package:stu_teach/core/utils/helper_widget.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_theme.dart';
import 'package:stu_teach/di.dart';
import 'package:stu_teach/features/common/cubit/maintab/main_tab_cubit.dart';

import 'features/common/cubit/auth/auth_cubit.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CheckConnection.scheduleRequest();
  await AppUpdateService.getCloudVersion();
  // Initialize dependencies
  await initDi();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => inject<MainTabCubit>()),


        BlocProvider(
            create: (context) => inject<AuthCubit>()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TMA mobile',
        theme: appTheme,

        onGenerateRoute: RouteGenerate().generate,
        navigatorKey: navigatorKey,
        builder: (context, child) {
          return ScrollConfiguration(behavior: MyBehavior(), child: child!);
        },
        initialRoute: AppRoutes.splashScreen,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}
