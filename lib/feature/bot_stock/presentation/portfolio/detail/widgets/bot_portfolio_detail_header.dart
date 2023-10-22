part of '../bot_portfolio_detail_screen.dart';

class BotPortfolioDetailHeader extends StatelessWidget {
  final BotStatus? botStatus;
  final String title;

  const BotPortfolioDetailHeader(
      {required this.title, this.botStatus, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1.2),
            child: Icon(
              Icons.circle,
              color: botStatus != null ? botStatus!.color : Colors.transparent,
              size: 12,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          CustomTextNew(
            title,
            style: AskLoraTextStyles.h5.copyWith(color: AskLoraColors.charcoal),
          ),
        ],
      ),
    );
  }
}
