import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stu_teach/core/api/dio_client.dart';
import 'package:stu_teach/core/utils/pref_manager.dart';
import 'package:stu_teach/features/common/cubit/maintab/main_tab_cubit.dart';
import 'package:stu_teach/features/common/data/repository/auth.dart';
import 'package:stu_teach/features/common/domain/repository/auth.dart';
import 'package:stu_teach/features/common/domain/uscase/auth/check_user_auth.dart';
import 'package:stu_teach/features/common/domain/uscase/auth/logout.dart';

import 'features/common/cubit/auth/auth_cubit.dart';

final inject = GetIt.instance;

Future<void> initDi() async {
  // Register SharedPreferences
  final SharedPreferences pref = await SharedPreferences.getInstance();
  inject.registerSingleton<SharedPreferences>(pref);

  // Register other dependencies
  inject.registerSingleton<DioClient>(DioClient(pref));
  initPrefManager(pref);
  _dataSources();
  _repositories();
  _useCase();
  _cubit();
}

// Register prefManager
void initPrefManager(SharedPreferences pref) {
  inject.registerLazySingleton<PrefManager>(() => PrefManager(pref));
}

void _repositories() {
  // AUTH
  inject.registerLazySingleton<IAuthRepository>(() => AuthRepository(inject()));


}

void _dataSources() {
  // Language



}

void _useCase() {
  // AUTH
  inject.registerLazySingleton(() => LogoutUseCase(inject()));
  inject.registerLazySingleton(() => CheckUserToAuthUseCase(inject()));





}

void _cubit() {
  // AUTH
  inject.registerFactory(() => MainTabCubit());

  // Main
  inject.registerFactory(() => AuthCubit(inject(), inject()));

}
