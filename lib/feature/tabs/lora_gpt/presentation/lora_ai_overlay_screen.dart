part of 'lora_ai_screen.dart';

class LoraAiOverlayScreen extends StatelessWidget {
  const LoraAiOverlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoraGptBloc, LoraGptState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 40),
            const LoraAnimationGreen(),
            CustomTextNew(
              S.of(context).askloraYouUltimateFinancialAdvisor,
              style: AskLoraTextStyles.h3.copyWith(color: AskLoraColors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            CustomTextNew(S.of(context).askMeAnythingRelatedToFinance,
                style: AskLoraTextStyles.body1
                    .copyWith(color: AskLoraColors.white)),
            Expanded(
                child: Center(
              child: GlowingButton(
                height: 68.0,
                width: 68.0,
                onTap: () {},
                buttonBackgroundColor: const Color(0xFF373A49),
                glowColor: Colors.white.withAlpha(100),
                child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.transparent, width: 0)),
                    child: getSvgIcon('icon_start_ai_chat',
                        color: AskLoraColors.white, fit: BoxFit.none)),
              ),
            ))
          ],
        );
      },
    );
  }
}
