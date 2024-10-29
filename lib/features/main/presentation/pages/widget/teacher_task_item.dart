import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:stu_teach/core/extension/widget_extantion.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_assets.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/features/main/data/model/get_teacher_tasks/response/get_all_tasks_response.dart';

class TaskItem extends StatelessWidget {
  final Function()? onEdit;
  final Function()? onDelete;
  final Function()? onSee;
  final Function()? onUploadFile;
  final Function()? onSeeUsers;
  final bool isStudent;
  final TaskResponse model;

  const TaskItem({
    super.key,
    this.onEdit,
    this.onDelete,
    this.onSee,
    required this.model,
    required this.isStudent,
    this.onUploadFile,
    this.onSeeUsers,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Icon Button Helper Method
    Widget iconButton({
      required Function()? onPressed,
      required String iconPath,
      required Color backgroundColor,
    }) {
      return SizedBox(
        height: he(30),
        width: wi(30),
        child: IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(
            iconPath,
            width: wi(24),
            colorFilter:
                const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
          style: IconButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: wi(150),
              child: Text(
                model.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.headlineLarge,
              ),
            ),
            SizedBox(height: he(10)),
            SizedBox(
              width: wi(150),
              child: Text(
                model.tarif,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: he(10)),
            SizedBox(
              width: wi(150),
              child: Text(
                "Deadline: ${DateFormat('dd.MM.yyyy').format(DateTime.parse(model.date))}",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
        const Spacer(),
        TextButton(
          onPressed: isStudent? () {} : onSeeUsers,
          child: Text(
            model.finishedCount.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.headlineLarge?.copyWith(
              color: isStudent ? AppColors.secondary : AppColors.primaryColor,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline
            ),
          ),
        ),
        if (!isStudent)
          iconButton(
            onPressed: onEdit,
            iconPath: AppIcons.icEdit,
            backgroundColor: AppColors.primaryColor,
          ),
        SizedBox(width: wi(12)),
        iconButton(
          onPressed: onSee,
          iconPath: AppIcons.icOpenEye,
          backgroundColor:
              isStudent ? AppColors.secondary : AppColors.primaryColor,
        ),
        if (isStudent) ...[
          SizedBox(width: wi(15)),
          iconButton(
            onPressed: onUploadFile,
            iconPath: 'assets/icons/ic_upload.svg',
            backgroundColor: AppColors.secondary,
          ),
        ],
        if (!isStudent) ...[
          SizedBox(width: wi(12)),
          iconButton(
            onPressed: onDelete,
            iconPath: AppIcons.icDelete,
            backgroundColor: Colors.red,
          ),
        ],
      ],
    ).paddingSymmetric(vertical: he(10));
  }
}
