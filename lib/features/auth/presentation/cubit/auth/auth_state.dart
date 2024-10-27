part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends AuthState {}

class AuthenticatedState extends AuthState {}

class UnAuthenticatedState extends AuthState {}
