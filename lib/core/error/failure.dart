import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LocalizedMessage {
  String getLocalizedMessage(BuildContext context);
}

abstract class Failure extends Equatable implements LocalizedMessage {
  const Failure();

  @override
  List<Object> get props => [];
}

class EmptyFailure extends Failure {
  const EmptyFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) => '';
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(this.statusCode) : super();

  @override
  List<Object> get props => [statusCode ?? 0];

  @override
  String getLocalizedMessage(BuildContext context) =>
      'Server Error $statusCode';
}

class ConnectionFailure extends Failure {
  const ConnectionFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) =>
      "Check internet connection";
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) => "Unknown Failure";
}

class GeneralFailure extends Failure {
  const GeneralFailure(this.error) : super();
  final String error;

  @override
  String getLocalizedMessage(BuildContext context) => error;
}

class UnAuthorizationFailure extends Failure {
  const UnAuthorizationFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) =>
      "Un Authorization Failure";
}


class CacheFailure extends Failure {
  const CacheFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) => 'Cache failure';
}

class EmailPasswordWrongFailure extends Failure {
  const EmailPasswordWrongFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) => "Email or Password wrong";
}

class UserNotFound extends Failure {
  const UserNotFound() : super();

  @override
  String getLocalizedMessage(BuildContext context) => "strUserNotfound";
}

class WrongCodeFailure extends Failure {
  const WrongCodeFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) => "strWrongCode";
}

