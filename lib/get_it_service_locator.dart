

import 'package:get_it/get_it.dart';
import 'package:yan_demo_fcm/driven/service/state_service.dart';
import 'package:yan_demo_fcm/service/messaging_service.dart';
import 'package:yan_demo_fcm/service/remote_config_service.dart';


/// 取得 GetIt 的實例
final GetIt getIt = GetIt.instance;

///註冊 Service
Future<void> initializeService() async {
  getIt.registerSingleton(MessagingService());
  getIt.registerSingleton(RemoteConfigService());
  getIt.registerSingleton(StateService());
}
