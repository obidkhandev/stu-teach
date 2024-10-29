import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stu_teach/core/utils/pref_manager.dart';
import 'package:stu_teach/features/auth/data/datasourse/auth_datasourse.dart';
import 'package:stu_teach/features/auth/data/datasourse/student_datasources.dart';
import 'package:stu_teach/features/auth/data/repository/auth.dart';
import 'package:stu_teach/features/auth/data/repository/student.dart';
import 'package:stu_teach/features/auth/domain/repository/auth.dart';
import 'package:stu_teach/features/auth/domain/repository/student.dart';
import 'package:stu_teach/features/auth/domain/uscase/auth/check_user_auth.dart';
import 'package:stu_teach/features/auth/domain/uscase/auth/login_user_usecase.dart';
import 'package:stu_teach/features/auth/domain/uscase/auth/logout.dart';
import 'package:stu_teach/features/auth/domain/uscase/auth/register_user_usecase.dart';
import 'package:stu_teach/features/auth/domain/uscase/student/add_student_usecase.dart';
import 'package:stu_teach/features/auth/domain/uscase/student/get_student_usecase.dart';
import 'package:stu_teach/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:stu_teach/features/auth/presentation/cubit/student/student_cubit.dart';
import 'package:stu_teach/features/main/data/datasources/teacher_task_datasources.dart';
import 'package:stu_teach/features/main/data/datasources/upload_file_datasourse.dart';
import 'package:stu_teach/features/main/data/repositories/teacher_tasks_repositories_impl.dart';
import 'package:stu_teach/features/main/domain/repositories/teacher_task_repositories.dart';
import 'package:stu_teach/features/main/domain/usecases/tasks/add_task_usecaes.dart';
import 'package:stu_teach/features/main/domain/usecases/tasks/delete_task_usecase.dart';
import 'package:stu_teach/features/main/domain/usecases/tasks/edit_task_usecase.dart';
import 'package:stu_teach/features/main/domain/usecases/tasks/get_all_task_usecase.dart';
import 'package:stu_teach/features/main/domain/usecases/upload_file/upload_file_usecase.dart';
import 'package:stu_teach/features/main/presentation/cubit/task/task_cubit.dart';
import 'package:stu_teach/features/main/presentation/cubit/upload_file/upload_file_cubit.dart';

import 'features/student_tab/maintab/main_tab_cubit.dart';

final inject = GetIt.instance;

Future<void> initDi() async {
  // Register SharedPreferences
  final SharedPreferences pref = await SharedPreferences.getInstance();

  inject.registerSingleton<SharedPreferences>(pref);

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
  inject.registerLazySingleton<IAuthRepository>(
      () => AuthRepository(inject(), inject()));

  // Upload File And Task
  inject.registerLazySingleton<TaskRepositories>(
      () => TeacherTasksRepositoriesImpl(inject(), inject()));

  inject.registerLazySingleton<StudentRepository>(
      () => StudentRepositoryImpl(inject()));
}

void _dataSources() {
  inject.registerLazySingleton<AuthDatasource>(
    () => AuthDatasourceImpl(inject()),
  );

  inject.registerLazySingleton<UploadFileDatasource>(
    () => UploadFileDatasourceImpl(FirebaseStorage.instance),
  );

  inject.registerLazySingleton<TaskDatasource>(
    () => TaskDatasourceImpl(FirebaseFirestore.instance),
  );

  inject.registerLazySingleton<StudentDatasource>(
    () => StudentDatasourceImpl(
      inject(),
      FirebaseFirestore.instance,
    ),
  );
}

void _useCase() {
  // AUTH
  inject.registerLazySingleton(() => LogoutUseCase(inject()));
  inject.registerLazySingleton(() => CheckUserToAuthUseCase(inject()));
  inject.registerLazySingleton(() => LoginUserUsecase(inject()));
  inject.registerLazySingleton(() => RegisterUserUsecase(inject()));

  // File Upload
  inject.registerLazySingleton(() => UploadFileUseCase(inject()));

  // Teacher Task
  inject.registerLazySingleton(() => AddTaskUseCase(inject()));
  inject.registerLazySingleton(() => GetAllTasksUseCase(inject()));
  inject.registerLazySingleton(() => EditTaskUseCase(inject()));
  inject.registerLazySingleton(() => DeleteTaskUseCase(inject()));

  inject.registerLazySingleton(() => GetStudentUsecase(inject()));
  inject.registerLazySingleton(() => AddStudentUsecase(inject()));
}

void _cubit() {
  // AUTH
  inject.registerFactory(() => MainTabCubit());

  // Main
  inject.registerFactory(() => AuthCubit(
        inject(),
        inject(),
        inject(),
        inject(),
        inject(),
      ));

  // Upload file
  inject.registerFactory(() => UploadFileCubit(inject()));

  inject.registerFactory(() =>
      StudentCubit(addStudentUseCase: inject(), getStudentUseCase: inject()));

  // Upload file
  inject
      .registerFactory(() => TaskCubit(inject(), inject(), inject(), inject()));
}
