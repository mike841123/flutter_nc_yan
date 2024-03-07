import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yan_demo_fcm/service/messaging_service.dart';
import 'package:yan_demo_fcm/service/remote_config_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:yan_demo_fcm/src/config/app_color.dart';
import 'package:yan_demo_fcm/src/config/app_config.dart';
import 'package:yan_demo_fcm/src/config/routes.dart';
import 'package:yan_demo_fcm/src/design/model/market_cubit/market_cubit.dart';
import 'package:yan_demo_fcm/src/design/model/routes_cubit/routes_cubit.dart';
import 'package:yan_demo_fcm/src/design/model/socket_cubit/socket_cubit.dart';
import 'package:yan_demo_fcm/src/design/model/timer_cubit/timer_cubit.dart';
import 'package:yan_demo_fcm/src/design/model/user_cubit/user_cubit.dart';
import 'package:yan_demo_fcm/src/design/page/home/home_page.dart';
import 'package:yan_demo_fcm/src/design/page/login/login_page.dart';
import 'driven/service/state_service.dart';
import 'firebase_options.dart';
import 'get_it_service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized(); // 需確保與 firebase 綁定時已初始化 WidgetsBinding
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding); // 為了第一幀繪製完成不被移除將，widgetsBinding 委派給 Splash 套件的函式
  await initializeService(); // 初始化 getIt 並實例服務
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppConfig.sharedPreferences = await SharedPreferences.getInstance(); // 初始化共存器並指到靜態變數
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  Logger.i("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void runAppAfterInit() {
    if (!AppConfig.runAppAfterSetup) {
      AppColor(ThemeStyle.dark); // 決定主題配色
      getIt<MessagingService>().initFCM(); // 初始化 firebase cloud messaging
      FlutterNativeSplash.remove(); // 所有初始化完成後刪除第一幀
      AppConfig.runAppAfterSetup = true;
    }
  }

  /// 主畫面
  Widget getPageView(BuildContext context, Widget widget) {
    return widget;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseRemoteConfig>(
      future: getIt<RemoteConfigService>().setRemoteConfig(init: runAppAfterInit),
      builder: (BuildContext context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
        return ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            builder: (BuildContext context, Widget? widget) {
              return MaterialApp(
                navigatorKey: getIt<StateService>().navigatorKey,
                debugShowCheckedModeBanner: false,
                title: "ncex",
                theme: ThemeData(
                  primarySwatch: Colors.grey,
                  fontFamily: 'Inter',
                ),
                builder: FlutterSmartDialog.init(builder: (BuildContext context, Widget? widget) {
                  if (snapshot.hasData) {
                    return MultiBlocProvider(
                      providers: [
                        /// 此處通過 BlocProvider 創建全局的 Cubit
                        BlocProvider<RoutesCubit>(create: (BuildContext context) => RoutesCubit(currentPage: Routes.home)),
                        BlocProvider<SocketCubit>(create: (BuildContext context) => SocketCubit()),
                        BlocProvider<UserCubit>(create: (BuildContext context) => UserCubit()),
                        BlocProvider<TimerCubit>(create: (BuildContext context) => TimerCubit()),
                        BlocProvider<MarketCubit>(create: (BuildContext context) => MarketCubit()),
                      ],
                      child: GestureDetector(
                        onTap: () {
                          hideKeyboard(context);
                        },
                        child: Scaffold(
                          key: getIt<StateService>().scaffoldKey,
                          resizeToAvoidBottomInset: true,
                          backgroundColor: AppColor.bgColor4,
                          body: Stack(
                            children: [
                              getPageView(context, widget!), // 畫面
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(color: Colors.black);
                  }
                }),
                routes: Routes.pages,
                initialRoute: AppConfig.token.isEmpty ? Routes.login : Routes.home,
                onUnknownRoute: (RouteSettings setting) {
                  Logger.e("onUnknownRoute ${setting.name}"); // 訪問路由表不存在路由時，若存在token，導回首頁，否則導回登入頁
                  return MaterialPageRoute<void>(
                    settings: RouteSettings(name: AppConfig.token.isEmpty ? Routes.login : Routes.home),
                    builder: (BuildContext context) => AppConfig.token.isEmpty ? const LoginPage() : const HomePage(),
                  );
                },
                navigatorObservers: [AppConfig.routeObserver],
              );
            });
      },
    );
  }

  /// 全域關閉鍵盤邏輯
  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
