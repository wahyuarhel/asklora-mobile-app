import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/domain/base_response.dart';
import '../../../../../../core/utils/date_utils.dart';
import '../../../domain/grouped_model.dart';
import '../../../../../core/repository/transaction_repository.dart';
import '../domain/bot_activities_transaction_history_model.dart';
import '../domain/bot_detail_transaction_history_response.dart';
import '../domain/grouped_activities_model.dart';

part 'bot_transaction_history_detail_event.dart';

part 'bot_transaction_history_detail_state.dart';

class BotTransactionHistoryDetailBloc extends Bloc<
    BotTransactionHistoryDetailEvent, BotTransactionHistoryDetailState> {
  BotTransactionHistoryDetailBloc(
      {required TransactionRepository transactionHistoryRepository})
      : _transactionHistoryRepository = transactionHistoryRepository,
        super(const BotTransactionHistoryDetailState()) {
    on<FetchBotTransactionDetail>(_onFetchBotTransactionDetail);
  }

  final TransactionRepository _transactionHistoryRepository;

  _onFetchBotTransactionDetail(FetchBotTransactionDetail event,
      Emitter<BotTransactionHistoryDetailState> emit) async {
    emit(state.copyWith(response: BaseResponse.loading()));
    var botTransactionDetail = await _transactionHistoryRepository
        .fetchBotTransactionsDetail(event.orderId);
    emit(state.copyWith(
        response: botTransactionDetail,
        activities: groupedActivitiesModels(
            botTransactionDetail.data?.activities ?? [])));
  }

  List<GroupedActivitiesModel> groupedActivitiesModels(
      List<BotActivitiesTransactionHistoryModel> activities) {
    List<GroupedActivitiesModel> groupedActivities = [];
    DateTime dateTimeNow = DateTime.now();
    DateTime dateNow =
        DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day);
    for (var element in activities) {
      DateTime createdAt = element.filledAtHKTDateTime;
      if (createdAt.compareTo(dateNow) == 0) {
        int groupIndex = groupedActivities
            .indexWhere((element) => element.groupType == GroupType.today);
        if (groupIndex >= 0) {
          ///ADD EXISTING GROUP TODAY
          groupedActivities[groupIndex] = groupedActivities[groupIndex]
              .copyWith(
                  data: List.from(groupedActivities[groupIndex].data)
                    ..add(element));
        } else {
          ///CREATE NEW GROUP TODAY
          groupedActivities.add(GroupedActivitiesModel(
              groupType: GroupType.today, groupTitle: '', data: [element]));
        }
      } else {
        ///CREATE OTHER GROUP EACH DATE
        String createdAtFormatted = formatDateTimeAsString(createdAt);
        int groupIndex = groupedActivities
            .indexWhere((element) => element.groupTitle == createdAtFormatted);
        if (groupIndex >= 0) {
          ///ADD EXISTING GROUP
          groupedActivities[groupIndex] = groupedActivities[groupIndex]
              .copyWith(
                  data: List.from(groupedActivities[groupIndex].data)
                    ..add(element));
        } else {
          ///CREATE NEW GROUP
          groupedActivities.add(GroupedActivitiesModel(
              groupType: GroupType.others,
              groupTitle: createdAtFormatted,
              data: [element]));
        }
      }
    }
    return groupedActivities;
  }
}
