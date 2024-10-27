import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stu_teach/core/extension/widget_extantion.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_colors.dart';
import 'package:stu_teach/features/common/widget/loading_widget.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.radius,
    this.bgColor,
    this.textColor,
    this.isLoading = false,
    this.paddingV,
    this.fontSize,
    this.colorL,
    this.icon,
    this.rightW,
    this.borderColor,
    this.fontW,
    this.iconC,
    this.height,
  });

  final String text;
  final Function() onTap;
  final BorderRadius? radius;
  final double? paddingV;
  final double? fontSize;
  final FontWeight? fontW;

  final Color? colorL;
  final String? icon;
  final Color? bgColor;
  final Color? iconC;

  final Color? borderColor;
  final Color? textColor;
  final bool isLoading;
  final double? height;
  final Widget? rightW;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      borderRadius: radius ?? BorderRadius.circular(10),
      child: InkWell(
        splashColor: AppColors.transparent,
        // highlightColor: AppColors.transparent,
        hoverColor: AppColors.transparent,
        borderRadius: radius ?? BorderRadius.circular(10),
        onTap: isLoading ? () {} : onTap,
        child: Ink(
          height: height ?? he(50),
          padding: EdgeInsets.symmetric(
              vertical: isLoading ? he(8) : paddingV ?? he(10),
              horizontal: wi(8)),
          decoration: BoxDecoration(
            borderRadius: radius ?? BorderRadius.circular(10),
            border: Border.all(color: borderColor ?? AppColors.transparent),
            color: bgColor ?? AppColors.primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isLoading
                  ? SizedBox(
                      height: he(29),
                      width: he(29),
                      child: Center(
                          child:
                              LoadingWidget(color: colorL ?? AppColors.white)))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Text(
                            text,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: textColor ?? AppColors.white,
                                    fontSize: fontSize ?? 16,
                                    fontWeight: fontW),
                          ),
                        ),
                        rightW ?? const SizedBox.shrink(),
                        icon != null
                            ? SvgPicture.asset(
                                icon ?? "",
                                colorFilter: ColorFilter.mode(
                                    iconC ?? textColor ?? AppColors.white,
                                    BlendMode.srcIn),
                              ).paddingOnly(left: 8)
                            : const SizedBox.shrink(),
                      ],
                    ).paddingSymmetric(horizontal: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    super.key,
    required this.text,
    required this.onTap,
    this.primaryColor,
    this.textColor,
    this.radius,
    this.isLoading = false,
    this.icon,
    this.iconC,
    this.bgColor,
  });

  final String text;
  final Function() onTap;
  final Color? textColor;
  final Color? primaryColor;
  final Color? bgColor;
  final double? radius;
  final bool isLoading;
  final String? icon;
  final Color? iconC;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius ?? 10),
      child: InkWell(
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        hoverColor: AppColors.primaryColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(radius ?? 10),
        onTap: onTap,
        child: Ink(
          height: 50,
          padding: EdgeInsets.symmetric(vertical: isLoading ? 8 : 14),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 10),
              border: Border.all(
                  color: primaryColor ?? AppColors.primaryColor, width: 1),
              color: bgColor ?? AppColors.white),
          child: isLoading
              ? SizedBox(
                  height: 35,
                  width: 29,
                  child: Center(
                      child: LoadingWidget(
                          color: textColor ?? AppColors.primaryColor)))
              : icon != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(text,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color:
                                          textColor ?? AppColors.primaryColor)),
                        ),
                        SvgPicture.asset(
                          icon ?? "",
                          colorFilter: ColorFilter.mode(
                              iconC ?? AppColors.primaryColor, BlendMode.srcIn),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 20)
                  : Center(
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: textColor ?? AppColors.primaryColor,
                            ),
                      ),
                    ),
        ),
      ),
    );
  }
}
