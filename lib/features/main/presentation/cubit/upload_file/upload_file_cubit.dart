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
        print( "\n\n\n\n\n ---: ${file.path} :File path selected---\n\n\n\n\n");
        String urlType =  openUrl(file.path);
        emit(UploadFileLoading());


        final Either<Failure, String> uploadResult =
            await uploadFileUseCase(UploadFileParams(file));


        uploadResult.fold(
          (failure) => emit(UploadFileFailure(failure)),
          (url) => emit(UploadFileSuccess(url,urlType)),
        );
      } else {
        // User canceled the picker or an error occurred
        emit(UploadFileFailure(const ServerFailure(500)));
      }
    } else if (status.isDenied) {
      emit(UploadFileFailure(const ServerFailure(500)));
    } else if (status.isPermanentlyDenied) {
      emit(UploadFileFailure(const ServerFailure(500)));
    }
  }


  String openUrl(String url) {
    final extension = url.split('.').last.toLowerCase();

    if (extension == 'pdf') {
      return 'pdf';
    } else if (extension == 'doc' || extension == 'docx') {
      return 'doc';
    } else if (extension == 'mp4' || extension == 'mov') {
      return 'mp4';
    } else if (extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
      return 'png';
    } else if (extension == 'mp3' || extension == 'wav') {
      return 'mp3';
    } else {
      return "Unknown";
    }
  }

  void setUrl(String url,String type) {
    emit(UploadFileSuccess(url,type));
  }

  void reset(){
    emit(UploadFileInitial());
  }
}
