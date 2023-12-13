part of 'routes_cubit.dart';

class RoutesState extends Equatable {
  const RoutesState({
    this.currentPage = "/login",
    this.pageSetState,
    this.locale = "",
    this.isShowBottombar = false,
    this.isShowKeyboard = false,
    this.currentIndex = 0,
  });

  final String currentPage;
  final Function? pageSetState;
  final String locale;
  final bool isShowBottombar;
  final bool isShowKeyboard;
  final int currentIndex;

  RoutesState copyWith({
    String? currentPage,
    Function? pageSetState,
    String? locale,
    bool? isShowBottombar,
    bool? isShowKeyboard,
    int? currentIndex,
  }) {
    return RoutesState(
      currentPage: currentPage ?? this.currentPage,
      pageSetState: pageSetState ?? this.pageSetState,
      locale: locale ?? this.locale,
      isShowBottombar: isShowBottombar ?? this.isShowBottombar,
      isShowKeyboard: isShowKeyboard ?? this.isShowKeyboard,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [
        currentPage,
        pageSetState ?? () {},
        locale,
        isShowBottombar,
        isShowKeyboard,
        currentIndex,
      ];
}
