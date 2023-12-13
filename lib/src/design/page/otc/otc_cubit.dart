
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'otc_state.dart';

class OtcCubit extends Cubit<OtcState> {
  OtcCubit() : super(const OtcState());
}
