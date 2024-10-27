import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stu_teach/core/api/dio_client.dart';
import 'package:stu_teach/core/utils/pref_manager.dart';
import 'package:stu_teach/features/auth/data/datasourse/login_datasourse.dart';
import 'package:stu_teach/features/auth/data/repository/auth.dart';
import 'package:stu_teach/features/auth/domain/repository/auth.dart';
import 'package:stu_teach/features/auth/domain/uscase/auth/check_user_auth.dart';
import 'package:stu_teach/features/auth/domain/uscase/auth/login_user_usecase.dart';
import 'package:stu_teach/features/auth/domain/uscase/auth/logout.dart';
import 'package:stu_teach/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:stu_teach/features/auth/presentation/cubit/maintab/main_tab_cubit.dart';
import 'package:stu_teach/features/main/data/datasources/upload_file_datasourse.dart';
import 'package:stu_teach/features/main/data/repositories/teacher_tasks_repositories_impl.dart';
import 'package:stu_teach/features/main/domain/repositories/teacher_task_repositories.dart';
import 'package:stu_teach/features/main/domain/usecases/upload_file/upload_file_usecase.dart';
import 'package:stu_teach/features/main/presentation/cubit/upload_file/upload_file_cubit.dart';


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

  // Auth
  inject.registerLazySingleton<IAuthRepository>(() => AuthRepository(inject(), inject()));

  // Upload File
  inject.registerLazySingleton<TeacherTaskRepositories>(() => TeacherTasksRepositoriesImpl(inject()));


}

void _dataSources() {
  inject.registerLazySingleton<LoginDatasource>(
        () => LoginDatasourceImpl(),
  );

  inject.registerLazySingleton<UploadFileDatasource>(
        () => UploadFileDatasourceImpl(FirebaseStorage.instance),
  );


}

void _useCase() {
  // AUTH
  inject.registerLazySingleton(() => LogoutUseCase(inject()));
  inject.registerLazySingleton(() => CheckUserToAuthUseCase(inject()));
  inject.registerLazySingleton(() => LoginUserUsecase(inject()));

  // File Upload
  inject.registerLazySingleton(() => UploadFileUseCase(inject()));







}

void _cubit() {
  // AUTH
  inject.registerFactory(() => MainTabCubit());

  // Main
  inject.registerFactory(() => AuthCubit(inject(), inject(),inject()));

 // Upload file
  inject.registerFactory(() => UploadFileCubit(inject()));

}
