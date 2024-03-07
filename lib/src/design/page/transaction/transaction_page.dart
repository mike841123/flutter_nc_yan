import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/driven/abstract/current_page_state.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';
import 'package:yan_demo_fcm/src/config/app_color.dart';

import '../../component/border_input.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends CurrentPageState<TransactionPage> {
  TextEditingController sellPrice = TextEditingController();
  TextEditingController buyPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Column(
        children: [
          SizedBox(
            width: 220.w,
            child: Column(
              children: [
                Row(
                  children: [
                    ClipPath(
                      clipper: ParallelogramClipper(),
                      child: Container(
                        color: AppColor.bgColor2,
                        height: 40.h,
                        width: 110.w,
                        child: Center(
                            child: Text(
                          "買入",
                          style: TextStyle(color: AppColor.textColor1, fontSize: 16.sp),
                        )),
                      ),
                    ),
                    ClipPath(
                      clipper: ParallelogramClipper2(),
                      child: Container(
                        color: Colors.blue,
                        height: 40.h,
                        width: 110.w,
                      ),
                    ),


                  ],
                ),
                addVerticalSpace(20.h),
                BorderInput(buyPrice,),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(1, 1) // 左上角
      ..lineTo(size.width, 0) // 右上角
      ..lineTo(size.width * 0.8, size.height) // 右下角
      ..lineTo(0, size.height); // 左下角
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ParallelogramClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(size.width, 1) // 右上角
      ..lineTo(size.width * 0.2, 0) // 左上角
      ..lineTo(0, size.height) // 左下角
      ..lineTo(size.width, size.height); // 右下角
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
