import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/feature_flags.dart';

enum DepositType {
  firstTime(minDeposit: FeatureFlags.isProdTestEnabled ? 100 : 10000),
  changeBankAccount(minDeposit: FeatureFlags.isProdTestEnabled ? 100 : 10000),
  type1(minDeposit: 0),
  type2(minDeposit: 0);

  final double minDeposit;

  String get minDepositString => minDeposit.convertToCurrencyDecimal();

  const DepositType({required this.minDeposit});
}

const int maximumProofOfRemittanceImagesAllowed = 3;
