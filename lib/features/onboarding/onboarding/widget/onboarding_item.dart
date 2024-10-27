import 'package:flutter/material.dart';
import 'package:stu_teach/core/utils/size_config.dart';
import 'package:stu_teach/core/values/app_colors.dart';


class OnboardingItem extends StatelessWidget {
  const OnboardingItem(
      {super.key,
      required this.image,
      required this.title,
      required this.opacity,
      required this.description, required this.subtitle,
      });

  final bool opacity;
  final String image;
  final String title;
  final String subtitle;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: AnimatedOpacity(
        curve: Curves.decelerate,
        opacity: opacity ? 1 : 0,
        duration: const Duration(milliseconds: 850),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              // width:
              fit: BoxFit.contain,
              // height: 315,
            ),
            SizedBox(height: he(20),),
            Text(
              maxLines: 1,
              title,

              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: 36,
                fontFamily: 'Unbounded',
              )
            ),
            Text(
             maxLines: 2,
              subtitle,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: 36,
                color:  AppColors.grey4,
                fontFamily: 'Unbounded',

              )
            ),
            SizedBox(height: he(20),),

            Text(
              maxLines: 4,
              description,
              style: theme.textTheme.bodyLarge!.copyWith(
                // fontSize:
                fontWeight: FontWeight.w500,
              )
            ),
          ],
        ),
      ),
    );
  }
}
