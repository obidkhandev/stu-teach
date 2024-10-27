import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_colors.dart';


customDialog(BuildContext context, String title, String subtitle, String icon) {
  return showDialog(
      context: context,
      builder: (context) {
        return FadeInUp(
          child: AlertDialog(
            // title:  Text(title,style: Theme.of(context).textTheme.titleLarge,),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  icon,
                  width: wi(70),
                  height: he(70),
                ),
                SizedBox(height: he(20)),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(height: he(10)),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        // fontSize:
                        color: AppColors.grey3,
                      ),
                ),
              ],
            ),
          ),
        );
      });
}
