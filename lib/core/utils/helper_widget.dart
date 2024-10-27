import 'package:flutter/material.dart';
import 'package:stu_teach/core/values/app_colors.dart';


final double customButtonPadding = MediaQuery.of(navigatorKey.currentState!.context).padding.bottom + 20;
final double customBarPadding = MediaQuery.of(navigatorKey.currentState!.context).padding.top ;
Widget customDivider =
    const Divider(color: AppColors.secondary, thickness: 1.5, height: 0);
final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
