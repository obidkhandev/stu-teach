import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stu_teach/core/extension/for_context.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_assets.dart';
import 'package:stu_teach/features/common/widget/custom_button.dart';



class CustomEmptyWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String? buttonText;
  final String? icon;
  final Function()? onTap;


  const CustomEmptyWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      this.buttonText,
      this.onTap,

      this.icon});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: context.w / 1.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(icon ?? AppIcons.icEmpty,width: wi(60),height: he(60),),
                SizedBox(height: he(18)),
                Text(title, style: Theme.of(context).textTheme.headlineLarge),
               buttonText == null ?SizedBox(height: he(4)) : SizedBox(height: he(18)),
                Text(subTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: he(18)),
                buttonText == null
                    ? const SizedBox.shrink()
                    : CustomButton(text: buttonText ?? "", onTap: onTap ?? (){})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
