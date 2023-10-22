part of 'bot_transaction_history_detail_bloc.dart';

class BotTransactionHistoryDetailState extends Equatable {
  const BotTransactionHistoryDetailState(
      {this.response = const BaseResponse(), this.activities = const []});

  final BaseResponse<BotDetailTransactionHistoryResponse> response;
  final List<GroupedActivitiesModel> activities;

  @override
  List<Object?> get props {
    return [response, activities];
  }

  BotTransactionHistoryDetailState copyWith({
    BaseResponse<BotDetailTransactionHistoryResponse>? response,
    List<GroupedActivitiesModel>? activities,
  }) {
    return BotTransactionHistoryDetailState(
      response: response ?? this.response,
      activities: activities ?? this.activities,
    );
  }
}
