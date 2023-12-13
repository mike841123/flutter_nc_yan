import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../src/config/app_config.dart';
import '../../src/design/model/routes_cubit/routes_cubit.dart';

/// page 頁都需繼承此類
abstract class CurrentPageState<T extends StatefulWidget> extends State<T> with RouteAware, WidgetsBindingObserver {
  GlobalKey blocProviderKey = GlobalKey(); // BlocBuilder 的 key，返回時從 key 拿上下文

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RoutesCubit>(context).setPageState(setState);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppConfig.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    AppConfig.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    BlocProvider.of<RoutesCubit>(context).updateCurrentRoutes(ModalRoute.of(context)?.settings.name); //push 後路由名
  }

  @override
  void didPopNext() {
    BlocProvider.of<RoutesCubit>(context).setPageState(setState); // 返回時不會再呼叫 initState，所以須在這做一次存入動作
    BlocProvider.of<RoutesCubit>(context).updateCurrentRoutes(ModalRoute.of(context)?.settings.name); //pop 後路由名
  }
}
