import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/styles/colors.dart';

class LoadingOverlayView extends StatelessWidget {
  const LoadingOverlayView({
    super.key,
    required this.show,
    required this.child,
  });

  final bool show;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayBaseView(
      show: show,
      loader: Container(
        width: 100.h,
        height: 100.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Transform.scale(
          scale: 0.3,
          child: CircularProgressIndicator(
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            strokeWidth: 15.sp,
            backgroundColor: const Color(0xffe2f7fc),
          ),
        ),
      ),
      child: child,
    );
  }
}

class LoadingOverlayBaseView extends StatelessWidget {
  const LoadingOverlayBaseView({
    super.key,
    required this.show,
    required this.child,
    required this.loader,
  });

  final bool show;
  final Widget child;
  final Widget loader;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (show)
          Positioned.fill(
            child: Container(
              alignment: Alignment.center,
              color: Colors.black12,
              child: loader,
            ),
          ),
      ],
    );
  }
}
