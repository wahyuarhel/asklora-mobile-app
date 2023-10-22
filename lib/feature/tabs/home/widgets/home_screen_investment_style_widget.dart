part of '../home_screen_form.dart';

class HomeScreenInvestmentStyleWidget extends StatelessWidget {
  final bool showPrimaryButton;
  final bool showAdditionalInfo;

  const HomeScreenInvestmentStyleWidget(
      {this.showPrimaryButton = false,
      this.showAdditionalInfo = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreenHorizontalPaddingWidget(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CustomTextNew(
              'Your Investment Persona',
              style:
                  AskLoraTextStyles.h2.copyWith(color: AskLoraColors.charcoal),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 1.1,
            width: double.infinity,
            child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
              builder: (context, state) {
                Scores value = Scores();
                if (state.response.state == ResponseState.success) {
                  value = state.response.data!.scores;
                }
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 1.2,
                        child: RadarChart(RadarChartData(
                            tickCount: 0,
                            radarBackgroundColor: AskLoraColors.whiteSmoke,
                            titleTextStyle: AskLoraTextStyles.subtitle3,
                            extendedBorderStyle: ExtendedBorderStyle.dash,
                            tickBorderData:
                                const BorderSide(color: Colors.blue, width: 2),
                            radarBorderData: const BorderSide(
                                color: AskLoraColors.primaryGreen, width: 3),
                            gridBorderData: const BorderSide(
                                color: AskLoraColors.gray, width: 1.5),
                            dataSets: [
                              // default highest score
                              RadarDataSet(
                                  entryRadius: 0,
                                  fillColor: Colors.transparent,
                                  borderColor: Colors.transparent,
                                  dataEntries: [
                                    const RadarEntry(value: 15),
                                    const RadarEntry(value: 15),
                                    const RadarEntry(value: 15),
                                  ]),
                              //this is for user score
                              RadarDataSet(
                                  entryRadius: 9,
                                  fillColor: Colors.transparent,
                                  borderColor: AskLoraColors.primaryGreen,
                                  dataEntries: [
                                    RadarEntry(
                                        value: value.extrovert.toDouble()),
                                    RadarEntry(
                                        value: value.openness.toDouble()),
                                    RadarEntry(
                                        value: value.neuroticism.toDouble()),
                                  ])
                            ])),
                      ),
                    ),
                    _radarChartTitle(Alignment.topCenter,
                        'Extroversion ${value.extrovert.toDouble().toString()}'),
                    _radarChartTitle(Alignment.bottomLeft,
                        'Risk aversion ${value.neuroticism.toDouble().toString()}'),
                    _radarChartTitle(Alignment.bottomRight,
                        'Openness ${value.openness.toDouble().toString()}'),
                  ],
                );
              },
            ),
          ),
          if (showAdditionalInfo)
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: CustomTextNew(
                'You’ll get to know your investment style after you’ve created an account!',
                style: AskLoraTextStyles.body1
                    .copyWith(color: AskLoraColors.charcoal),
                textAlign: TextAlign.center,
              ),
            ),
          if (showPrimaryButton)
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: PrimaryButton(
                label: S.of(context).defineInvestmentStyle,
                onTap: () => AiInvestmentStyleQuestionWelcomeScreen.open(
                  context,
                ),
              ),
            ),
          const SizedBox(
            height: 28,
          ),
          ExtraInfoButton(
              label: 'How does Investment Style work?',
              suffixIcon: const Icon(
                Icons.arrow_forward_rounded,
                color: AskLoraColors.primaryMagenta,
                size: 18,
              ),
              onTap: () {})
        ],
      ),
    );
  }

  Widget _radarChartTitle(Alignment alignment, String label) => Align(
        alignment: alignment,
        child: FittedBox(
          child: RoundColoredBox(
            radius: 10,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            content: CustomTextNew(
              label,
              style: AskLoraTextStyles.subtitle2,
            ),
          ),
        ),
      );
}
