import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/src/design/component/custom_appbar.dart';
import 'package:yan_demo_fcm/src/design/page/my_advertisement/my_advertisement_cubit.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../../config/app_color.dart';
import '../../component/custom_text_field.dart';
import '../../component/input.dart';

class AdvertiseAdPage extends StatefulWidget {
  const AdvertiseAdPage({super.key});

  @override
  CurrentPageState<AdvertiseAdPage> createState() => _AdvertiseAdPageState();
}

class _AdvertiseAdPageState extends CurrentPageState<AdvertiseAdPage> {
  TextEditingController pwController = TextEditingController();
  List<String> test = ["1", "2", "3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor4,
      appBar: const CustomAppBar(
        title: "發佈廣告",
      ),
      body: CustomScrollView(
        // 滑動按鈕固定在下方
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Input(
                          pwController,
                          hint: "请输入密码",
                          title: "密码",
                        ),
                        _dropdownItem("選擇幣種"),
                        Input(
                          pwController,
                          hint: "请输入密码",
                          title: "密码",
                        ),
                        Input(
                          pwController,
                          hint: "请输入密码",
                          title: "密码",
                        ),
                        Input(
                          pwController,
                          hint: "请输入密码",
                          title: "密码",
                        ),
                        Input(
                          pwController,
                          hint: "请输入密码",
                          title: "密码",
                        ),
                        Input(
                          pwController,
                          hint: "请输入密码",
                          title: "密码",
                        ),
                        Input(
                          pwController,
                          hint: "请输入密码",
                          title: "密码",
                        ),
                        Input(
                          pwController,
                          hint: "请输入密码",
                          title: "密码",
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 390.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: AppColor.bgColor2,
                    ),
                    child: ElevatedButton(
                      style: transparentButtonStyle(textHeight: 0),
                      onPressed: () {},
                      child: Text(
                        "發布",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: "HelveticaNeue",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _dropdownItem(String title) {
    return Container(
      height: 50.h,
      width: 390.w,
      decoration: BoxDecoration(
        color: AppColor.bgColor4,
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
                title,
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
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  icon: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Image.asset(
                      'assets/images/icon_drop_menu.png',
                      width: 12.w,
                      height: 7.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                  isDense: true,
                  items: test.map<DropdownMenuItem<String>>((String data) {
                    return DropdownMenuItem(
                      value: data,
                      child: Builder(
                        builder: (context) {
                          return Text(
                            data,
                            style: TextStyle(
                                color: AppColor.textColor5, fontWeight: FontWeight.w400, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 16.sp),
                            textAlign: TextAlign.left,
                          );
                        },
                      ),
                    );
                  }).toList(),
                  value: "2",
                  hint: Text(
                    "請選擇",
                    style:
                        TextStyle(color: AppColor.textColor5, fontWeight: FontWeight.w400, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 16.sp),
                  ),
                  onChanged: (String? value) {},
                  isExpanded: true,
                  itemHeight: 35.h,
                  offset: Offset(0, -4.h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
