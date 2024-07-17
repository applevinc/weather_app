
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/styles/colors.dart';
import 'package:weather_app/styles/spacing.dart';
import 'package:weather_app/utils/models/failure.model.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.error,
    required this.retry,
  });

  final Failure? error;
  final Function() retry;

  @override
  Widget build(BuildContext context) {
    String message = '';

    if (error != null) {
      message = error!.message;
    } else {
      message = InternalFailure().message;
    }

    return Padding(
      padding: AppPadding.symetricHorizontalOnly,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.error_outline,
              size: 100.h,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
          if (error is PermissionFailure)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: TextButton(
                onPressed: openAppSettings,
                child: Text(
                  'Open settings',
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          SizedBox(height: 20.h),
          TextButton(
            onPressed: retry,
            child: Text(
              'Retry',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
