import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_assets.dart';
import 'package:stu_teach/core/values/app_colors.dart';


class OnboardingButton extends StatelessWidget {
  const OnboardingButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: wi(51),
      height: he(51),
      child: Stack(
        children: [
          Container(
            width: wi(51),
            height: he(51),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AppIcons.icArrowRight,
              colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              fit: BoxFit.contain,
            ),
          ),
          Positioned.fill(
            child: IconButton(
              onPressed: onPressed,
              style: IconButton.styleFrom(
                fixedSize: Size(wi(51), he(51)),
                elevation: 0,
              ),
              icon: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
