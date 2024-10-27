// import 'package:flutter/cupertino.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class AppPermissions {
//   AppPermissions() {
//     getLocationPermission();
//   }
//
//
//   static getLocationPermission() async {
//     PermissionStatus status = await Permission.location.status;
//     debugPrint("location STATUS:$status");
//     if (status.isDenied) {
//       PermissionStatus status = await Permission.location.request();
//       debugPrint("location STATUS AFTER ASK:$status");
//     }
//   }
// }