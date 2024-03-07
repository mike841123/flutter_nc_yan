import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../driven/util/widget_util.dart';
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
    this.rowTitle = false,
    this.isShowBorder = false,
    this.isButton = false,
    this.opBtnFunc,
    this.countDown = 0,
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
  final bool isShowBorder;
  final bool isButton;
  final Function()? opBtnFunc;
  final int countDown;

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
    return Container(
      height: 50.h,
      width: 390.w,
      decoration: BoxDecoration(color: AppColor.bgColor1),
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
        style: TextStyle(fontSize: 15.sp, color: AppColor.textColor1),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          suffixIconConstraints: BoxConstraints(maxHeight: 30.h),
          suffixIcon: widget.obscureText || widget.isButton //輸入框尾端圖示
              ? widget.obscureText
              ? _obscure()
              : widget.isButton
              ? _opButton()
              : null
              : null,
          isCollapsed: true,

          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.isShowBorder ? AppColor.bgColor3! : Colors.transparent, width: 1.w),
          ),

          /// 輸入匡預設 focus border
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.isShowBorder ? AppColor.bgColor5! : Colors.transparent, width: 1.w),
          ),
          contentPadding: EdgeInsets.only(top: 8.h, bottom: 8.h, left: 12.w, right: 12.w),
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: AppColor.textColor5, fontWeight: FontWeight.w400, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 15.sp),
        ),
      ),
    );
  }

  Widget _obscure() {
    return InkWell(
      onTap: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
      child: Container(
          margin: EdgeInsets.only(right: 10.w),
          child: Image.asset(
            obscureText ? 'assets/images/img_eye_close.png' : 'assets/images/img_eye_open.png',
            width: 20.r,
            height: 14.r,
            fit: BoxFit.fill,
          )),
    );
  }

  Widget _opButton() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.bgColor2!),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      height: 30.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      constraints: BoxConstraints(
        maxWidth: 100.w,
      ),
      child: ElevatedButton(
        style: transparentButtonStyle(),
        onPressed: widget.countDown == 0 ? widget.opBtnFunc : null,
        child: Text(
          widget.countDown != 0 ? widget.countDown.toString() : "發送驗證碼",
          style: TextStyle(color: AppColor.textColor2),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
