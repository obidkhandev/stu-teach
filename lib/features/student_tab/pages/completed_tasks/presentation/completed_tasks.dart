import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/core/extension/widget_extantion.dart';
import 'package:stu_teach/core/utils/helper_widget.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/di.dart';
import 'package:stu_teach/features/auth/presentation/cubit/student/student_cubit.dart';
import 'package:stu_teach/features/auth/presentation/cubit/student/student_state.dart';
import 'package:stu_teach/features/common/widget/custom_app_bar.dart';
import 'package:stu_teach/features/common/widget/custom_button.dart';
import 'package:stu_teach/features/common/widget/loading_widget.dart';
import 'package:stu_teach/features/main/presentation/cubit/task/task_cubit.dart';
import 'package:stu_teach/features/main/presentation/pages/widget/teacher_task_item.dart';
import 'package:url_launcher/url_launcher.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Completed Tasks",
      ),
      body: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          final bloc = context.read<StudentCubit>();
          if (state is StudentSuccess) {
            return Column(
              children: [
                ListView.separated(
                  itemCount: state.student.completedTasksIds.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var model = state.student.completedTasksIds[index];
                    // var completedModel = state.student.
                    return TaskItem(
                      model: model.task,
                      onDelete: () async {},
                      onUploadFile: () {

                      },
                      onEdit: () async {
                        // context.read<UploadFileCubit>().setUrl(
                        //       state.tasks[index].fileUrl,
                        //       state.tasks[index].urlType,
                        //     );
                        // showModalBottomSheet(
                        //     context: context,
                        //     builder: (context) {
                        //       return EditTaskDialog(model: state.tasks[index]);
                        //     });
                      },
                      onSee: () async {
                        final canLaunch = await canLaunchUrl(
                          Uri.parse(
                            model.fileUrl,
                          ),
                        );
                        if (canLaunch) {
                          launchUrl(Uri.parse(model.fileUrl));
                        }
                      },
                      isStudent: true,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return customDivider;
                  },
                ),
              ],
            );
          } else if (state is TaskLoading) {
            return const LoadingWidget();
          } else if (state is TaskError) {
            return CustomButton(
                text: "Try again",
                onTap: () async {
                  await bloc.getStudent();
                });
          } else {
            return const SizedBox.shrink();
          }
        },
      ).paddingSymmetric(horizontal: wi(16), vertical: he(20)),
    );
  }
}
