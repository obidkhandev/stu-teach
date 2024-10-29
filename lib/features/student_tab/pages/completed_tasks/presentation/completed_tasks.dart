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
import 'package:stu_teach/features/common/widget/custom_empty_widget.dart';
import 'package:stu_teach/features/common/widget/loading_widget.dart';
import 'package:stu_teach/features/main/presentation/pages/widget/teacher_task_item.dart';
import 'package:url_launcher/url_launcher.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => inject<StudentCubit>()..getStudent(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Completed Tasks",
        ),
        body: BlocBuilder<StudentCubit, StudentState>(
          builder: (context, state) {
            final bloc = context.read<StudentCubit>();
            if (state is StudentSuccess) {
              print(state.student.completedTasksIds.length);
              return state.student.completedTasksIds.isEmpty
                  ? const CustomEmptyWidget(
                      title: "Empty Completed Task",
                      subTitle: "You're not completed task yet",
                    )
                  : Column(
                      children: [
                        ListView.separated(
                          itemCount: state.student.completedTasksIds.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var model = state.student.completedTasksIds[index];
                            return TaskItem(
                              model: model.task,
                              onDelete: () async {
                                // Add delete logic here
                              },
                              onUploadFile: () {
                                // Add file upload logic here
                              },
                              onEdit: () async {},
                              onSee: () async {
                                if (model.fileUrl.isNotEmpty) {
                                  final uri = Uri.parse(model.fileUrl);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Could not open the file URL.")),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "No file URL available for this task.")),
                                  );
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
            } else if (state is StudentLoading) {
              return const LoadingWidget();
            } else if (state is StudentFailure) {
              return CustomButton(
                text: "Try again",
                onTap: () async {
                  await bloc.getStudent();
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ).paddingSymmetric(horizontal: wi(16), vertical: he(20)),
      ),
    );
  }
}
