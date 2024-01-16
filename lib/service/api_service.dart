import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yan_demo_fcm/domain/request/asset_flow_page_request/asset_flow_request.dart';
import 'package:yan_demo_fcm/domain/response/api_response.dart';
import 'package:yan_demo_fcm/domain/response/asset_flow_page_response/asset_flow_response.dart';
import 'package:yan_demo_fcm/domain/response/chat_page_response/history_msg_response.dart';
import 'package:yan_demo_fcm/domain/response/my_advertisement_page_response/otc_advertise_response.dart';
import 'package:yan_demo_fcm/domain/response/public_response/asset_wallet_response.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';

import '../domain/ow_api.dart';
import '../domain/response/asset_flow_page_response/withdraw_coin_response.dart';
import '../domain/response/home_page_response/advertise_response.dart';
import '../domain/response/home_page_response/announcement_response.dart';
import '../domain/response/home_page_response/symbol_response.dart';
import '../domain/response/login_page_response/login_response.dart';
import '../domain/response/member_page_response/promotion_response.dart';
import '../domain/response/member_page_response/security_setting_response.dart';
import '../domain/response/public_response/normal_response.dart';
import '../domain/response/public_response/upload_image_response.dart';
import '../domain/response/public_response/upload_s3_image_response.dart';
import '../driven/service/state_service.dart';
import '../get_it_service_locator.dart';
import '../src/config/app_config.dart';
import '../src/design/model/routes_cubit/routes_cubit.dart';
import 'package:dio/src/headers.dart' as dioheaders;

/// Api 的服務
/// 存放 Fetch Api 方法及 Api 相關函式
/// 調用 Api 時需在後面加上註冊函式 registerComplete
/// code 0 or 1 判斷畫面如何呈現需寫在 bloc 中
class ApiService {
  final Dio dio = Dio();
  bool remoteLock = false;

