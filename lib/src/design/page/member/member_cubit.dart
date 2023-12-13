
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'member_state.dart';

class MemberCubit extends Cubit<MemberState> {
  MemberCubit() : super(const MemberState());
}
