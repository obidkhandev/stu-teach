import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/features/auth/presentation/cubit/student/student_cubit.dart';
import 'package:stu_teach/features/auth/presentation/cubit/student/student_state.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          if (state is StudentSuccess) {
            return Center(child: Text(state.student.name));
          }
          return Center(child: Text("Student Tab Screen ${state}"));
        },
      ),
    );
  }
}
