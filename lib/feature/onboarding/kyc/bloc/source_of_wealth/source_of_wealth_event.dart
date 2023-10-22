part of 'source_of_wealth_bloc.dart';

abstract class SourceOfWealthEvent extends Equatable {
  const SourceOfWealthEvent();

  @override
  List<Object> get props => [];
}

class SourceOfWealthSelected extends SourceOfWealthEvent {
  final SourceOfWealthType sourceOfWealthType;

  const SourceOfWealthSelected(
    this.sourceOfWealthType,
  ) : super();

  @override
  List<Object> get props => [sourceOfWealthType];
}

class SourceOfWealthAmountChanged extends SourceOfWealthEvent {
  final SourceOfWealthType sourceOfWealthType;
  final String wealthAmount;

  const SourceOfWealthAmountChanged(
    this.wealthAmount,
    this.sourceOfWealthType,
  ) : super();

  @override
  List<Object> get props => [
        wealthAmount,
        sourceOfWealthType,
      ];
}

class SourceOfWealthIncrementAmountChanged extends SourceOfWealthEvent {
  final SourceOfWealthType sourceOfWealthType;

  const SourceOfWealthIncrementAmountChanged(this.sourceOfWealthType) : super();

  @override
  List<Object> get props => [sourceOfWealthType];
}

class SourceOfWealthDecrementAmountChanged extends SourceOfWealthEvent {
  final SourceOfWealthType sourceOfWealthType;

  const SourceOfWealthDecrementAmountChanged(this.sourceOfWealthType) : super();

  @override
  List<Object> get props => [sourceOfWealthType];
}

class SourceOfWealthOtherIncomeChanged extends SourceOfWealthEvent {
  final SourceOfWealthType sourceOfWealthType;
  final String otherIncome;

  const SourceOfWealthOtherIncomeChanged(
    this.sourceOfWealthType,
    this.otherIncome,
  ) : super();

  @override
  List<Object> get props => [
        sourceOfWealthType,
        otherIncome,
      ];
}

class InitiateSourceOfWealth extends SourceOfWealthEvent {
  final List<WealthSourcesRequest>? sourceOfWealthRequest;

  const InitiateSourceOfWealth(this.sourceOfWealthRequest);

  @override
  List<Object> get props => [sourceOfWealthRequest ?? ''];
}
