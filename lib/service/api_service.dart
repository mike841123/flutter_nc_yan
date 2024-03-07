import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yan_demo_fcm/domain/request/asset_flow_page_request/asset_flow_request.dart';
import 'package:yan_demo_fcm/domain/request/money_management_record_page_request/invested_record_request.dart';
import 'package:yan_demo_fcm/domain/request/otc_page_request/otc_trade_request.dart';
import 'package:yan_demo_fcm/domain/request/update_pwd_request/update_pwd_request.dart';
import 'package:yan_demo_fcm/domain/response/api_response.dart';
import 'package:yan_demo_fcm/domain/response/asset_flow_page_response/asset_flow_response.dart';
import 'package:yan_demo_fcm/domain/response/chat_page_response/history_msg_response.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/announcement_details_response.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/details_response.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/help_response.dart';
import 'package:yan_demo_fcm/domain/response/money_management_response/invested_record_response.dart';
import 'package:yan_demo_fcm/domain/response/my_advertisement_page_response/otc_advertise_response.dart';
import 'package:yan_demo_fcm/domain/response/otc_page_response/otc_order_detail_response.dart';
import 'package:yan_demo_fcm/domain/response/public_response/asset_wallet_response.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/service/remote_config_service.dart';

import '../domain/ow_api.dart';
import '../domain/request/otc_page_request/asset_flow_request.dart';
import '../domain/request/otc_page_request/otc_order_request.dart';
import '../domain/response/asset_flow_page_response/withdraw_coin_response.dart';
import '../domain/response/home_page_response/advertise_response.dart';
import '../domain/response/home_page_response/announcement_response.dart';
import '../domain/response/home_page_response/symbol_response.dart';
import '../domain/response/login_page_response/login_response.dart';
import '../domain/response/member_page_response/promotion_response.dart';
import '../domain/response/member_page_response/security_setting_response.dart';
import '../domain/response/otc_page_response/advertise_unit_response.dart';
import '../domain/response/otc_page_response/otc_coin_response.dart';
import '../domain/response/otc_page_response/otc_order_pay_response.dart';
import '../domain/response/otc_page_response/otc_order_pre_response.dart';
import '../domain/response/otc_page_response/otc_order_response.dart';
import '../domain/response/public_response/normal_response.dart';
import '../domain/response/public_response/upload_s3_image_response.dart';
import '../driven/service/state_service.dart';
import '../get_it_service_locator.dart';
import '../src/config/app_config.dart';
import '../src/design/model/routes_cubit/routes_cubit.dart';

/// Api 的服務
/// 存放 Fetch Api 方法及 Api 相關函式
/// 調用 Api 時需在後面加上註冊函式 registerComplete
/// code 0 or 1 判斷畫面如何呈現需寫在 bloc 中
class ApiService {
  final Dio dio = Dio();
  bool remoteLock = false;

