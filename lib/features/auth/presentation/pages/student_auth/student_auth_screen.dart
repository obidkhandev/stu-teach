import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stu_teach/core/extension/widget_extantion.dart';
import 'package:stu_teach/core/routes/app_routes.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_assets.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:stu_teach/features/auth/presentation/cubit/auth/auth_state.dart';
import 'package:stu_teach/features/auth/presentation/pages/login/part/custom_dialog.dart';
import 'package:stu_teach/features/auth/presentation/pages/student_auth/part/student_register_bottom_sheet.dart';
import 'package:stu_teach/features/common/widget/custom_app_bar.dart';
import 'package:stu_teach/features/common/widget/custom_button.dart';
import 'package:stu_teach/features/common/widget/text_field_widget.dart';

class StudentAuthScreen extends StatefulWidget {
  const StudentAuthScreen({super.key});

  @override
  State<StudentAuthScreen> createState() => _StudentAuthScreenState();
}

class _StudentAuthScreenState extends State<StudentAuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String email) {
    RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegExp.hasMatch(email)) {
      return 'Iltimos, haqiqiy elektron pochta manzilini kiriting';
    }
    return null; // Valid email
  }

  String? validatePassword(String password) {
    if (password.isEmpty || password.length < 6) {
      return 'Parol kamida 6 ta belgidan iborat bo\'lishi kerak';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // Navigate to onboarding on successful login
          if (state is AuthenticatedState) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.studentMainScreen, (route) => false);
          }

          // Show error message if there's an error
          if (state is AuthErrorState) {
            customDialog(
                context, 'User not found!!!', state.message, AppIcons.icError);
          }
        },
        builder: (context, state) {
          final bloc = context.read<AuthCubit>();
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    AppImages.imgHandPhone,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: wi(12)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Student Login',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Unbounded',
                                ),
                          ),
                          SizedBox(height: he(12)),
                          Text(
                            'Tizimga kirish uchun elektron pochta manzilingiz va parolni kiriting!',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ).paddingOnly(right: wi(15)),
                          SizedBox(height: he(24)),
                          CustomTextField(
                            hintText: 'Elektron pochta manzilingiz',
                            textEditingController: emailController,
                            textInputType: TextInputType.emailAddress,
                            label: 'Elektron pochta',
                            validator: (value) => validateEmail(value ?? ''),
                          ),
                          SizedBox(height: he(24)),
                          CustomTextField(
                            hintText: 'Parol',
                            textEditingController: passwordController,
                            textInputType: TextInputType.text,
                            label: 'Parol',
                            obscure: isObscure,
                            preIconColor: AppColors.grey3,
                            suffixIcon: isObscure
                                ? AppIcons.icClosedEye
                                : AppIcons.icOpenEye,
                            suffixIconOnTap: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                            validator: (value) => validatePassword(value ?? ''),
                          ),
                          SizedBox(height: he(15)),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, AppRoutes.login);
                            },
                            child: Text(
                              "I am a teacher",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          SizedBox(height: he(50)),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: CustomButton(
                                  text: "Ro'yhatdan o'tish",
                                  onTap: () {
                                    studentRegisterBottomSheet(
                                        context: context);
                                  },
                                ),
                              ),
                              SizedBox(width: wi(15)),
                              Expanded(
                                child: CustomButton(
                                  text: "Kirish",
                                  isLoading: state is AuthLoadingState,
                                  onTap: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      bloc.loginUser(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
