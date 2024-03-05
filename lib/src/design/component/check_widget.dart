import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../driven/util/widget_util.dart';
import '../../config/app_color.dart';

/// 多選框
class CheckWidget extends StatefulWidget {
  const CheckWidget(
    this.controller, {
    Key? key,
    this.text = "",
    this.textWidth,
    this.onTap,
  }) : super(key: key);

  final CheckController controller; // 多選框控制器
  final String text; // 多選框內文
  final double? textWidth; // 文字寬度
  final Function(bool? value)? onTap;

  @override
  _CheckWidgetState createState() => _CheckWidgetState();
}

class _CheckWidgetState extends State<CheckWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      return Colors.white;
    }

    return ElevatedButton(
      style: transparentButtonStyle(textHeight: 0, onPrimary: Colors.transparent),
      onPressed: () {
        setState(() {
          widget.controller.status = !widget.controller.status;
          _handleTap(widget.controller.status);
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 18.r,
            height: 18.r,
            child: Checkbox(
              checkColor: Colors.black,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: widget.controller.status,
              onChanged: (bool? value) {
                _handleTap(value!);
                setState(() {
                  widget.controller.status = value;
                });
              },
            ),
          ),
          addHorizontalSpace(6.w),
          widget.textWidth == null
              ? Text(
                  widget.text,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: AppColor.textColor1,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                )
              : SizedBox(
                  width: widget.textWidth,
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: AppColor.textColor1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void _handleTap(bool status) {
    widget.onTap?.call(status);
  }
}

class CheckController {
  bool status = false;
}
