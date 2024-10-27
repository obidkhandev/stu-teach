import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';

abstract class TeacherTaskRepositories{
  Future<Either<Failure, String>> uploadFile(File file);

}