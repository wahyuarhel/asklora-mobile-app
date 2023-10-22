import 'package:flutter/cupertino.dart';

import '../../../core/styles/asklora_colors.dart';
import '../../../generated/l10n.dart';

enum TransferType {
  deposit('DEPOSIT', 'Deposit', AskLoraColors.primaryGreen, '+'),
  withdraw('WITHDRAW', 'Withdrawal', AskLoraColors.primaryMagenta, '-');

  final String value;
  final String title;
  final Color color;
  final String punctuation;

  static TransferType findByString(String transferTypeString) {
    TransferType transferType = TransferType.values
        .firstWhere((element) => element.value == transferTypeString);
    return transferType;
  }

  static TransferType findByTitle(String transferTypeString) {
    TransferType transferType = TransferType.values
        .firstWhere((element) => element.title == transferTypeString);
    return transferType;
  }

  String text(BuildContext context) {
    switch (this) {
      case TransferType.deposit:
        return S.of(context).deposit;
      case TransferType.withdraw:
        return S.of(context).withdraw;
    }
  }

  String titleText(BuildContext context) {
    switch (this) {
      case TransferType.deposit:
        return S.of(context).depositHistory;
      case TransferType.withdraw:
        return S.of(context).withdrawalHistory;
    }
  }

  const TransferType(this.value, this.title, this.color, this.punctuation);
}

enum BotSummaryType {
  setActive('set_active'),
  makeLive('make_live'),
  makeCancel('make_cancel'),
  loss('loss'),
  expired('expired'),
  rejectedOms('rejected_oms'),
  profit('profit'),
  terminated('terminated');

  final String value;

  static BotSummaryType findByString(String botSummaryTypeString) {
    BotSummaryType botSummaryType = BotSummaryType.values
        .firstWhere((element) => element.value == botSummaryTypeString);
    return botSummaryType;
  }

  const BotSummaryType(this.value);
}

String getNameByBotSummaryType(
    BuildContext context, BotSummaryType botSummaryType) {
  switch (botSummaryType) {
    case BotSummaryType.setActive:
      return S.of(context).orderPlaced;
    case BotSummaryType.makeLive:
      return S.of(context).orderStarted;
    case BotSummaryType.makeCancel:
      return S.of(context).orderCancelled;
    case BotSummaryType.rejectedOms:
      return S.of(context).orderRejected;
    default:
      return S.of(context).orderExpired;
  }
}

enum TransferStatus {
  pending('pending', 'Pending', AskLoraColors.primaryMagenta),
  active('success', 'Completed', AskLoraColors.primaryGreen),
  rejected('rejected', 'Rejected', AskLoraColors.primaryMagenta);

  final String value;
  final String name;
  final Color color;

  static TransferStatus find(String transferStatusString,
      {String? timeRejected, bool? isRefunded}) {
    if (timeRejected != null &&
        timeRejected.isNotEmpty &&
        isRefunded != null &&
        isRefunded == true) {
      return TransferStatus.rejected;
    } else {
      return TransferStatus.values
          .firstWhere((element) => element.value == transferStatusString);
    }
  }

  static TransferStatus findByString(String transferStatusString) {
    return TransferStatus.values
        .firstWhere((element) => element.name == transferStatusString);
  }

  String text(BuildContext context) {
    switch (this) {
      case TransferStatus.pending:
        return S.of(context).pending;
      case TransferStatus.active:
        return S.of(context).completed;
      case TransferStatus.rejected:
        return S.of(context).rejected;
      default:
        return '';
    }
  }

  const TransferStatus(this.value, this.name, this.color);
}

int compareDateTimeDesc(DateTime? a, DateTime? b) {
  if (a != null && b != null) {
    return b.compareTo(a);
  } else {
    return 1;
  }
}
