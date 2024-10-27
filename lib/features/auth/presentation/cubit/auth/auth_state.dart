import 'package:equatable/equatable.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/features/auth/data/models/login/response/login_response_model.dart';

// Base AuthState class
abstract class AuthState extends Equatable {
  final String message;
  final bool isLoading;
  final Failure failure;

  const AuthState({
    this.message = "",
    this.isLoading = false,
    this.failure = const UnknownFailure(),
  });

  @override
  List<Object?> get props => [message, isLoading, failure];
}

// Initial State
class AuthInitialState extends AuthState {
  const AuthInitialState() : super();
}

// Loading State
class AuthLoadingState extends AuthState {
  const AuthLoadingState() : super(isLoading: true);
}

// Authenticated State
class AuthenticatedState extends AuthState {
  final LoginResponseModel response;

  const AuthenticatedState({
    required this.response,
    super.message = 'User authenticated successfully',
  });
}

// Unauthenticated State
class UnAuthenticatedState extends AuthState {
  const UnAuthenticatedState({
    super.message = 'User not authenticated',
    super.failure,
  });
}

// Error State
class AuthErrorState extends AuthState {
  const AuthErrorState({
    required String message,
    required Failure failure,
  }) : super(message: message, failure: failure);
}
