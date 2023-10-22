part of '../bot_recommendation_screen.dart';

class BotRecommendationCardShimmer extends StatelessWidget {
  final double spacing;
  final double height;
  const BotRecommendationCardShimmer(
      {required this.height, required this.spacing, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: (MediaQuery.of(context).size.width -
              AppValues.screenHorizontalPadding.left -
              AppValues.screenHorizontalPadding.right -
              spacing) /
          2,
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 11),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AskLoraColors.whiteSmoke),
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _shimmer(width: constraints.maxWidth * 0.75, height: 14),
            const SizedBox(
              height: 12,
            ),
            _shimmer(width: constraints.maxWidth, height: 10),
            const SizedBox(
              height: 18,
            ),
            _shimmer(width: constraints.maxWidth * 0.3, height: 10),
            const SizedBox(
              height: 9,
            ),
            _shimmer(width: constraints.maxWidth * 0.25, height: 10),
            const SizedBox(
              height: 17,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 32,
                child: PrimaryButton(
                    disabled: true,
                    buttonPrimarySize: ButtonPrimarySize.small,
                    label: S.of(context).trade,
                    onTap: () {}),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _shimmer({required double width, required double height}) =>
      Shimmer.fromColors(
        baseColor: AskLoraColors.lightGray,
        highlightColor: AskLoraColors.gray,
        child: Container(
          color: AskLoraColors.whiteSmoke,
          height: height,
          width: width,
        ),
      );
}
