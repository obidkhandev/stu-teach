import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/core/extension/widget_extantion.dart';
import 'package:stu_teach/core/routes/app_routes.dart';
import 'package:stu_teach/core/utils/helper_widget.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:stu_teach/features/common/widget/custom_app_bar.dart';
import 'package:stu_teach/features/common/widget/custom_button.dart';
import 'package:stu_teach/features/common/widget/custom_empty_widget.dart';
import 'package:stu_teach/features/common/widget/loading_widget.dart';
import 'package:stu_teach/features/main/presentation/cubit/task/task_cubit.dart';
import 'package:stu_teach/features/main/presentation/pages/widget/teacher_task_item.dart';
import 'package:stu_teach/features/student_tab/pages/tasks/presentation/part/complete_task_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Tasks",
        action: [
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (n) => false,
              );
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          final bloc = context.read<TaskCubit>();
          if (state is TaskLoaded) {
            return state.tasks.isEmpty
                ? const CustomEmptyWidget(
                    title: "Empty  Task",
                    subTitle: "You're tasks is empty",
                  )
                : Column(
                    children: [
                      ListView.separated(
                        itemCount: state.tasks.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return TaskItem(
                            model: state.tasks[index],
                            onDelete: () async {},
                            onUploadFile: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return CompleteTaskDialog(
                                      model: state.tasks[index],
                                    );
                                  });
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
                                  state.tasks[index].fileUrl,
                                ),
                              );
                              if (canLaunch) {
                                launchUrl(
                                    Uri.parse(state.tasks[index].fileUrl));
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
                  await bloc.fetchAllTasks();
                });
          } else {
            return const SizedBox.shrink();
          }
        },
      ).paddingSymmetric(horizontal: wi(16), vertical: he(20)),
    );
  }
}
