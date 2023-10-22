import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/repository/transaction_repository.dart';
import '../../bloc/bot_stock_bloc.dart';
import '../../repository/bot_stock_repository.dart';
import 'bot_recommendation_screen.dart';

class FreeBotRecommendationScreen extends StatelessWidget {
  static const String route = '/gift_bot_stock_recommendation_screen';
  final bool enableBackNavigation;

  const FreeBotRecommendationScreen(
      {this.enableBackNavigation = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => BotStockBloc(
            botStockRepository: BotStockRepository(),
            transactionRepository: TransactionRepository())
          ..add(FetchFreeBotRecommendation()),
        child: const BotRecommendationScreen(),
      );

  static void open(BuildContext context) => Navigator.pushNamed(
        context,
        route,
      );

  static void openAndRemoveUntil(BuildContext context, String removeUntil) =>
      Navigator.of(context)
          .pushNamedAndRemoveUntil(route, ModalRoute.withName(removeUntil));
}
