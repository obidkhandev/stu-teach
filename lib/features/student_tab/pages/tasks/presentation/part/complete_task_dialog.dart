import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/features/auth/presentation/cubit/student/student_cubit.dart';
import 'package:stu_teach/features/auth/presentation/cubit/student/student_state.dart';
import 'package:stu_teach/features/common/widget/custom_button.dart';
import 'package:stu_teach/features/common/widget/custom_toast.dart';
import 'package:stu_teach/features/main/data/model/add_task/request/add_task_request_model.dart';
import 'package:stu_teach/features/main/data/model/get_teacher_tasks/response/get_all_tasks_response.dart';
import 'package:stu_teach/features/main/presentation/cubit/task/task_cubit.dart';
import 'package:stu_teach/features/main/presentation/cubit/upload_file/upload_file_cubit.dart';

class CompleteTaskDialog extends StatefulWidget {
  final TaskResponse model;

  const CompleteTaskDialog({super.key, required this.model});

  @override
  State<CompleteTaskDialog> createState() => _CompleteTaskDialogState();
}

class _CompleteTaskDialogState extends State<CompleteTaskDialog> {
  String fileUrl = "";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<StudentCubit>(context).getStudent();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: BlocConsumer<UploadFileCubit, UploadFileState>(
        listener: (context, fileState) {
          if (fileState is UploadFileSuccess) {
            fileUrl = fileState.url;
            debugPrint('File uploaded successfully: ${fileState.url}');
          } else if (fileState is UploadFileFailure) {
            debugPrint('Upload failed: ${fileState.failure}');
            // Show toast for upload failure if needed
          }
        },
        builder: (context, fileState) {
          final fileBloc = context.read<UploadFileCubit>();
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20).copyWith(
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              ),
              child: Column(
                children: [
                  CustomButton(
                    isLoading: fileState is UploadFileLoading,
                    text: "Upload file",
                    onTap: () async {
                      await fileBloc.selectAndUploadFile();
                    },
                  ),
                  SizedBox(height: he(10)),
                  BlocBuilder<StudentCubit, StudentState>(
                    builder: (context, state) {
                      final studentCubit = context.read<StudentCubit>();
                      return CustomButton(
                        text: "Complete Task",
                        bgColor: fileState is UploadFileSuccess
                            ? AppColors.primaryColor
                            : AppColors.grey2,

                        onTap: () async {
                          // Check if the file URL is empty
                          if (fileUrl.isEmpty) {
                            customToast(
                              message: "Please upload file",
                              bgColor: Colors.red,
                            );
                            // Pop the dialog if fileUrl is empty
                            Navigator.pop(context);
                            return; // Exit early if no file URL
                          }

                          final taskCubit = BlocProvider.of<TaskCubit>(context);
                          TaskResponse taskModel = widget.model; // Original task model

                          if (state is StudentSuccess) {
                            print("Success----");
                            print("${state.student.id}");

                            final studentModel =
                                state.student; // Get the student model



                            // Update the task model
                            final updatedTaskModel = taskModel.copyWith(
                              finishedCount: taskModel.finishedCount + 1,
                              userIds: [...taskModel.userIds, studentModel.id],
                              receivedUrl: [...taskModel.receivedUrl, fileUrl],
                            );

                            final updatedStudentModel = studentModel.copyWith(
                              completedTasksIds: [
                                ...studentModel.completedTasksIds,
                                taskModel
                              ],
                            );



                            await taskCubit.editTask(
                              updatedTaskModel.id,
                              AddTaskRequestModel(
                                id: updatedTaskModel.id,
                                title: updatedTaskModel.title,
                                date: updatedTaskModel.date,
                                fileUrl: fileUrl,
                                finishedCount: updatedTaskModel.finishedCount,
                                tarif: updatedTaskModel.tarif,
                                userIds: updatedTaskModel.userIds,
                                fileType: updatedTaskModel.urlType,
                                receivedUrl: updatedTaskModel.receivedUrl,
                              ),
                            );

                            await studentCubit.updateStudent(updatedStudentModel);

                            // Fetch all tasks after editing
                            await taskCubit.fetchAllTasks();
                          }

                          // Pop the dialog after processing
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
