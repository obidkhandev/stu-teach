import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stu_teach/features/auth/data/models/login/request/auth_request_model.dart';
import 'package:stu_teach/features/auth/data/models/login/response/auth_response_model.dart';



abstract class AuthDatasource {
  Future<Either<Failure, AuthResponseModel>> login(AuthRequestModel loginRequestModel);
  Future<Either<Failure, AuthResponseModel>> register(AuthRequestModel loginRequestModel);
}


class AuthDatasourceImpl extends AuthDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either<Failure, AuthResponseModel>> login(AuthRequestModel loginRequestModel) async {
    try {
      // Attempt to sign in the user with email and password
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: loginRequestModel.email,
        password: loginRequestModel.password,
      );

      // Create and return the LoginResponseModel based on the userCredential
      AuthResponseModel responseModel = AuthResponseModel(
        userId: userCredential.user!.uid,
        message: 'Login successful',
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

  @override
  Future<Either<Failure, AuthResponseModel>> register(AuthRequestModel loginRequestModel) async {
    try {
      // Attempt to register the user with email and password
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: loginRequestModel.email,
        password: loginRequestModel.password,
      );

      // Create and return the LoginResponseModel based on the userCredential
      AuthResponseModel responseModel = AuthResponseModel(
        userId: userCredential.user!.uid,
        message: 'Registration successful',
      );

      return Right(responseModel);
    } on FirebaseAuthException catch (e) {

      // Handle different types of FirebaseAuthException errors
      if (e.code == 'email-already-in-use') {
        return const Left(EmailPasswordWrongFailure());
      } else if (e.code == 'invalid-email') {
        return const Left(EmailPasswordWrongFailure());
      } else if (e.code == 'weak-password') {
        return const Left(EmailPasswordWrongFailure());
      } else {
        return const Left(ConnectionFailure());
      }
    } catch (e) {
      // Handle any other exceptions
      return const Left(UnknownFailure());
    }
  }
}
