import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/styles/colors.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: MaterialColor(
          0xff808080,
          <int, Color>{
            50: AppColors.primary.withOpacity(.1), //10%
            100: AppColors.primary.withOpacity(.2), //20%
            200: AppColors.primary.withOpacity(.3), //30%
            300: AppColors.primary.withOpacity(.4), //40%
            400: AppColors.primary.withOpacity(.5), //50%
            500: AppColors.primary.withOpacity(.6), //60%
            600: AppColors.primary.withOpacity(.7), //70%
            700: AppColors.primary.withOpacity(.8), //80%
            800: AppColors.primary.withOpacity(.9), //90%
            900: AppColors.primary, //100%
          },
        ),
      ),
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: AppColors.lightText,
        displayColor: AppColors.lightText,
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black38,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: AppColors.primary.withOpacity(.1),
        tabAlignment: TabAlignment.start,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.secondary,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: AppColors.lightText),
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 16.sp,
          color: AppColors.lightText,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 0.0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ).r,
        ),
      ),
      dividerTheme: const DividerThemeData(
        space: 0,
        color: AppColors.secondary,
      ),
    );
  }
}
