// import 'package:flutter/material.dart';
// import 'package:lingo_lab/core/utils/size_config.dart';
// import 'package:lingo_lab/core/values/app_colors.dart';
//
//
// class PersistentHeader extends SliverPersistentHeaderDelegate {
//   final Widget widget;
//   final double? height;
//
//   PersistentHeader({required this.widget, this.height});
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       width: double.infinity,
//       color: AppColors.white,
//       child: Center(child: widget),
//     );
//   }
//
//   @override
//   double get maxExtent => he(height ?? 70);
//
//   @override
//   double get minExtent => he(height ?? 70);
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }
// }
