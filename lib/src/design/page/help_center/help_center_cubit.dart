import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/help_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'help_center_state.dart';

class HelpCenterCubit extends Cubit<HelpCenterState> {
  HelpCenterCubit() : super(const HelpCenterState());

  void init() {
    getHelp();
  }

  void getHelp() async {
    emit(state.copyWith(status: HelpCenterStatus.initial));
        HelpResponse response = await getIt<ApiService>().getHelp("CN");
    if (response.code == 0) {
      emit(state.copyWith(status: HelpCenterStatus.success, helpResponse: response));
    }
  }
}
