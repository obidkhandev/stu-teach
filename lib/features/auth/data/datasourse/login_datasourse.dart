import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stu_teach/features/auth/data/models/login/request/login_request_model.dart';
import 'package:stu_teach/features/auth/data/models/login/response/login_response_model.dart';


abstract class LoginDatasource {
  Future<Either<Failure, LoginResponseModel>> loginUser(LoginRequestModel loginRequestModel);
}

class LoginDatasourceImpl extends LoginDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either<Failure, LoginResponseModel>> loginUser(LoginRequestModel loginRequestModel) async {
    try {
      // Attempt to sign in the user with email and password
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: loginRequestModel.email,
        password: loginRequestModel.password,
      );

      // Create and return the LoginResponseModel based on the userCredential
      LoginResponseModel responseModel = LoginResponseModel(
        userId: userCredential.user!.uid,
        // email: userCredential.user?.email,
        message: '',
        // Add any other fields you need
      );

      return Right(responseModel);
    } on FirebaseAuthException catch (e) {
      // Handle different types of FirebaseAuthException errors
      if (e.code == 'user-not-found') {
        return const Left(UserNotFound());
      } else if (e.code == 'wrong-password') {
        return const Left(WrongCodeFailure());
      } else {
        return const Left(ConnectionFailure());
      }
    } catch (e) {
      // Handle any other exceptions
      return const Left(UnknownFailure());
    }
  }
}