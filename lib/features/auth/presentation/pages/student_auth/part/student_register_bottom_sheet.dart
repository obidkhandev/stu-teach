import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/core/routes/app_routes.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_assets.dart';
import 'package:stu_teach/features/auth/data/models/student/stundent_model.dart';
import 'package:stu_teach/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:stu_teach/features/auth/presentation/cubit/auth/auth_state.dart';
import 'package:stu_teach/features/auth/presentation/cubit/student/student_cubit.dart';
import 'package:stu_teach/features/auth/presentation/pages/login/part/custom_dialog.dart';
import 'package:stu_teach/features/common/widget/custom_button.dart';
import 'package:stu_teach/features/common/widget/text_field_widget.dart';

studentRegisterBottomSheet({required BuildContext context}) {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            final student = StudentModel(
                id: '',
                name: nameController.text,
                email: emailController.text,
                password: passwordController.text);
            context.read<StudentCubit>().addStudent(student);
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.studentMainScreen, (route) => false);
          }
          if (state is AuthErrorState) {
            customDialog(context, 'Try again or check Internet', state.message,
                AppIcons.icError);
          }
        },
        builder: (context, state) {
          final bloc = context.read<AuthCubit>();
          return FadeInUp(
            child: Form(
              key: _formKey, // Attach form key
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30)
                    .copyWith(bottom: MediaQuery.of(context).padding.bottom),
                child: Column(
                  children: [
                    Text(
                      "Student register",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: he(10)),
                    CustomTextField(
                      hintText: "",
                      textEditingController: nameController,
                      textInputType: TextInputType.text,
                      label: "Enter name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                          return 'Name should contain only letters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: he(10)),
                    CustomTextField(
                      hintText: "",
                      textEditingController: surnameController,
                      textInputType: TextInputType.text,
                      label: "Enter surname",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a surname';
                        }
                        if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                          return 'Surname should contain only letters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: he(10)),
                    CustomTextField(
                      hintText: "",
                      textEditingController: emailController,
                      textInputType: TextInputType.emailAddress,
                      label: "Enter email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: he(10)),
                    CustomTextField(
                      hintText: "",
                      textEditingController: passwordController,
                      textInputType: TextInputType.text,
                      label: "Enter password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: he(10)),
                    CustomButton(
                      text: "Register",
                      isLoading: state is AuthLoadingState,
                      onTap: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await bloc.registerUser(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                    ),
                    SizedBox(height: he(30)),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
