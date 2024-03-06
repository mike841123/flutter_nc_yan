import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../driven/util/widget_util.dart';
import '../../../../config/app_color.dart';
import '../../../component/open_image_button.dart';
import '../../../model/user_cubit/user_cubit.dart';

class SafeSettingItem extends StatelessWidget {
  const SafeSettingItem({
    super.key,
    this.isImg = false,
    this.imgSrc = "",
    this.contentText = "",
    this.titleText = "",
  });

  final bool isImg;
  final String imgSrc;
  final String contentText;
  final String titleText;

  @override
  Widget build(BuildContext context) {
    TextEditingController imgPath2Controller = TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColor.bgColor1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleText,
            style: TextStyle(color: AppColor.textColor1, fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              isImg
                  ? BlocBuilder<UserCubit, UserState>(
                      buildWhen: (previous, current) => previous.uploadImageResponse != current.uploadImageResponse,
                      builder: (context, state) {
                        return OpenImageButton(
                          imgPath2Controller,
                          child: (String path) {
                            return ClipOval(
                              child: Image.network(state.uploadImageResponse?.data ?? "",
                                  width: 56.r,
                                  height: 56.r,
                                  fit: BoxFit.fill,
                                  loadingBuilder: loadingBuilder(56.r), errorBuilder: (BuildContext context, Object child, StackTrace? stackTrace) {
                                return SizedBox(
                                  width: 56.r,
                                  height: 56.r,
                                );
                              }),
                            );
                          },
                          onImagePickerSuccess: (String path) async {
                            if (path.isNotEmpty) {
                              File imageFile = File(path);
                              imgPath2Controller.text = await BlocProvider.of<UserCubit>(context).uploadImg(imageFile);
                              return true;
                            } else {
                              return false;
                            }
                          },
                        );
                      },
                    )
                  : Text(
                      contentText,
                      style: TextStyle(color: AppColor.textColor2, fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
              Icon(
                color: AppColor.bgColor3,
                Icons.arrow_forward_ios,
              )
            ],
          )
        ],
      ),
    );
  }
}
