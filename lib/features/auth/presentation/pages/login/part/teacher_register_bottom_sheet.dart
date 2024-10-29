import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/core/routes/app_routes.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_assets.dart';
import 'package:stu_teach/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:stu_teach/features/auth/presentation/cubit/auth/auth_state.dart';
import 'package:stu_teach/features/auth/presentation/pages/login/part/custom_dialog.dart';
import 'package:stu_teach/features/common/widget/custom_button.dart';
import 'package:stu_teach/features/common/widget/text_field_widget.dart';

teacherRegisterBottomSheet({required BuildContext context, required AuthCubit bloc}) {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          print(state);
          if (state is AuthenticatedState) {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainScreen, (route) => false);
          }
          if (state is AuthErrorState) {
            customDialog(context, 'User not found!!!', state.message, AppIcons.icError);
          }
        },
        builder: (context, state) {
          return FadeInUp(
            child: Form(
              key: _formKey, // Attach form key
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                child: Column(
                  children: [
                    Text(
                      "Register Bottom sheet",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    CustomTextField(
                      hintText: "",
                      textEditingController: emailController,
                      textInputType: TextInputType.emailAddress,
                      label: "Enter email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
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
                       await  bloc.registerUser(
                             emailController.text,
                             passwordController.text,
                          );
                        }
                      },
                    ),
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