  initDio() {
    // 請求設定
    dio.options.contentType = dioheaders.Headers.jsonContentType;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.baseUrl = "${AppConfig.scheme}://${AppConfig.domain}";
    // 測試環境繞過證書驗證
    // if (AppConfig.isTestEnv) {
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    //     client.badCertificateCallback = (cert, host, port) {
    //       return true;
    //     };
    //     return null;
    //   };
    // }
    // api 的 AOP
    if (dio.interceptors.isNotEmpty) {
      dio.interceptors.clear();
    }
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (!AppConfig.isVersionNeedUpdate && remoteLock) {
            remoteLock = true; // 鎖住
            // getIt<RemoteConfigService>().onForceFetchedByVersion(); // 不需要更新版本及沒鎖才成立，每次呼叫 api 時檢查最新版本
            Future.delayed(const Duration(seconds: 10), () {
              remoteLock = false; // 十秒後開啟
            });
          }
          String apiPath = options.path.split("?").first;
          String currentView = BlocProvider.of<RoutesCubit>(getIt<StateService>().scaffoldContext).getCurrentPage();
          // 為每個 api 加上狀態
          AppConfig.apiStatusMap[apiPath] = ApiStatusMap(
            CancelToken(),
            currentView,
            ApiStatus.notResponse,
          );
          // options.headers["Accept-Language"] = S.current.locale == "zh_TW" ? "zh_CN" : S.current.locale; // 標頭帶入語系，後端沒有做繁體的
          options.cancelToken = AppConfig.apiStatusMap[apiPath]?.token; // 請求時綁定取消令牌
          return handler.next(options);
        },
        onResponse: (response, handler) {
          String apiPath = response.realUri.path.split("?").first;
          String currentView = BlocProvider.of<RoutesCubit>(getIt<StateService>().scaffoldContext).getCurrentPage();
          AppConfig.apiStatusMap[apiPath]?.status = ApiStatus.hasResponse; // 更新api狀態
          // 返回時若不與請求同一個view則取消請求
          if (AppConfig.apiStatusMap[apiPath]?.view != currentView) {
            AppConfig.apiStatusMap[apiPath]?.token.cancel();
            AppConfig.apiStatusMap.remove(apiPath);
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          AppConfig.apiStatusMap[e.response?.realUri.path.split("?").first]?.status = ApiStatus.error;
          if (e.response?.statusCode == 502) {
            // getIt<RemoteConfigService>().onForceFetchedByMaintain(); // 請求狀態返回 502 代表 api 維護中，嘗試抓取遠端配置取得維護設定
          }
          return handler.next(e);
        },
      ),
    );
  }

  /// 檢查 api 與 view，是否需要關閉 api
  void checkViewAndApi(String view) {
    AppConfig.apiStatusMap.removeWhere((key, value) {
      bool isNotSameView = value.view != view && value.status == ApiStatus.notResponse;
      if (isNotSameView) {
        value.token.cancel();
      }
      return isNotSameView;
    });
  }

  /// 登入
  /// * [request] 登入請求參數
  Future<LoginResponse> login(String username, String password, {Function(HttpResponse<dynamic> res)? replaceFunc}) async {
    final HttpResponse<LoginResponse> response = await OwApi(dio).login(username, password)
      ..registerComplete(replaceFunc: replaceFunc);
    return response.data;
  }

  /// 獲取個人信息
  Future<SecuritySettingResponse> getUserInfo() async {
    final HttpResponse<SecuritySettingResponse> response = await OwApi(dio).getUserInfo(AppConfig.token)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  /// 獲取邀請人數
  Future<PromotionResponse> getMyPromotion() async {
    final HttpResponse<PromotionResponse> response = await OwApi(dio).getMyPromotion(AppConfig.token)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  /// 獲取上傳圖片
  Future<UploadImageResponse> getUploadImg(String fileName) async {
    final HttpResponse<UploadImageResponse> response = await OwApi(dio).getUploadImg(AppConfig.token, fileName)
      ..registerSpecialComplete(showSuccessDialog: false);
    return response.data;
  }

  /// 上傳圖片
  Future<UploadS3ImageResponse> uploadImg(File file) async {
    final HttpResponse<UploadS3ImageResponse> response = await OwApi(dio).uploadImg(AppConfig.token, file)
      ..registerComplete();
    return response.data;
  }

  /// 修改大頭貼
  Future<NormalResponse> changeAvatar(String url) async {
    final HttpResponse<NormalResponse> response = await OwApi(dio).changeAvatar(AppConfig.token, url)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  /// 首頁輪播圖
  Future<AdvertiseResponse> getAdvertise(int sysAdvertiseLocation, String lang) async {
    final HttpResponse<AdvertiseResponse> response = await OwApi(dio).getAdvertise(AppConfig.token, sysAdvertiseLocation, lang)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  /// 首頁公告
  Future<AnnouncementResponse> getAnnouncement(int pageNo, int pageSize, String? lang) async {
    final HttpResponse<AnnouncementResponse> response = await OwApi(dio).getAnnouncement(AppConfig.token, pageNo, pageSize, lang)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  /// 取得發佈廣告
  Future<OtcAdvertiseResponse> getOtcAdvertise(int pageNo, int pageSize) async {
    final HttpResponse<OtcAdvertiseResponse> response = await OwApi(dio).getOtcAdvertise(AppConfig.token, pageNo, pageSize)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  /// 取得資產流水
  Future<AssetFlowResponse> getAsset(AssetFlowRequest request) async {
    final HttpResponse<AssetFlowResponse> response = await OwApi(dio)
        .getAsset(AppConfig.token, request.pageNo, request.pageSize, request.startTime, request.endTime, request.memberId, request.symbol, request.type)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  Future<WithdrawCoinResponse> getWithdrawCoin() async {
    final HttpResponse<WithdrawCoinResponse> response = await OwApi(dio).getWithdrawCoin(AppConfig.token)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  Future<List<SymbolResponse>> getMarketSymbolList() async {
    final HttpResponse<List<SymbolResponse>> response = await OwApi(dio).getMarketSymbolList(AppConfig.token);
    return response.data;
  }

  Future<AssetWalletResponse> getBalance() async {
    final HttpResponse<AssetWalletResponse> response = await OwApi(dio).getBalance(AppConfig.token)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  Future<HistoryMsgResponse> getHistoryMessage(String? orderId,int? Page) async {
    final HttpResponse<HistoryMsgResponse> response = await OwApi(dio).getHistoryMessage(AppConfig.token,orderId,Page);
    return response.data;
  }

  Future<ApiResponse> getInvestedRate() async {
    final HttpResponse<ApiResponse> response = await OwApi(dio).getInvestedRate(AppConfig.token);
    return response.data;
  }

  /// 產生隨機亂數
  String getRandomStr() {
    String randomStr = "";
    for (int i = 0; i < 17; i++) {
      randomStr += i == 0 ? (Random().nextInt(9) + 1).toString() : Random().nextInt(10).toString();
    }
    randomStr += "0";
    return randomStr;
  }
}

enum ApiStatus { notResponse, hasResponse, error }

class ApiStatusMap {
  ApiStatusMap(this.token, this.view, this.status);

  final CancelToken token;
  final String view;
  ApiStatus status;
}
