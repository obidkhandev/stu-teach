import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/features/common/widget/custom_button.dart';
import 'package:stu_teach/features/main/presentation/cubit/upload_file/upload_file_cubit.dart';

class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: BlocConsumer<UploadFileCubit, UploadFileState>(
        listener: (context, fileState) {
          if (fileState is UploadFileSuccess) {
            debugPrint('File uploaded successfully: ${fileState.url}');
          } else if (fileState is UploadFileFailure) {
            debugPrint('Upload failed: ${fileState.failure}');
          }
        },
        builder: (context, fileState) {
          final fileBloc = context.read<UploadFileCubit>();
          // final fileState =
          return DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text(
                  "Add Task",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: fileState is UploadFileSuccess? "File Uploaded" : "Upload file",
                  isLoading: fileState is UploadFileLoading,
                  onTap: () async {
                    fileBloc.selectAndUploadFile();
                  },
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
