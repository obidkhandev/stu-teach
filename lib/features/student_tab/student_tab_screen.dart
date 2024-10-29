import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/features/auth/presentation/cubit/student/student_cubit.dart';
import 'package:stu_teach/features/auth/presentation/cubit/student/student_state.dart';
import 'package:stu_teach/features/student_tab/pages/completed_tasks/presentation/completed_tasks.dart';
import 'package:stu_teach/features/student_tab/pages/tasks/presentation/tasks_screen.dart';

class StudentTabScreen extends StatefulWidget {
  const StudentTabScreen({super.key});

  @override
  State<StudentTabScreen> createState() => _StudentTabScreenState();
}

class _StudentTabScreenState extends State<StudentTabScreen> {

  int currentIndex = 0;

  final List<Widget> _screen = [
    const TasksScreen(),
    const CompletedTasksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[currentIndex],
      bottomNavigationBar: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: currentIndex,
            selectedItemColor: AppColors.secondary,
            onTap: (index){
              setState(() {
                currentIndex = index;
              });
            },
            items: const [

              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Tasks",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.checklist_rtl_outlined),
                label: "Tasks",
              ),
            ],
          );
        },
      ),
    );
  }
}
