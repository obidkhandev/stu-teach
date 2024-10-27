import 'package:firebase_core/firebase_core.dart';
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
import 'package:stu_teach/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:stu_teach/features/auth/presentation/cubit/maintab/main_tab_cubit.dart';
import 'package:stu_teach/core/services/firebase/firebase_options.dart';
import 'package:stu_teach/features/main/presentation/cubit/task/task_cubit.dart';
import 'package:stu_teach/features/main/presentation/cubit/upload_file/upload_file_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        BlocProvider(create: (context) => inject<AuthCubit>()),
        BlocProvider(
          create: (context) => inject<TeacherTaskCubit>()..fetchAllTasks(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stu Teach',
        theme: appTheme,
        onGenerateRoute: RouteGenerate().generate,
        navigatorKey: navigatorKey,
        builder: (context, child) {
          return ScrollConfiguration(behavior: MyBehavior(), child: child!);
        },
        initialRoute: AppRoutes.mainScreen,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}
