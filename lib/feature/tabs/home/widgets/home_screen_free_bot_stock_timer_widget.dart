part of '../home_screen_form.dart';

class HomeScreenFreeBotStockTimerWidget extends StatelessWidget {
  const HomeScreenFreeBotStockTimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => HomeScreenHorizontalPaddingWidget(
        child: Column(
          children: [
            LoraPopUpMessage(
              backgroundColor: AskLoraColors.whiteSmoke,
              title: 'Redeem Free Botstock in..',
              pngImage: 'home_clock',
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 58, bottom: 32),
              boxTopMargin: 55,
              spaceAfterTitle: 8,
              titleTextStyle:
                  AskLoraTextStyles.h5.copyWith(color: AskLoraColors.charcoal),
              content: const CountdownTimerWidget(
                timeInSecond: 7776000,
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            ExtraInfoButton(
              label: 'View your free Botstock',
              onTap: () {},
              suffixIcon: const Icon(
                Icons.arrow_forward_rounded,
                color: AskLoraColors.primaryMagenta,
                size: 18,
              ),
            )
          ],
        ),
      );
}

class CountdownTimerWidget extends StatefulWidget {
  final int timeInSecond;

  const CountdownTimerWidget({required this.timeInSecond, Key? key})
      : super(key: key);

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late Timer timer;
  late int timeInSecond;
  late Duration duration;

  @override
  void initState() {
    timeInSecond = widget.timeInSecond;
    duration = Duration(seconds: timeInSecond);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeInSecond--;
      setState(() {
        duration = Duration(seconds: timeInSecond);
      });

      if (timeInSecond == 0) {
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _textColumn(title: duration.inDaysRest, subTitle: 'DAYS'),
        _spaceBetweenText,
        _textColumn(title: duration.inHoursRest, subTitle: 'HR'),
        _spaceBetweenText,
        _textColumn(title: duration.inMinutesRest, subTitle: 'MIN'),
        _spaceBetweenText,
        _textColumn(title: duration.inSecondsRest, subTitle: 'SEC'),
      ],
    );
  }

  Widget _textColumn({required String title, required String subTitle}) =>
      Column(
        children: [
          CustomTextNew(
            title,
            style: AskLoraTextStyles.subtitleLight1,
          ),
          const SizedBox(
            height: 2,
          ),
          CustomTextNew(
            subTitle,
            style: AskLoraTextStyles.subtitleAllCap1,
          ),
        ],
      );

  Widget get _spaceBetweenText => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: CustomTextNew(
          ':',
          style: AskLoraTextStyles.subtitleLight1,
        ),
      );
}
