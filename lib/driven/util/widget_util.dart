import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 空白高度 widget
/// [height] 高度
Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

/// 空白寬度 widget
/// [width] 寬度
Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

/// 空白 widget
Widget empty() {
  return Container();
}

/// network image 讀取動畫
Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder({double? size, double? strokeWidth}) {
  return (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(
      child: SizedBox(
        height: size ?? 20.r,
        width: size ?? 20.r,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth ?? 4.w,
          color: Colors.white.withOpacity(0.8),
          value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
        ),
      ),
    );
  };
}
