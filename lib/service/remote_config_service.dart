import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_easylogger/flutter_logger.dart';


/// 遠端配置服務
class RemoteConfigService {
  final int timeout = 30; // 請求超時設定三十秒
  final StreamController<dynamic> _fetchingError = StreamController<dynamic>.broadcast();

  Stream<dynamic> get fetchingErrorStream => _fetchingError.stream;
  StreamController<dynamic> get fetchingErrorController => _fetchingError;
  FirebaseRemoteConfig get remoteConfig => FirebaseRemoteConfig.instance;

  /// 設定 fetch 參數在 ios pro max 下，每次 fetch 都需設定才可獲取到配置，實機測試需要先調用 activate 再調用 fetch 才不會出問題
  Future<void> setConfig({int coolDownSec = 0}) async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: timeout), // 請求超時設定三十秒
      minimumFetchInterval: Duration(seconds: coolDownSec), // 默認立即獲取遠端配置
    ));
  }

  /// 渲染前初始化及遠端配置獲取
  Future<FirebaseRemoteConfig> setRemoteConfig({void Function()? init}) async {
    init!();
    fetchingErrorController.stream.listen((event) {
      Logger.d(event); // 監聽各遠端配置獲取錯誤訊息
    });
    await setConfig();
    await remoteConfig.fetchAndActivate(); // 啟用服務獲取遠端配置
    schemeDomainEvent(remoteConfig);
    return remoteConfig;
  }

  /// 協定域名事件
  void schemeDomainEvent(FirebaseRemoteConfig config) {
    print(config.getString("domain")); // 獲取設定 api 應用協定
  }

}
