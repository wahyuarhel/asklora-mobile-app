part of 'source_of_wealth_bloc.dart';

class SourceOfWealthState extends Equatable {
  final List<SourceOfWealthModel> sourceOfWealthAnswers;
  final int totalAmount;
  final String errorMessage;

  const SourceOfWealthState({
    this.sourceOfWealthAnswers = const [],
    this.totalAmount = 0,
    this.errorMessage = '',
  });

  SourceOfWealthState copyWith({
    List<SourceOfWealthModel>? sourceOfWealthAnswers,
    int? totalAmount,
    String? errorMessage,
  }) {
    return SourceOfWealthState(
      sourceOfWealthAnswers:
          sourceOfWealthAnswers ?? this.sourceOfWealthAnswers,
      totalAmount: totalAmount ?? this.totalAmount,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [sourceOfWealthAnswers, totalAmount, errorMessage];

  bool enableNextButton() {
    return sourceOfWealthAnswers.isNotEmpty;
  }

  ({bool result, String errorMessage}) validate() {
    if (sourceOfWealthAnswers.map((e) => e.amount).contains(0)) {
      return (
        result: false,
        errorMessage: 'Please add percentage amount in list that you selected'
      );
    } else if (totalAmount != 100) {
      return (
        result: false,
        errorMessage: 'Your sources of wealth must add up to 100%'
      );
    } else {
      SourceOfWealthModel? a = sourceOfWealthAnswers.firstWhereOrNull(
          (element) => element.sourceOfWealthType == SourceOfWealthType.other);

      if (a != null &&
          (a.additionalSourceOfWealth == null ||
              a.additionalSourceOfWealth!.isEmpty)) {
        return (result: false, errorMessage: 'Please enter more details');
      }
      return (result: true, errorMessage: '');
    }
  }
}
