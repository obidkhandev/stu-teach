import 'package:flutter/material.dart';
import 'package:stu_teach/core/extension/widget_extantion.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_assets.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/features/common/widget/custom_button.dart';
import 'package:stu_teach/features/common/widget/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validatePhoneNumber(String phoneNumber) {
    // Remove spaces and non-numeric characters for validation
    String cleanedPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    // Example validation for Uzbekistan phone number format
    RegExp phoneRegExp = RegExp(r'^998[0-9]{9}');
    if (!phoneRegExp.hasMatch(cleanedPhoneNumber)) {
      return 'Iltimos, haqiqiy telefon raqamini kiriting';
    }
    return null; // Valid phone number
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
      child: Scaffold(
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
                        'Kirish',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Unbounded',
                                ),
                      ),
                      SizedBox(height: he(12)),
                      Text(
                        'Tizimga kirish uchun telefon raqamingiz va parolni kiriting!',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                      ).paddingOnly(right: wi(15)),
                      SizedBox(height: he(24)),
                      CustomTextField(
                        hintText: 'Telefon raqamingiz',

                        textEditingController: phoneController,
                        textInputType: TextInputType.number,
                        label: 'Telefon raqamingiz',
                        validator: (value) => validatePhoneNumber(value ?? ''),
                        // return;
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
                            ? 'assets/icons/ic_eye_closed.svg'
                            : AppIcons.icOpenEye,
                        suffixIconOnTap: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        validator: (value) => validatePassword(value ?? ''),
                      ),
                      SizedBox(height: he(50)),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: CustomButton(
                              text: "Ro'yhatdan o'tish",
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: wi(15)),
                          Expanded(
                            child: CustomButton(
                              text: "Kirish",
                              onTap: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {}
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
      ),
    );
  }
}
