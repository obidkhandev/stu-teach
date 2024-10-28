import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/core/usecase/usecase.dart';
import 'package:stu_teach/features/auth/data/models/student/stundent_model.dart';
import 'package:stu_teach/features/auth/domain/uscase/student/add_student_usecase.dart';
import 'package:stu_teach/features/auth/domain/uscase/student/get_student_usecase.dart';
import 'package:stu_teach/features/auth/presentation/cubit/student/student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  final AddStudentUsecase addStudentUseCase;
  final GetStudentUsecase getStudentUseCase;

  StudentCubit({
    required this.addStudentUseCase,
    required this.getStudentUseCase,
  }) : super(StudentInitial());

  // Method to add a student
  Future<void> addStudent(StudentModel student) async {
    emit(StudentLoading());

    Either<Failure, bool> result = await addStudentUseCase.call(
      AddStudentParams(
        request: student,
      ),
    );

    result.fold(
      (failure) => emit(StudentFailure(failure)),
      (_) => emit(const StudentAddedSuccess()),
    );
  }

  // Method to get a student by ID
  Future<void> getStudent() async {
    emit(StudentLoading());

    Either<Failure, StudentModel> result = await getStudentUseCase.call(NoParams());

    result.fold(
      (failure) => emit(StudentFailure(failure)),
      (student) => emit(StudentSuccess(student)),
    );
  }
}
