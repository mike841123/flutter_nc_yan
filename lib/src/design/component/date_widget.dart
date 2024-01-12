
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../driven/util/widget_util.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';

/// 日期選擇器組件
class DateWidget extends StatefulWidget {
  const DateWidget(
    this.controller, {
    Key? key,
    required this.width,
    required this.height,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.bgColor,
    this.borderColor,
    this.contentPadding,
    this.borderRadius = 8.0,
    this.borderWidth,
    this.iconSize,
    this.showIcon = true,
    this.hint,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  final TextEditingController controller; // 日期選擇器內文
  final double width; // 日期選擇器寬
  final double height; // 日期選擇器高
  final DateTime? initialDate; // 預設日期
  final DateTime? firstDate; // 過去可選日期
  final DateTime? lastDate; // 未來可選日期
  final Color? bgColor; // 背景顏色
  final Color? borderColor; // 邊框顏色
  final EdgeInsetsGeometry? contentPadding; // 內文與邊框間距
  final double borderRadius; // 邊框圓角度數
  final double? borderWidth; // 邊框粗度
  final double? iconSize; // 圖標大小
  final bool showIcon; // 是否顯示圖標
  final String? hint; // 預設內文
  final MainAxisAlignment mainAxisAlignment; // 內文對齊

  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  late DateTime initialDate;
  late DateTime firstDate;
  late DateTime lastDate;
  late Color bgColor;
  late Color borderColor;
  late EdgeInsetsGeometry contentPadding;
  late double borderWidth;
  late double iconSize;
  late String hint;

  @override
  void initState() {
    super.initState();
    initialDate = widget.initialDate ?? DateTime.now();
    firstDate = widget.firstDate ?? DateTime(1900);
    lastDate = widget.lastDate ?? DateTime(2100);
    bgColor = widget.bgColor ?? Colors.transparent;
    borderColor = (widget.borderColor ?? Color(0xff999db3));
    contentPadding = widget.contentPadding ?? EdgeInsets.only(left: 10.w, right: 10.w);
    borderWidth = widget.borderWidth ?? 1.w;
    iconSize = widget.iconSize ?? 18.r;
    hint = widget.hint ?? "請選擇";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        border: borderWidth == 0 ? null : Border.all(color: borderColor, width: borderWidth),
      ),
      child: ElevatedButton(
        style: transparentButtonStyle(textHeight: 0, borderRadius: widget.borderRadius),
        onPressed: () async {
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
          );
          setState(() {
            widget.controller.text = date?.timeToString().split(" ").first ?? "";
          });
        },
        child: Padding(
          padding: contentPadding,
          child: Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: [
              Visibility(
                visible: widget.showIcon,
                child: Icon(
                  Icons.calendar_today,
                  size: iconSize,
                ),
              ),
              Visibility(
                visible: widget.showIcon,
                child: addHorizontalSpace(8.w),
              ),
              Text(
                widget.controller.text.isNotEmpty ? widget.controller.text : hint,
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: widget.controller.text.isNotEmpty ? Colors.black : Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
