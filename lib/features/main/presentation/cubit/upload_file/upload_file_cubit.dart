import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/features/main/domain/usecases/upload_file/upload_file_usecase.dart';

part 'upload_file_state.dart';

class UploadFileCubit extends Cubit<UploadFileState> {
  final UploadFileUseCase uploadFileUseCase;

  UploadFileCubit(this.uploadFileUseCase) : super(UploadFileInitial());

  Future<void> selectAndUploadFile() async {
    // Check and request storage permission
    final status = await Permission.storage.request();

    if (status.isGranted || status.isLimited) {
      // Show file picker to select a file
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        // User selected a file, now proceed to upload
        File file = File(result.files.single.path!);
        emit(UploadFileLoading());

        final Either<Failure, String> uploadResult =
            await uploadFileUseCase(UploadFileParams(file));

        uploadResult.fold(
          (failure) => emit(UploadFileFailure(failure)),
          (url) => emit(UploadFileSuccess(url)),
        );
      } else {
        // User canceled the picker or an error occurred
        emit(UploadFileFailure(ServerFailure(500)));
      }
    } else if (status.isDenied) {
      emit(UploadFileFailure(ServerFailure(500)));
    } else if (status.isPermanentlyDenied) {
      emit(UploadFileFailure(ServerFailure(500)));
    }
  }
}
