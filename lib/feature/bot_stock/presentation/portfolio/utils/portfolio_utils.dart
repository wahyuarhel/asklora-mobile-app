import '../../../../../core/utils/currency_enum.dart';
import '../../../../../core/utils/extensions.dart';

enum BotPortfolioPopUpType {
  createAccount,
  investmentStyle,
  kyc,
  redeemBotStock,
  deposit,
  noBotStock,
  pendingReview
}

enum BotPortfolioStatus {
  pending('Pending', 'pending'),
  active('Active', 'active');

  final String name;
  final String value;
  const BotPortfolioStatus(this.name, this.value);

  static BotPortfolioStatus findByString(String botType) =>
      BotPortfolioStatus.values
          .firstWhere((element) => element.value == botType);
}

String formatCurrency(CurrencyType currencyType, double? currency) {
  final value = currency ?? 0;
  return currencyType == CurrencyType.hkd
      ? value.convertToCurrencyDecimal()
      : value.toUsd();
}
