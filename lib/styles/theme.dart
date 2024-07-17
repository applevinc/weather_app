import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/styles/colors.dart';

abstract class AppTheme {
  static final defaultBorder = OutlineInputBorder(
    borderSide: const BorderSide(width: 2),
    borderRadius: BorderRadius.circular(6),
  );

  static ThemeData get light {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.lightScaffoldBackground,
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: MaterialColor(
          0xffE0334C,
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
      textTheme: GoogleFonts.poppinsTextTheme().apply(
        bodyColor: AppColors.lightText,
        displayColor: AppColors.lightText,
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightScaffoldBackground,
        elevation: 0.0,
        iconTheme: IconThemeData(color: AppColors.lightText),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        elevation: 0.0,
        backgroundColor: AppColors.lightScaffoldBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.darkScaffoldBackground,
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: MaterialColor(
          0xffE0334C,
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
        bodyColor: AppColors.darkText,
        displayColor: AppColors.darkText,
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkScaffoldBackground,
        elevation: 0.0,
        iconTheme: IconThemeData(color: AppColors.darkText),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        elevation: 0.0,
        backgroundColor: AppColors.darkScaffoldBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      ),
      disabledColor: Colors.grey,
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: const Color(0xff2E3336),
        labelStyle: const TextStyle(
          color: AppColors.darkText,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(
          color: AppColors.darkText,
          fontWeight: FontWeight.w500,
        ),
        errorStyle: const TextStyle(
          color: AppColors.error,
          fontSize: 12,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 23.h,
          horizontal: 12.w,
        ),
        enabledBorder: defaultBorder.copyWith(
          borderSide: const BorderSide(color: Color(0xff2E3336)),
        ),
        focusedBorder: defaultBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        disabledBorder: defaultBorder,
        border: defaultBorder.copyWith(
          borderSide: const BorderSide(color: Color(0xff2E3336)),
        ),
        errorBorder: defaultBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: defaultBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        dense: true,
        style: ListTileStyle.list,
      ),
      cardTheme: CardTheme(
        margin: EdgeInsets.zero,
        shadowColor: Colors.black.withOpacity(0.04),
        color: const Color(0xff282828),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
