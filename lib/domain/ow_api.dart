import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:yan_demo_fcm/domain/response/api_response.dart';
import 'package:yan_demo_fcm/domain/response/asset_flow_page_response/asset_flow_response.dart';
import 'package:yan_demo_fcm/domain/response/asset_flow_page_response/withdraw_coin_response.dart';
import 'package:yan_demo_fcm/domain/response/chat_page_response/history_msg_response.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/advertise_response.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/announcement_details_response.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/announcement_response.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/details_response.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/help_response.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/symbol_response.dart';
import 'package:yan_demo_fcm/domain/response/login_page_response/login_response.dart';
import 'package:yan_demo_fcm/domain/response/member_page_response/promotion_response.dart';
import 'package:yan_demo_fcm/domain/response/member_page_response/security_setting_response.dart';
import 'package:yan_demo_fcm/domain/response/money_management_response/invested_record_response.dart';
import 'package:yan_demo_fcm/domain/response/my_advertisement_page_response/otc_advertise_response.dart';
import 'package:yan_demo_fcm/domain/response/otc_page_response/advertise_unit_response.dart';
import 'package:yan_demo_fcm/domain/response/otc_page_response/otc_coin_response.dart';
import 'package:yan_demo_fcm/domain/response/otc_page_response/otc_order_detail_response.dart';
import 'package:yan_demo_fcm/domain/response/otc_page_response/otc_order_pay_response.dart';
import 'package:yan_demo_fcm/domain/response/otc_page_response/otc_order_pre_response.dart';
import 'package:yan_demo_fcm/domain/response/otc_page_response/otc_order_response.dart';
import 'package:yan_demo_fcm/domain/response/public_response/asset_wallet_response.dart';
import 'package:yan_demo_fcm/domain/response/public_response/normal_response.dart';
import 'package:yan_demo_fcm/domain/response/public_response/upload_s3_image_response.dart';

part 'ow_api.g.dart';

@RestApi()
abstract class OwApi {
  factory OwApi(Dio dio) = _OwApi;

  /// 登入
  @POST("/uc/login")
  Future<HttpResponse<LoginResponse>> login(@Part() String? username, @Part() String? password, {@CancelRequest() CancelToken? cancelToken});

  /// 獲取個人信息
  @GET("/uc/approve/security/setting")
  Future<HttpResponse<SecuritySettingResponse>> getUserInfo(@Header("X-Auth-Token") String token, {@CancelRequest() CancelToken? cancelToken});

  /// 獲取邀請人數
  @GET("/uc/promotion/mypromotion")
  Future<HttpResponse<PromotionResponse>> getMyPromotion(@Header("X-Auth-Token") String token, {@CancelRequest() CancelToken? cancelToken});

  /// 獲取上傳圖片
  @POST("/uc/getUploadImg")
  Future<HttpResponse<ApiResponse<String>>> getUploadImg(@Header("X-Auth-Token") String token, @Part() String? fileName,
      {@CancelRequest() CancelToken? cancelToken});

  /// 上傳圖片
  @POST("/uc/upload/oss/image")
  Future<HttpResponse<UploadS3ImageResponse>> uploadImg(@Header("X-Auth-Token") String token, @Part() File file, {@CancelRequest() CancelToken? cancelToken});

  /// 修改大頭貼
  @POST("/uc/approve/change/avatar?url={url}")
  Future<HttpResponse<NormalResponse>> changeAvatar(@Header("X-Auth-Token") String token, @Path() String url, {@CancelRequest() CancelToken? cancelToken});

  /// 首頁輪播圖
  @POST("/uc/ancillary/system/advertise")
  Future<HttpResponse<AdvertiseResponse>> getAdvertise(@Header("X-Auth-Token") String token, @Part() int? sysAdvertiseLocation, @Part() String? lang,
      {@CancelRequest() CancelToken? cancelToken});

  /// 首頁公告
  @POST("/uc/announcement/page")
  Future<HttpResponse<AnnouncementResponse>> getAnnouncement(
      @Header("X-Auth-Token") String token, @Part() int? pageNo, @Part() int? pageSize, @Part() String? lang,
      {@CancelRequest() CancelToken? cancelToken});

  /// 公告詳情
  @POST("/uc/announcement/more")
  Future<HttpResponse<AnnouncementDetailsResponse>> getAnnouncementMore(
      @Header("X-Auth-Token") String token, @Part() int id, @Part() String lang,
      {@CancelRequest() CancelToken? cancelToken});

  /// 取得發佈廣告
  @POST("/otc/advertise/all")
  Future<HttpResponse<OtcAdvertiseResponse>> getOtcAdvertise(@Header("X-Auth-Token") String token, @Part() int? pageNo, @Part() int? pageSize,
      {@CancelRequest() CancelToken? cancelToken});

  /// 取得資產流水
  @POST("/uc/asset/transaction/all")
  Future<HttpResponse<AssetFlowResponse>> getAsset(@Header("X-Auth-Token") String token, @Part() int? pageNo, @Part() int? pageSize, @Part() String? startTime,
      @Part() String? endTime, @Part() int? memberId, @Part() String? symbol, @Part() int? type,
      {@CancelRequest() CancelToken? cancelToken});

