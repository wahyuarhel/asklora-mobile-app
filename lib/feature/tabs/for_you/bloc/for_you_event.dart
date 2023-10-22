part of 'for_you_bloc.dart';

abstract class ForYouEvent extends Equatable {
  const ForYouEvent();

  @override
  List<Object> get props => [];
}

class GetInvestmentStyleState extends ForYouEvent {}

class SaveInvestmentStyleState extends ForYouEvent {}
