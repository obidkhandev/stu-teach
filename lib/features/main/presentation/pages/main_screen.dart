import 'package:flutter/material.dart';
import 'package:stu_teach/core/extension/widget_extantion.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/features/common/widget/custom_app_bar.dart';
import 'package:stu_teach/features/main/presentation/pages/part/add_task_dialog.dart';
import 'package:stu_teach/features/main/presentation/pages/widget/teacher_tasks_list.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          showModalBottomSheet(context: context, builder: (context){
            return AddTaskDialog();
          });
        },
        child: const Icon(Icons.add),
      ),
      appBar: const CustomAppBar(
        title: 'Main Screen',
      ),
      body: const TeacherTasksList()
          .paddingSymmetric(horizontal: wi(16), vertical: he(20)),
    );
  }
}
