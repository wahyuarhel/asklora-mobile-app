import '../../../core/utils/date_utils.dart';
import 'grouped_model.dart';
import 'transaction_history_model.dart';

class GroupedTransactionModel extends GroupedModel {
  final List<TransactionHistoryModel> data;

  const GroupedTransactionModel(
      {required this.data,
      required GroupType groupType,
      required String groupTitle})
      : super(groupType: groupType, groupTitle: groupTitle);

  String get formattedTransactionHistoryGroupTitle {
    return formatDateTimeAsString(groupTitle, dateFormat: 'dd/MM/yyyy');
  }

  GroupedTransactionModel copyWith({
    List<TransactionHistoryModel>? data,
  }) {
    return GroupedTransactionModel(
      groupType: groupType,
      groupTitle: groupTitle,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props {
    return [groupType, groupTitle, data];
  }
}
