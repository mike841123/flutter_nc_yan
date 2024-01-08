import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:yan_demo_fcm/domain/response/api_response.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/advertise_response.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/announcement_response.dart';
import 'package:yan_demo_fcm/domain/response/login_page_response/login_response.dart';
import 'package:yan_demo_fcm/domain/response/member_page_response/promotion_response.dart';
import 'package:yan_demo_fcm/domain/response/member_page_response/security_setting_response.dart';
import 'package:yan_demo_fcm/domain/response/public_response/normal_response.dart';
import 'package:yan_demo_fcm/domain/response/public_response/upload_image_response.dart';
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
  Future<HttpResponse<UploadImageResponse>> getUploadImg(@Header("X-Auth-Token") String token, @Part() String? fileName,
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
  Future<HttpResponse<AnnouncementResponse>> getAnnouncement(@Header("X-Auth-Token") String token, @Part() int? pageNo, @Part() int? pageSize, @Part() String? lang,
      {@CancelRequest() CancelToken? cancelToken});
}
