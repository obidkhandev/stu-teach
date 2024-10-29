
import 'package:flutter/material.dart';
import 'package:stu_teach/core/values/app_assets.dart';
import 'package:stu_teach/features/common/widget/custom_empty_widget.dart';


class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomEmptyWidget(
          icon: AppIcons.icNoImg,
          title: "Internet Error",
          subTitle: 'No connection internet',
         ),
    );
  }
}
