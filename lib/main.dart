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
import 'package:yan_demo_fcm/src/design/model/routes_cubit/routes_cubit.dart';
import 'package:yan_demo_fcm/src/design/model/socket_cubit/socket_cubit.dart';
import 'package:yan_demo_fcm/src/design/model/user_cubit/user_cubit.dart';
import 'package:yan_demo_fcm/src/design/page/home/home_page.dart';
import 'package:yan_demo_fcm/src/design/page/login/login_page.dart';
import 'driven/service/state_service.dart';
import 'driven/util/custom_class.dart';
import 'driven/util/widget_util.dart';
import 'firebase_options.dart';
import 'get_it_service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
      getIt<MessagingService>().initFCM(); // 初始化 firebase cloud messaging
      FlutterNativeSplash.remove(); // 所有初始化完成後刪除第一幀
      AppConfig.runAppAfterSetup = true;
    }
  }

  /// 主畫面
  Widget getPageView(BuildContext context, Widget widget) {
    return widget;
  }

  /// 導航欄組件
  Widget getBottomBar(BuildContext context) {
    List<BarItem> items = [
      BarItem(assetName: "assets/images/img_home.svg", label: "首頁"),
      BarItem(assetName: "assets/images/img_home.svg", label: "行情"),
      BarItem(assetName: "assets/images/img_home.svg", label: "交易"),
      BarItem(assetName: "assets/images/img_home.svg", label: "法幣"),
      BarItem(assetName: "assets/images/img_home.svg", label: "我的"),
    ];
    return BlocBuilder<RoutesCubit, RoutesState>(
      buildWhen: (previous, current) => previous.currentPage != current.currentPage || previous.currentIndex != current.currentIndex,
      builder: (context, state) {
        List<BottomNavigationBarItem> finalItems = [];
        for (int i = 0; i < items.length; i++) {
          finalItems.add(BottomNavigationBarItem(
            icon: SvgPicture.asset(
              items[i].assetName,
              color: state.currentIndex == i ? AppColor.color7 : AppColor.color8,
              fit: BoxFit.fill,
            ),
            label: items[i].label,
          ));
        }
        return state.currentPage == Routes.login || !state.isShowBottombar // 登入頁不顯示導航欄及非根目錄不顯示導航欄
            ? empty()
            : BottomNavigationBar(
                items: finalItems,
                currentIndex: state.currentIndex,
                iconSize: 30.r,
                selectedFontSize: 14.sp,
                unselectedFontSize: 14.sp,
                selectedItemColor: AppColor.color7,
                unselectedItemColor: AppColor.color8,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  if (state.currentIndex != index) {
                    switch (index) {
                      case 0:
                        BlocProvider.of<RoutesCubit>(context).changePage(Routes.home);
                        break;
                      case 1:
                        BlocProvider.of<RoutesCubit>(context).changePage(Routes.market);
                        break;
                      case 2:
                        BlocProvider.of<RoutesCubit>(context).changePage(Routes.transaction);
                        break;
                      case 3:
                        BlocProvider.of<RoutesCubit>(context).changePage(Routes.otc);
                        break;
                      case 4:
                        BlocProvider.of<RoutesCubit>(context).changePage(Routes.member);
                        break;
                    }
                  }
                },
              );
      },
    );
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
                  return MultiBlocProvider(
                    providers: [
                      /// 此處通過 BlocProvider 創建全局的 Cubit
                      BlocProvider<RoutesCubit>(create: (BuildContext context) => RoutesCubit(currentPage: Routes.home)),
                      BlocProvider<SocketCubit>(create: (BuildContext context) => SocketCubit()),
                      BlocProvider<UserCubit>(create: (BuildContext context) => UserCubit()),
                      // BlocProvider<DialogCubit>(create: (BuildContext context) => DialogCubit()),
                    ],
                    child: GestureDetector(
                      onTap: () {
                        hideKeyboard(context);
                      },
                      child: Scaffold(
                        key: getIt<StateService>().scaffoldKey,
                        resizeToAvoidBottomInset: true,
                        backgroundColor: Color(0xff000000),
                        body: Stack(
                          children: [
                            getPageView(context, widget!), // 畫面
                          ],
                        ),
                      ),
                    ),
                  );
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
