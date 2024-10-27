import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stu_teach/core/extension/widget_extantion.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_assets.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/features/main/data/model/get_teacher_tasks/response/get_all_tasks_response.dart';

class TeacherTaskItem extends StatelessWidget {
  final Function()? onEdit;
  final Function()? onDelete;
  final Function()? onSee;
  final TaskResponse model;

  const TeacherTaskItem(
      {super.key, this.onEdit, this.onDelete, this.onSee, required this.model});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          model.title,
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
              model.finishedCount.toString(),
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
            onPressed: onEdit ,
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
            onPressed: onSee,
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
            onPressed: onDelete,
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
