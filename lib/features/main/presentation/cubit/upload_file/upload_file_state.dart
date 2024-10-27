part of 'upload_file_cubit.dart';

abstract class UploadFileState extends Equatable {}

class UploadFileInitial extends UploadFileState {
  @override
  List<Object> get props => [];
}

class UploadFileLoading extends UploadFileState {
  @override
  List<Object> get props => [];
}

class UploadFileSuccess extends UploadFileState {
  final String url;

  UploadFileSuccess(this.url);

  @override
  List<Object> get props => [url];
}

class UploadFileFailure extends UploadFileState {
  final Failure failure;

  UploadFileFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

