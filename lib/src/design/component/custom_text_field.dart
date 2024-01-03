import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../config/app_color.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
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

  @override
  CurrentPageState<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends CurrentPageState<CustomTextField> {
  bool isEyeOpen = false;
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.w,
      child: Column(
        crossAxisAlignment: widget.title.isEmpty ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          widget.title.isEmpty
              ? empty()
              : Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Text(
                    widget.title,
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 16.sp),
                  ),
                ),
          TextField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            keyboardType: widget.isNumber ? TextInputType.numberWithOptions(decimal: !widget.isInt, signed: !widget.isInt) : null,
            inputFormatters: widget.isNumber ? [FilteringTextInputFormatter.allow(RegExp(!widget.isInt ? "[0-9]" : "[0-9.]"))] : null,
            textAlign: widget.isCenter ? TextAlign.center : TextAlign.left,
            autofocus: false,
            obscureText: obscureText,
            cursorWidth: 1.w,
            cursorColor: AppColor.color2,
            readOnly: widget.readOnly,
            style: TextStyle(fontSize: 14.sp, color: AppColor.color2),
            decoration: InputDecoration(
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
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffefefef), width: 1.w),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffefefef), width: 1.w),
              ),
              isCollapsed: true,
              contentPadding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 12.w, right: 12.w),
              hintText: widget.hint,
              hintStyle:
                  TextStyle(color: Color(0xff999999), fontWeight: FontWeight.w400, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}
