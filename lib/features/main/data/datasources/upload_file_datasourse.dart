import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:firebase_storage/firebase_storage.dart';


abstract class UploadFileDatasource {
  Future<Either<Failure, String>> uploadFile(File filePath);
}

class UploadFileDatasourceImpl implements UploadFileDatasource {
  final FirebaseStorage firebaseStorage;

  UploadFileDatasourceImpl(this.firebaseStorage);

  @override
  Future<Either<Failure, String>> uploadFile(File filePath) async {
    try {
      // Generate a unique file name
      final String fileName = "${DateTime.now().millisecondsSinceEpoch}_${filePath.uri.pathSegments.last}";

      // Reference to Firebase Storage location
      final Reference storageReference = firebaseStorage.ref().child('uploads/$fileName');

      // Upload the file
      UploadTask uploadTask = storageReference.putFile(filePath);

      // Wait until the upload completes
      final TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return Right(downloadUrl);
    } catch (e) {
      return const Left(ServerFailure(500));
    }
  }
}