  initDio() {
    // 請求設定
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.baseUrl = "${AppConfig.scheme}://${AppConfig.domain}";
    // dio.interceptors.add(PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseBody: true,
    //     responseHeader: false,
    //     error: true,
    //     compact: false,
    //     maxWidth: 200));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (!AppConfig.isVersionNeedUpdate && remoteLock) {
            remoteLock = true; // 鎖住
            getIt<RemoteConfigService>().onForceFetchedByVersion(); // 不需要更新版本及沒鎖才成立，每次呼叫 api 時檢查最新版本
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
          print(currentView);
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
  Future<ApiResponse<String>> getUploadImg(String fileName) async {
    final HttpResponse<ApiResponse<String>> response = await OwApi(dio).getUploadImg(AppConfig.token, fileName)
      ..registerComplete(showSuccessDialog: false);
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

  Future<HistoryMsgResponse> getHistoryMessage(String? orderId, int? Page) async {
    final HttpResponse<HistoryMsgResponse> response = await OwApi(dio).getHistoryMessage(AppConfig.token, orderId, Page);
    return response.data;
  }

  Future<ApiResponse> getInvestedRate() async {
    final HttpResponse<ApiResponse> response = await OwApi(dio).getInvestedRate(AppConfig.token);
    return response.data;
  }

  Future<InvestedRecordResponse> getInvestedRecord(InvestedRecordRequest request) async {
    final HttpResponse<InvestedRecordResponse> response = await OwApi(dio).getInvestedRecord(
        AppConfig.token, request.pageNo, request.pageSize, request.startTime, request.endTime, request.coinUnit, request.optionType, request.status)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  Future<NormalResponse> investedRedeem(int id, int status) async {
    final HttpResponse<NormalResponse> response = await OwApi(dio).investedRedeem(AppConfig.token, id, status)
      ..registerComplete();
    return response.data;
  }

  Future<OtcCoinResponse> getOtcCoin() async {
    final HttpResponse<OtcCoinResponse> response = await OwApi(dio).getOtcCoin(AppConfig.token)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  Future<AdvertiseUnitResponse> getAdvertiseUnit(AdvertiseUnitRequest request) async {
    final HttpResponse<AdvertiseUnitResponse> response =
        await OwApi(dio).getAdvertiseUnit(AppConfig.token, request.pageNo, request.pageSize, request.advertiseType, request.unit)
          ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  Future<OtcOrderPreResponse> getOrderPre(int id) async {
    final HttpResponse<OtcOrderPreResponse> response = await OwApi(dio).getOrderPre(AppConfig.token, id)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  Future<NormalResponse> otcOrderSell(OtcTradeRequest request) async {
    final HttpResponse<NormalResponse> response =
        await OwApi(dio).otcOrderSell(AppConfig.token, request.id, request.coinId, request.price, request.money, request.amount)
          ..registerComplete();
    return response.data;
  }

  Future<NormalResponse> otcOrderBuy(OtcTradeRequest request) async {
    final HttpResponse<NormalResponse> response =
        await OwApi(dio).otcOrderBuy(AppConfig.token, request.id, request.coinId, request.price, request.money, request.amount)
          ..registerComplete();
    return response.data;
  }

  Future<OtcOrderResponse> getOtcOrder(OtcOrderRequest request) async {
    final HttpResponse<OtcOrderResponse> response = await OwApi(dio).getOtcOrder(AppConfig.token, request.status, request.pageNo, request.pageSize)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  Future<OtcOrderDetailResponse> getOctOrderDetail(int orderSn) async {
    final HttpResponse<OtcOrderDetailResponse> response = await OwApi(dio).getOctOrderDetail(AppConfig.token, orderSn)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  Future<NormalResponse> otcOrderCancel(int orderSn) async {
    final HttpResponse<NormalResponse> response = await OwApi(dio).otcOrderCancel(AppConfig.token, orderSn)
      ..registerComplete();
    return response.data;
  }

  Future<OtcOrderPayResponse> otcOrderPay(int orderSn) async {
    final HttpResponse<OtcOrderPayResponse> response = await OwApi(dio).otcOrderPay(AppConfig.token, orderSn)
      ..registerComplete();
    return response.data;
  }

  Future<HelpResponse> getHelp(String lang) async {
    final HttpResponse<HelpResponse> response = await OwApi(dio).getHelp(AppConfig.token, lang)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  Future<DetailsResponse> getDetails(String lang, int id) async {
    final HttpResponse<DetailsResponse> response = await OwApi(dio).getHelpDetails(AppConfig.token, lang, id)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  Future<AnnouncementDetailsResponse> getAnnouncementMore(int id, String lang) async {
    final HttpResponse<AnnouncementDetailsResponse> response = await OwApi(dio).getAnnouncementMore(AppConfig.token, id, lang)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  Future<AssetWalletResponse> getAssetsWallet() async {
    final HttpResponse<AssetWalletResponse> response = await OwApi(dio).getAssetsWallet(AppConfig.token)
      ..registerComplete(showSuccessDialog: false);
    return response.data;
  }

  Future<NormalResponse> getUpdatePwdCode() async {
    final HttpResponse<NormalResponse> response = await OwApi(dio).getUpdatePwdCode(AppConfig.token)
      ..registerComplete();
    return response.data;
  }

  Future<NormalResponse> updatePassword(UpdatePwdRequest request) async {
    final HttpResponse<NormalResponse> response = await OwApi(dio).updatePassword(
      AppConfig.token,
      request.oldPassword,
      request.newPassword,
      request.confirm_newPassword,
      request.code,
    )
      ..registerComplete();
    return response.data;
  }

  Future<ApiResponse<double>> getUsdtCnyRate() async {
    final HttpResponse<ApiResponse<double>> response = await OwApi(dio).getUsdtCnyRate(AppConfig.token)
      ..registerComplete(showSuccessDialog: false);
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
