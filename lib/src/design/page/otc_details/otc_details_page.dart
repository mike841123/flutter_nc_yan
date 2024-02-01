import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yan_demo_fcm/domain/request/otc_page_request/otc_trade_request.dart';
import 'package:yan_demo_fcm/driven/util/custom_class.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';
import 'package:yan_demo_fcm/src/design/page/otc_list/otc_list_cubit.dart';
import '../../../../domain/response/otc_page_response/otc_order_pre_response.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../component/custom_text_field.dart';
import 'otc_details_cubit.dart';

class OtcDetailsPage extends StatefulWidget {
  const OtcDetailsPage({super.key});

  @override
  CurrentPageState<OtcDetailsPage> createState() => _OtcDetailsPageState();
}

class _OtcDetailsPageState extends CurrentPageState<OtcDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtcListCubit, OtcListState>(
      buildWhen: (previous, current) => previous.otcOrderPreResponse != current.otcOrderPreResponse,
      builder: (context, state) {
        OtcOrderPreResult result = state.otcOrderPreResponse?.data ?? OtcOrderPreResult();
        return Container();
      },
    );
  }
}
