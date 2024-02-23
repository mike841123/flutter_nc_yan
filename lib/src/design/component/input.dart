import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../driven/util/widget_util.dart';
import '../../config/app_color.dart';

/// title 輸入匡橫向
class Input extends StatefulWidget {
  const Input(
    this.controller, {
    Key? key,
    this.title = "",
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.isNumber = false,
    this.width,
    this.readOnly = false,
    this.isInt = false,
    this.isCenter = false,
    this.hint = "",
    this.rowTitle = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final bool obscureText;
  final Function(String? value)? onChanged;
  final Function(bool? value)? onTap;
  final bool isNumber;
  final double? width;
  final bool readOnly;
  final bool isInt;
  final bool isCenter;
  final String hint;
  final bool rowTitle;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool isEyeOpen = false;
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 390.w,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.bgColor5!,
            width: 1.w,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          children: [
            SizedBox(
              width: 60.w,
              child: Text(
                widget.title,
                style: TextStyle(
                  color: AppColor.textColor1,
                  fontWeight: FontWeight.w400,
                  fontFamily: "HelveticaNeue",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.sp,
                ),
              ),
            ),
            addHorizontalSpace(16.w),
            /// 輸入匡
            Expanded(
              child: TextField(
                controller: widget.controller,
                onChanged: widget.onChanged,
                keyboardType: widget.isNumber ? TextInputType.numberWithOptions(decimal: !widget.isInt, signed: !widget.isInt) : null,
                inputFormatters: widget.isNumber ? [FilteringTextInputFormatter.allow(RegExp(!widget.isInt ? "[0-9]" : "[0-9.]"))] : null,
                textAlign: widget.isCenter ? TextAlign.center : TextAlign.left,
                autofocus: false,
                obscureText: obscureText,
                cursorWidth: 1.w,
                cursorColor: AppColor.textColor1,
                readOnly: widget.readOnly,
                style: TextStyle(fontSize: 14.sp, color: AppColor.textColor1),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIconConstraints: BoxConstraints(maxHeight: 18.h),
                  suffixIcon: widget.obscureText //輸入框尾端圖示
                      ? Container(
                          margin: EdgeInsets.only(right: 10.w),
                          child: InkWell(
                              child: Image.asset(
                                obscureText ? 'assets/images/img_eye_close.png' : 'assets/images/img_eye_open.png',
                                width: 24.r,
                                height: 24.r,
                                fit: BoxFit.fill,
                              ),
                              onTap: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              }))
                      : null,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.only(top: 8.h, bottom: 8.h, left: 12.w, right: 12.w),
                  hintText: widget.hint,
                  hintStyle: TextStyle(
                      color: AppColor.textColor5, fontWeight: FontWeight.w400, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
