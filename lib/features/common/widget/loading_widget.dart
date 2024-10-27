import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:stu_teach/core/values/app_colors.dart';

import '../../../core/utils/size_config.dart';



class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? CircularProgressIndicator(
             color: color ?? AppColors.white,
              strokeWidth: wi(2.5),
              backgroundColor: AppColors.primaryColor.withOpacity(.7),)
          : CupertinoActivityIndicator(color: color ?? AppColors.white),
    );
  }
}
