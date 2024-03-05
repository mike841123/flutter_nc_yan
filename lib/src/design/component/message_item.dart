import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/app_color.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.title, required this.time, required this.onTap});

  final String title;
  final String time;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.bgColor3,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Padding(
            padding: EdgeInsets.only(right: 10.w, left: 18.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 290.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColor.textColor8,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.textColor8,
                        ),
                      )
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
