part of '../portfolio_screen.dart';

class FreeBotBadge extends StatelessWidget {
  const FreeBotBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AskLoraColors.primaryMagenta,
          borderRadius: BorderRadius.circular(11)),
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.card_giftcard_rounded,
            size: 14,
            color: AskLoraColors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          CustomTextNew(S.of(context).free,
              style: AskLoraTextStyles.subtitleAllCap1
                  .copyWith(color: AskLoraColors.white))
        ],
      ),
    );
  }
}
