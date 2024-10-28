import 'package:equatable/equatable.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/features/auth/data/models/student/stundent_model.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object?> get props => [];
}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentSuccess extends StudentState {
  final StudentModel student;

  const StudentSuccess(this.student);

  @override
  List<Object?> get props => [student];
}

class StudentAddedSuccess extends StudentState {
  const StudentAddedSuccess();
}

class StudentFailure extends StudentState {
  final Failure failure;

  const StudentFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
