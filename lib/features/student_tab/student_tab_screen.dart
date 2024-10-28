import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  void initState() {
    BlocProvider.of<StudentCubit>(context).getStudent();
    super.initState();
  }

  int currentIndex = 0;

  List<Widget> _screen = [
    TasksScreen(),
    CompletedTasksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[currentIndex],
      bottomNavigationBar: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index){
              setState(() {
                currentIndex = index;
              });
            },
            items: [
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
