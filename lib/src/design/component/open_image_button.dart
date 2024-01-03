import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../driven/util/awaiter.dart';
import '../../../driven/util/widget_util.dart';

/// 開啟相簿按鈕
class OpenImageButton extends StatefulWidget {
  const OpenImageButton(
    this.controller, {
    Key? key,
    required this.child,
    this.onImagePickerSuccess,
    this.onImagePickerFail,
    this.showLoading = true,
  }) : super(key: key);

  final TextEditingController controller; // 圖片路徑控制器
  final Widget Function(String path) child; // 開啟相簿按鈕的 body
  final Future<bool> Function(String path)? onImagePickerSuccess; // 開啟相簿成功事件
  final Function()? onImagePickerFail; // 開啟相簿失敗事件
  final bool showLoading; // 上傳圖片按鈕是否顯示讀取中

  @override
  _OpenImageButtonState createState() => _OpenImageButtonState();
}

class _OpenImageButtonState extends State<OpenImageButton> {
  late Future<bool> Function(String path) onImagePickerSuccess;
  late Function() onImagePickerFail;
  bool loading = false; // 是否為載入中

  @override
  void initState() {
    super.initState();
    onImagePickerSuccess = widget.onImagePickerSuccess ??
        (String path) async {
          return true;
        };
    onImagePickerFail = widget.onImagePickerFail ?? () {};
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: transparentButtonStyle(),
      onPressed: () async {
        if (!loading) {
          await openImage(onImagePickerSuccess, onImagePickerFail);
        }
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          widget.child(widget.controller.text),
          Visibility(
            visible: loading && widget.showLoading,
            child: Center(
              child: SizedBox(
                height: 30.r,
                width: 30.r,
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  openImage(Future<bool> Function(String path) successFunc, Function() failFunc) async {
    try {
      ImagePicker imagePicker = ImagePicker();
      // ＊＊＊ 模擬器點選第一張會異常，實機不會有此問題 ＊＊＊
      await imagePicker.pickImage(source: ImageSource.gallery, maxHeight: 1000, maxWidth: 1000, imageQuality: 50).then((value) async {
        if (value != null) {
          setState(() {
            widget.controller.text = value.path;
            loading = true;
          });
          Awaiter.until(() async {
            return await successFunc(widget.controller.text);
          },
              () => setState(() {
                    loading = false;
                  }));
        } else {
          failFunc();
        }
        return value;
      });
    } catch (e) {
      PermissionStatus status = await Permission.photos.status;
      if (status == PermissionStatus.denied) {
        if (!context.mounted) return;
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text("相簿服務未開啟"),
            content: const Text("想要訪問您的照片，為了幫您實現更換頭像或認證等上傳照片的功能"),
            actions: Platform.isIOS
                ? [
                    CupertinoDialogAction(
                      child: Text("取消"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ]
                : [
                    CupertinoDialogAction(
                      child: Text("取消"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text("去設置"),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await openAppSettings();
                      },
                    ),
                  ],
          ),
        );
      }
    }
  }
}
