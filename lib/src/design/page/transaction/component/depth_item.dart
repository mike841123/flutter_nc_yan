import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/app_color.dart';

class DepthItem extends StatelessWidget {
  const DepthItem({
    Key? key,
    required this.price,
    required this.count,
    this.isBuy = false,
    this.value = 0,
  }) : super(key: key);

  final double price;
  final double count;
  final bool isBuy;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Container(
                  color: isBuy ? AppColor.bgColor9 : AppColor.bgColor10,
                  height: 24.h,
                ),
              ),
            )
          ],
        ),
        Positioned(
            child: Text(
          price.toStringAsFixed(2),
          style: TextStyle(color: AppColor.textColor3, fontSize: 12.sp),
        )),
        Positioned(
            right: 0,
            child: Text(
              count.toStringAsFixed(2),
              style: TextStyle(color: AppColor.textColor3, fontSize: 12.sp),
            )),
      ],
    );
  }
}
