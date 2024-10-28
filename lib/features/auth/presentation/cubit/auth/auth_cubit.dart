import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/core/usecase/usecase.dart';
import 'package:stu_teach/features/auth/data/models/login/request/auth_request_model.dart';
import 'package:stu_teach/features/auth/domain/uscase/auth/check_user_auth.dart';
import 'package:stu_teach/features/auth/domain/uscase/auth/login_user_usecase.dart';
import 'package:stu_teach/features/auth/domain/uscase/auth/logout.dart';
import 'package:stu_teach/features/auth/domain/uscase/auth/register_user_usecase.dart';
import 'package:stu_teach/features/auth/presentation/cubit/auth/auth_state.dart';



class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._checkUserToAuthUseCase, this._logoutUseCase, this._login, this._registerUserUsecase)
      : super(const AuthInitialState());

  final CheckUserToAuthUseCase _checkUserToAuthUseCase;
  final LogoutUseCase _logoutUseCase;
  final LoginUserUsecase _login;
  final RegisterUserUsecase _registerUserUsecase;



  Future<void> loginUser(String email, String password) async {
    emit(const AuthLoadingState()); // Set loading state
    var result = await _login.call(LoginParams(request: AuthRequestModel(email: email, password: password)));
    result.fold(
          (failure) => emit(AuthErrorState(message: 'Login error', failure: failure)),
          (response) => emit(AuthenticatedState(response: response)), // Include successful login
    );
  }

  Future<void> registerUser(String email, String password) async {
    emit(const AuthLoadingState()); // Set loading state
    var result = await _registerUserUsecase.call(RegisterParams(request: AuthRequestModel(email: email, password: password)));
    result.fold(
          (failure) => emit(AuthErrorState(message: 'Register error', failure: failure)),
          (response) => emit(AuthenticatedState(response: response)), // Include successful login
    );
  }


  Future<void> logout() async {
    emit(const AuthLoadingState()); // Set loading state
    await _logoutUseCase.call(NoParams());
    emit(const UnAuthenticatedState(message: 'Logged out successfully')); // Notify logout success
  }
}

