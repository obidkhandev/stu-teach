// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scale_button/scale_button.dart';
import 'package:stu_teach/core/extension/widget_extantion.dart';
import 'package:stu_teach/core/utils/helper_widget.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leadingWidget;
  final bool isDivider;
  final List<Widget>? action;

  final String? rightIcon;
  final Function()? leftOnTap;
  final Function()? rightOnTap;

  const CustomAppBar({
    super.key,
    this.title,
    this.leadingWidget,
    this.rightIcon,
    this.leftOnTap,
    this.rightOnTap,
    this.isDivider = false,
    this.action,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      centerTitle: true,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.1),
          child: isDivider ? customDivider : const SizedBox.shrink()),
      title: Text(
        title ?? "",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: he(20),
              fontWeight: FontWeight.w600,
            ),
      ),
      leading: leadingWidget != null
          ? ScaleButton(
              bound: 0.1,
              onTap: leftOnTap,
              child: leadingWidget ?? const SizedBox.shrink(),
            )
          : const SizedBox.shrink(),
      actions: action ??
          [
            rightIcon != null
                ? ScaleButton(
                        bound: 0.1,
                        onTap: rightOnTap,
                        child: SvgPicture.asset(rightIcon ?? AppIcons.ic1st))
                    .paddingOnly(right: wi(16))
                : const SizedBox.shrink(),
          ],
    );
  }
}
