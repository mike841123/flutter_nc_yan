import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/app_color.dart';

/// border 輸入匡橫向
class BorderInput extends StatefulWidget {
  const BorderInput(
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
    this.suffixText = "",
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
  final String suffixText;

  @override
  State<BorderInput> createState() => _BorderInputState();
}

class _BorderInputState extends State<BorderInput> {
  bool isEyeOpen = false;
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
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
      style: TextStyle(fontSize: 15.sp, color: AppColor.textColor1),
      decoration: InputDecoration(
        suffixIconConstraints: BoxConstraints(maxHeight: 30.h),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Text(
            widget.suffixText,
            style: TextStyle(color: AppColor.textColor1),
          ),
        ),
        isCollapsed: true,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.bgColor5!)),

        /// 輸入匡預設 focus border
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.bgColor5!)),
        contentPadding: EdgeInsets.only(top: 8.h, bottom: 8.h, left: 12.w, right: 12.w),
        hintText: widget.hint,
        hintStyle:
            TextStyle(color: AppColor.textColor5, fontWeight: FontWeight.w400, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 15.sp),
      ),
    );
  }
}
