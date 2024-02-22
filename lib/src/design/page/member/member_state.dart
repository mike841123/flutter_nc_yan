part of 'member_cubit.dart';

class MemberState extends Equatable {
  const MemberState({
    this.securitySettingResponse,
    this.promotionResponse,
    this.uploadImageResponse,
  });

  final SecuritySettingResponse? securitySettingResponse;
  final PromotionResponse? promotionResponse;
  final ApiResponse<String>? uploadImageResponse;

  MemberState copyWith({
    SecuritySettingResponse? securitySettingResponse,
    PromotionResponse? promotionResponse,
    ApiResponse<String>? uploadImageResponse,
  }) {
    return MemberState(
      securitySettingResponse: securitySettingResponse ?? this.securitySettingResponse,
      promotionResponse: promotionResponse ?? this.promotionResponse,
      uploadImageResponse: uploadImageResponse ?? this.uploadImageResponse,
    );
  }

  @override
  List<Object> get props => [
        securitySettingResponse ?? SecuritySettingResponse(),
        promotionResponse ?? PromotionResponse(),
        uploadImageResponse ?? ApiResponse<String>(),
      ];
}
