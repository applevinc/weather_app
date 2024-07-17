import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppPadding {
  static double horizontal = 20.w;

  static double vertical = 20.h;

  static EdgeInsetsGeometry get defaultPadding {
    return EdgeInsets.symmetric(
      horizontal: horizontal,
      vertical: vertical,
    );
  }

  static EdgeInsetsGeometry get symetricHorizontalOnly {
    return EdgeInsets.symmetric(horizontal: horizontal);
  }

  static EdgeInsetsGeometry get symetricVerticalOnly {
    return EdgeInsets.symmetric(vertical: vertical);
  }
}

double screenHeight(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}

double screenWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}
