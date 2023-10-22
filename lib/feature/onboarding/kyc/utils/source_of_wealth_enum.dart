import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

enum SourceOfWealthType {
  incomeFromEmployment('Income from Employment', 'INCOME'),
  inheritance('Inheritance / Gift', 'INHERITANCE'),
  interestOrDividendIncome('Interest / Dividend Income', 'INTEREST'),
  marketTradingProfits('Market Trading Profits', 'MARKETPROFIT'),
  disability('Disability / Severance / Unemployment', 'DISABILITY'),
  pension('Pension / Government Retirement benefit', 'PENSION'),
  property('Property', 'PROPERTY'),
  allowanceOrSpousalIncome('Allowance / Spousal Income', 'ALLOWANCE'),
  other('Other', 'OTHER');

  final String name;
  final String value;

  const SourceOfWealthType(this.name, this.value);

  static SourceOfWealthType? findByStringValue(
          String sourceOfWealthTypeValue) =>
      SourceOfWealthType.values.firstWhereOrNull(
          (element) => element.value == sourceOfWealthTypeValue);
}

class SourceOfWealthModel extends Equatable {
  final SourceOfWealthType sourceOfWealthType;
  final int amount;
  final String? additionalSourceOfWealth;
  final bool isActive;

  const SourceOfWealthModel({
    required this.sourceOfWealthType,
    this.amount = 0,
    this.additionalSourceOfWealth,
    this.isActive = false,
  });

  SourceOfWealthModel copyWith({
    SourceOfWealthType? sourceOfWealthType,
    int? amount,
    String? additionalSourceOfWealth,
    bool? isActive,
  }) {
    return SourceOfWealthModel(
      sourceOfWealthType: sourceOfWealthType ?? this.sourceOfWealthType,
      amount: amount ?? this.amount,
      additionalSourceOfWealth:
          additionalSourceOfWealth ?? this.additionalSourceOfWealth,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props =>
      [sourceOfWealthType, amount, additionalSourceOfWealth, isActive];
}
