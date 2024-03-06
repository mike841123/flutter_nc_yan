import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yan_demo_fcm/driven/util/custom_class.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../config/app_color.dart';
import '../../component/custom_appbar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RechargePage extends StatefulWidget {
  const RechargePage({super.key});

  @override
  CurrentPageState<RechargePage> createState() => _RechargePageState();
}

class _RechargePageState extends CurrentPageState<RechargePage> {
  @override
  Widget build(BuildContext context) {
    final RechargeArguments arguments = (ModalRoute.of(context)?.settings.arguments as RechargeArguments);
    return Scaffold(
      backgroundColor: AppColor.bgColor4,
      appBar: const CustomAppBar(
        title: "充幣",
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.w),
          child: Column(
            children: [
              Text(
                "${arguments.unit}充幣",
                style: TextStyle(
                  color: AppColor.textColor1,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              addVerticalSpace(16.h),
              Container(
                width: 150.r,
                height: 150.r,
                color: Colors.white,
                child: QrImageView(
                  data: "123",
                  version: QrVersions.auto,
                  size: 150.r,
                ),
              ),
              addVerticalSpace(30.h),
              Text(
                arguments.address,
                style: TextStyle(color: AppColor.textColor1),
              ),
              TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: arguments.address)).then((value) {
                    SmartDialog.showToast("複製成功");
                  });
                },
                child: Text(
                  "複製地址",
                  style: TextStyle(color: AppColor.textColor2),
                ),
              ),
              addVerticalSpace(16.h),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: AppColor.textColor1, fontSize: 13.sp, height: 1.8.h),
                    children: [
                      TextSpan(text: '• 最小充值金额：${arguments.minAmount.toPrecisionString()}${arguments.unit}，小于最小金额的充值将不会上账。\n'),
                      const TextSpan(text: '• 请勿向上述地址充值任何非币种资产，否则资产将不可找回。\n'),
                      const TextSpan(text: '• 您充值至上述地址后，需要整个区块链网络节点的确认，一般区块链主网3次网络确认后到账。\n'),
                      const TextSpan(text: '• 您的充值地址不会经常改变，可以重复充值；如有更改，我们会尽量通过网站公告或邮件通知您。\n'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
