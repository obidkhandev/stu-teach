import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

customToast({required String message,required Color bgColor}){ {
  return  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: bgColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
}