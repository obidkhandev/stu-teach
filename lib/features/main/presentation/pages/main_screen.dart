import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/core/extension/widget_extantion.dart';
import 'package:stu_teach/core/utils/helper_widget.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/features/common/widget/custom_app_bar.dart';
import 'package:stu_teach/features/common/widget/custom_button.dart';
import 'package:stu_teach/features/common/widget/loading_widget.dart';
import 'package:stu_teach/features/main/presentation/cubit/task/task_cubit.dart';
import 'package:stu_teach/features/main/presentation/pages/part/add_task_dialog.dart';
import 'package:stu_teach/features/main/presentation/pages/widget/teacher_task_item.dart';
import 'package:stu_teach/features/main/presentation/pages/widget/teacher_tasks_list.dart';

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
      appBar: const CustomAppBar(
        title: 'Main Screen',
      ),
      body: BlocBuilder<TeacherTaskCubit, TeacherTaskState>(
        builder: (context, state) {
          final bloc = context.read<TeacherTaskCubit>();
          if (state is TeacherTaskLoaded) {
            return ListView.separated(
              itemCount: state.tasks.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return TeacherTaskItem(
                  model: state.tasks[index],
                  onDelete: () async {
                    await bloc.deleteTask(state.tasks[index].id);
                    await bloc.fetchAllTasks();
                  },
                  onEdit: () async {
                    // await bloc.editTask(state.tasks[index].id, state.tasks[index]);
                    await bloc.fetchAllTasks();
                  },
                  onSee: () {},
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return customDivider;
              },
            );
          } else if (state is TeacherTaskLoading) {
            return const LoadingWidget();
          } else if (state is TeacherTaskError) {
            return CustomButton(text: "Try again", onTap: () {});
          } else {
            return const SizedBox.shrink();
          }
        },
      ).paddingSymmetric(horizontal: wi(16), vertical: he(20)),
    );
  }
}
