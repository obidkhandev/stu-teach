import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stu_teach/core/api/list_api.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/features/auth/data/models/student/stundent_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:stu_teach/features/auth/data/models/student/student_model.dart';


abstract class StudentDatasource {

  Future<Either<Failure, bool>> addStudent(StudentModel request);

  Future<Either<Failure, StudentModel>> getStudent();
}


class StudentDatasourceImpl implements StudentDatasource {
  final SharedPreferences pref;
  final FirebaseFirestore _firestore;

  StudentDatasourceImpl(this.pref, this._firestore);

  @override
  Future<Either<Failure, bool>> addStudent(StudentModel request) async {
    SharedPreferences  preferences = await SharedPreferences.getInstance();

    try {
      // Use the student's ID as the document ID in the students collection
      final docRef = await _firestore.collection('students').add(request.toJson());

      final updatedRequest = request.copyWith(id: docRef.id);
      await _firestore.collection('students').doc(docRef.id).update(updatedRequest.toJson());


      print("ID: ${updatedRequest.id}---\n");
      final bool result = await preferences.setString(ListAPI.userID,updatedRequest.id);
      print("ID: ${updatedRequest.id}---22------\n\n\n $result \n\n\n");


      return const Right(true);
    } catch (e) {
      // Catch and handle any Firestore exceptions
      return const Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, StudentModel>> getStudent() async {

    SharedPreferences  preferences = await SharedPreferences.getInstance();

    try {

      String? id =  preferences.getString(ListAPI.userID);

      print("\n------ID: $id---\n\n\n");

      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
      await _firestore.collection('students').doc(id).get();

      if (docSnapshot.exists) {
        // Convert the document data to a StudentModel
        StudentModel student = StudentModel.fromJson(docSnapshot.data()!);
        return Right(student);
      } else {
        // Return an error if student data is not found
        return const Left(UnknownFailure());
      }
    } catch (e) {
      // Handle other potential exceptions
      return const Left(ConnectionFailure());
    }
  }
}
