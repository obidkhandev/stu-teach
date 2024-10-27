import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stu_teach/core/extension/widget_extantion.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_assets.dart';
import 'package:stu_teach/core/values/app_colors.dart';

class TeacherTaskItem extends StatelessWidget {
  const TeacherTaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Task Name",
          style: theme.textTheme.headlineLarge?.copyWith(
            // fontSize: he(14),
            // fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(),

        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.grey3),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: wi(10),
              vertical: he(5),
            ),
            child: Text(
              "2",
              style: theme.textTheme.headlineLarge?.copyWith(
                fontSize: he(14),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        SizedBox(width: wi(20)),
        SizedBox(
          height: he(30),
          width: wi(30),
          child: IconButton.filled(
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            icon: SvgPicture.asset(
              AppIcons.icEdit,
              width: wi(24),
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        SizedBox(width: wi(12)),
        SizedBox(
          height: he(30),
          width: wi(30),
          child: IconButton.filled(
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            icon: SvgPicture.asset(
              AppIcons.icOpenEye,
              width: wi(24),
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        SizedBox(width: wi(12)),
        SizedBox(
          height: he(30),
          width: wi(30),
          child: IconButton.filled(
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            icon: SvgPicture.asset(
              AppIcons.icDelete,
              width: wi(24),
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    ).paddingSymmetric(vertical: he(10));
  }
}
