import 'package:animate_do/animate_do.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stu_teach/core/api/api.dart';
import 'package:stu_teach/core/routes/app_routes.dart';
import 'package:stu_teach/core/services/app_version/app_update_service.dart';
import 'package:stu_teach/core/utils/helper_widget.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_assets.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/di.dart';
import 'package:stu_teach/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:stu_teach/features/auth/presentation/cubit/auth/auth_state.dart';
import 'package:stu_teach/features/common/widget/loading_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => inject<AuthCubit>()..checkUser(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          print(state);
          // TODO: implement initState
          Future.delayed(const Duration(seconds: 3), () async {
            var connectivity = Connectivity();
            final doubleCheck = await connectivity.checkConnectivity();
            if (mounted) {
              if (doubleCheck == ConnectivityResult.wifi ||
                  doubleCheck == ConnectivityResult.mobile ||
                  doubleCheck == ConnectivityResult.ethernet) {
                if (state is UnAuthenticatedState) {
                  return Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                } else {
                  SharedPreferences _pref =
                      await SharedPreferences.getInstance();
                  var result = _pref.getString(ListAPI.userID);
                  print("$result :Result id--");
                  if (result!.isNotEmpty && state is AuthenticatedState) {
                    return Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.studentMainScreen,
                      (route) => false,
                    );
                  } else {
                    return Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.mainScreen,
                      (route) => false,
                    );
                  }
                }
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.noInternet,
                  (route) => false,
                );
              }
            }
          });
        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: he(100)),
                Expanded(
                  child: Center(
                    child: ZoomIn(
                        duration: const Duration(milliseconds: 700),
                        child: Text(
                          "StuTeach",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.black),
                        )),
                  ),
                ),
                const LoadingWidget(color: AppColors.primaryColor),
                SizedBox(height: he(12)),
                Text(
                  textAlign: TextAlign.center,
                  "V.${AppUpdateService.appVersion}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: he(13),
                        color: AppColors.black,
                      ),
                ),
                SizedBox(height: customButtonPadding),
              ],
            ),
          );
        },
      ),
    );
  }
}
