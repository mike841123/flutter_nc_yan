
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/response/my_advertisement_page_response/otc_advertise_response.dart';


part 'otc_state.dart';

class OtcCubit extends Cubit<OtcState> {
  OtcCubit() : super(const OtcState());

  void init() {
    print("1212131313");
  }



}
