part of 'backdoor_screen_bloc.dart';

class BackdoorScreenState extends Equatable {
  final String baseUrl;
  final bool isOtpLoginDisabled;
  const BackdoorScreenState({
    this.baseUrl = '',
    this.isOtpLoginDisabled = true,
  });

  BackdoorScreenState copyWith({
    String? baseUrl,
    bool? isOtpLoginDisabled,
  }) {
    return BackdoorScreenState(
      baseUrl: baseUrl ?? this.baseUrl,
      isOtpLoginDisabled: isOtpLoginDisabled ?? this.isOtpLoginDisabled,
    );
  }

  @override
  List<Object?> get props => [
        baseUrl,
        isOtpLoginDisabled,
      ];
}