  /// 取得提幣幣種資訊
  @POST("/uc/withdraw/support/coin/info")
  Future<HttpResponse<WithdrawCoinResponse>> getWithdrawCoin(@Header("X-Auth-Token") String token, {@CancelRequest() CancelToken? cancelToken});

  /// 取得所有幣漲幅
  @POST("/market/symbol-thumb-trend")
  Future<HttpResponse<List<SymbolResponse>>> getMarketSymbolList(@Header("X-Auth-Token") String token, {@CancelRequest() CancelToken? cancelToken});

  /// 取得所有資產
  @POST("/uc/asset/wallet")
  Future<HttpResponse<AssetWalletResponse>> getBalance(@Header("X-Auth-Token") String token, {@CancelRequest() CancelToken? cancelToken});

  /// 取得所有資產
  @POST("/chat/getHistoryMessage")
  Future<HttpResponse<HistoryMsgResponse>> getHistoryMessage(@Header("X-Auth-Token") String token, @Part() String? orderId, @Part() int? Page,
      {@CancelRequest() CancelToken? cancelToken});

  @GET("/uc/invested/getRate")
  Future<HttpResponse<ApiResponse>> getInvestedRate(@Header("X-Auth-Token") String token, {@CancelRequest() CancelToken? cancelToken});

  @GET("/uc/invested/getRecordPage?pageNo={pageNo}&pageSize={pageSize}{startTime}{endTime}{coinUnit}{optionType}{status}")
  Future<HttpResponse<InvestedRecordResponse>> getInvestedRecord(@Header("X-Auth-Token") String token, @Path() int? pageNo, @Path() int? pageSize,
      @Path() String? startTime, @Path() String? endTime, @Path() String? coinUnit, @Path() String? optionType, @Path() String? status,
      {@CancelRequest() CancelToken? cancelToken});

  /// 贖回
  @POST("/uc/invested/redeem/{id}")
  Future<HttpResponse<NormalResponse>> investedRedeem(@Header("X-Auth-Token") String token, @Path() int? id, @Part() int? status,
      {@CancelRequest() CancelToken? cancelToken});

  @POST("/otc/coin/all")
  Future<HttpResponse<OtcCoinResponse>> getOtcCoin(@Header("X-Auth-Token") String token, {@CancelRequest() CancelToken? cancelToken});

  @POST("/otc/advertise/page-by-unit")
  Future<HttpResponse<AdvertiseUnitResponse>> getAdvertiseUnit(
      @Header("X-Auth-Token") String token, @Part() int? pageNo, @Part() int? pageSize, @Part() int? advertiseType, @Part() String? unit,
      {@CancelRequest() CancelToken? cancelToken});

  @POST("/otc/order/pre")
  Future<HttpResponse<OtcOrderPreResponse>> getOrderPre(@Header("X-Auth-Token") String token, @Part() int id, {@CancelRequest() CancelToken? cancelToken});

  @POST("/otc/order/sell")
  Future<HttpResponse<NormalResponse>> otcOrderSell(
      @Header("X-Auth-Token") String token, @Part() int id, @Part() int coinId, @Part() double price, @Part() double money, @Part() double amount,
      {@CancelRequest() CancelToken? cancelToken});

  @POST("/otc/order/buy")
  Future<HttpResponse<NormalResponse>> otcOrderBuy(
      @Header("X-Auth-Token") String token, @Part() int id, @Part() int coinId, @Part() double price, @Part() double money, @Part() double amount,
      {@CancelRequest() CancelToken? cancelToken});

  @POST("/otc/order/self")
  Future<HttpResponse<OtcOrderResponse>> getOtcOrder(@Header("X-Auth-Token") String token, @Part() int status, @Part() int pageNo, @Part() int pageSize,
      {@CancelRequest() CancelToken? cancelToken});

  @POST("/otc/order/detail")
  Future<HttpResponse<OtcOrderDetailResponse>> getOctOrderDetail(@Header("X-Auth-Token") String token, @Part() int orderSn,
      {@CancelRequest() CancelToken? cancelToken});

  @POST("/otc/order/cancel")
  Future<HttpResponse<NormalResponse>> otcOrderCancel(@Header("X-Auth-Token") String token, @Part() int orderSn, {@CancelRequest() CancelToken? cancelToken});

  @POST("/otc/order/pay")
  Future<HttpResponse<OtcOrderPayResponse>> otcOrderPay(@Header("X-Auth-Token") String token, @Part() int orderSn, {@CancelRequest() CancelToken? cancelToken});

  @POST("/uc/ancillary/more/help")
  Future<HttpResponse<HelpResponse>> getHelp(@Header("X-Auth-Token") String token, @Part() String? lang, {@CancelRequest() CancelToken? cancelToken});

  @POST("/uc/ancillary/more/help/detail")
  Future<HttpResponse<DetailsResponse>> getHelpDetails(@Header("X-Auth-Token") String token, @Part() String? lang, @Part() int id,
      {@CancelRequest() CancelToken? cancelToken});
}
