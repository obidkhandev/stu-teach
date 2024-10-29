import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/core/extension/widget_extantion.dart';
import 'package:stu_teach/core/routes/app_routes.dart';
import 'package:stu_teach/core/utils/helper_widget.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:stu_teach/features/common/widget/custom_app_bar.dart';
import 'package:stu_teach/features/common/widget/custom_button.dart';
import 'package:stu_teach/features/common/widget/loading_widget.dart';
import 'package:stu_teach/features/main/presentation/cubit/task/task_cubit.dart';
import 'package:stu_teach/features/main/presentation/cubit/upload_file/upload_file_cubit.dart';
import 'package:stu_teach/features/main/presentation/pages/part/add_task_dialog.dart';
import 'package:stu_teach/features/main/presentation/pages/part/edit_tasks.dart';
import 'package:stu_teach/features/main/presentation/pages/part/show_completed_task.dart';
import 'package:stu_teach/features/main/presentation/pages/widget/teacher_task_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/widget/custom_empty_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddTaskDialog();
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: CustomAppBar(
        title: 'Teacher Main',
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
                    title: "Empty Task",
                    subTitle: "Tasks is empty",
                  )
                : Column(
                    children: [
                      ListView.separated(
                        itemCount: state.tasks.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return TaskItem(
                            model: state.tasks[index],
                            onSeeUsers: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return ShowCompletedUsers(
                                      taskModel: state.tasks[index],
                                    );
                                  });
                            },
                            onDelete: () async {
                              await bloc.deleteTask(state.tasks[index].id);
                              await bloc.fetchAllTasks();
                            },
                            onEdit: () async {
                              context.read<UploadFileCubit>().setUrl(
                                  state.tasks[index].fileUrl,
                                  state.tasks[index].urlType);

                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return EditTaskDialog(
                                        model: state.tasks[index]);
                                  });
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
                            isStudent: false,
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
