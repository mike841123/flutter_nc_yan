import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../src/config/app_color.dart';

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
Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder(double? size) {
  return (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: Colors.white.withOpacity(0.8),
          value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
        ),
      ),
    );
  };
}

/// 普通的輸入框
/// [hint] 輸入框提示字
/// [controller] 輸入框控制器
/// [title] 輸入框標題，可選，不輸入時輸入框置中，否則為了標題會靠左
/// [obscureText] 輸入框內容是否星號，默認為否
/// [onChanged] 自定輸入調用函式
/// [isNumber] 輸入框輸入是否只能輸入數字包含小數點，默認為否
/// [width] 輸入框寬度
/// [readOnly] 是否唯讀
Widget normalInputWidget(
  String hint,
  TextEditingController controller, {
  String title = "",
  bool obscureText = false,
  Function(String? value)? onChanged,
  bool isNumber = false,
  double? width,
  bool readOnly = false,
  bool isInt = false,
  bool isCenter = false,
}) {
  return SizedBox(
    width: 320.w,
    child: Column(
      crossAxisAlignment: title.isEmpty ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        title.isEmpty
            ? empty()
            : Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 16.sp),
                ),
              ),
        TextField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: isNumber ? TextInputType.numberWithOptions(decimal: !isInt, signed: !isInt) : null,
          inputFormatters: isNumber ? [FilteringTextInputFormatter.allow(RegExp(isInt ? "[0-9]" : "[0-9.]"))] : null,
          textAlign: isCenter ? TextAlign.center : TextAlign.left,
          autofocus: false,
          obscureText: obscureText,
          cursorWidth: 1.w,
          cursorColor: AppColor.color2,
          readOnly: readOnly,
          style: TextStyle(fontSize: 14.sp, color: AppColor.color2),
          decoration: InputDecoration(
            // suffixIcon: obscureText //輸入框尾端圖示
            //     ? Container(
            //     margin: EdgeInsets.only(right: 10.w),
            //     child: InkWell(
            //         child: obscureText ? eyeOpen : eyeClose,
            //         onTap: () {
            //           setState(() {
            //             isEyeOpen = !isEyeOpen;
            //             obscureText = !obscureText;
            //           });
            //         }))
            //     : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffefefef),width: 1.w),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffefefef),width: 1.w),
            ),
            isCollapsed: true,
            contentPadding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 12.w, right: 12.w),
            hintText: hint,
            hintStyle:
                TextStyle(color: Color(0xff999999), fontWeight: FontWeight.w400, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 16.sp),
          ),
        ),
      ],
    ),
  );
}

/// 空白背景按鈕風格
ButtonStyle transparentButtonStyle({double textHeight = 1, double borderRadius = 8.0, Color? onPrimary, BorderRadiusGeometry? borderRadiusGeometry}) {
  return ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: onPrimary,
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    padding: EdgeInsets.zero,
    textStyle: TextStyle(height: textHeight), //避免文字被切
    shape: RoundedRectangleBorder(
      borderRadius: borderRadiusGeometry ?? BorderRadius.circular(borderRadius),
    ),
  );
}

/// row space text item
Widget rowTextItem(String title,String content) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
            color: Color(0xff828ea1),
            fontWeight: FontWeight.w700,
            fontFamily: "HelveticaNeue",
            fontStyle: FontStyle.normal,
            fontSize: 14.sp),
      ),
      Text(
        content,
        style: TextStyle(
            color: Color(0xff828ea1),
            fontWeight: FontWeight.w700,
            fontFamily: "HelveticaNeue",
            fontStyle: FontStyle.normal,
            fontSize: 14.sp),
      ),
    ],
  );
}
