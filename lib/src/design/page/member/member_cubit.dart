import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/response/public_response/upload_image_response.dart';
import 'package:yan_demo_fcm/src/config/app_config.dart';

import '../../../../domain/response/member_page_response/promotion_response.dart';
import '../../../../domain/response/member_page_response/security_setting_response.dart';
import '../../../../domain/response/public_response/upload_s3_image_response.dart';
import '../../../../driven/service/state_service.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';
import '../../model/routes_cubit/routes_cubit.dart';

part 'member_state.dart';

class MemberCubit extends Cubit<MemberState> {
  MemberCubit() : super(const MemberState());

  void init() {
    if (AppConfig.token.isNotEmpty) {
      getSecuritySetting();
      getPromotion();
    }
  }

  /// 獲取個人資料
  void getSecuritySetting() async {
    SecuritySettingResponse response = await getIt<ApiService>().getUserInfo();
    UploadImageResponse uploadImageResponse = await getIt<ApiService>().getUploadImg(response.data?.avatar ?? "");
    emit(state.copyWith(
      securitySettingResponse: response,
      uploadImageResponse: uploadImageResponse,
    ));
  }

  /// 獲取邀請人數
  void getPromotion() async {
    PromotionResponse response = await getIt<ApiService>().getMyPromotion();
    emit(state.copyWith(promotionResponse: response));
  }

  Future<String> uploadImg(File file) async {
    UploadS3ImageResponse response = await getIt<ApiService>().uploadImg(
      file,
    );
    UploadImageResponse uploadImageResponse = await getIt<ApiService>().getUploadImg(response.data?.filename ?? "");
    await getIt<ApiService>().changeAvatar(response.data?.filename ?? "");
    emit(state.copyWith(
      uploadImageResponse: uploadImageResponse,
    ));
    return uploadImageResponse.code == 0 ? uploadImageResponse.data ?? "" : "";
  }

  void gotoPage(String route) {
    BlocProvider.of<RoutesCubit>(getIt<StateService>().scaffoldContext).changePage(route);
  }
}
