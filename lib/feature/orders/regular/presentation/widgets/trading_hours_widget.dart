part of '../order_screen.dart';

class TradingHoursWidget extends StatelessWidget {
  final bool showOnlyInformation;

  const TradingHoursWidget(
      {this.showOnlyInformation = false,
      Key key = const Key('trading_hours_widget')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
        buildWhen: (previous, current) =>
            previous.tradingHours != current.tradingHours,
        builder: (context, state) => CustomExpandedRow(
              'Trading Hours',
              text: showOnlyInformation ? state.tradingHours.name : '',
              child: showOnlyInformation
                  ? null
                  : Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                          key: const Key('trading_hours_button'),
                          label: Text(state.tradingHours.name),
                          icon: const Icon(Icons.arrow_drop_down),
                          onPressed: () => showModalBottomSheet(
                              context: context,
                              builder: (_) => BlocProvider.value(
                                    value: BlocProvider.of<OrderBloc>(context),
                                    child: BlocBuilder<OrderBloc, OrderState>(
                                      builder: (context, state) =>
                                          OrderBottomSheetWidget(
                                              key: const Key(
                                                  'trading_hours_bottom_sheet'),
                                              title: 'Select Trading Hours',
                                              children: [
                                            CustomBottomSheetCardWidget(
                                                key: const Key(
                                                    'trading_hours_regular_choice'),
                                                keyButton: const Key(
                                                    'trading_hours_regular_choice_button'),
                                                onTap: () => context
                                                    .read<OrderBloc>()
                                                    .add(
                                                        const TradingHoursChanged(
                                                            TradingHours
                                                                .regular)),
                                                label:
                                                    TradingHours.regular.name,
                                                text:
                                                    'Orders will be executed from 09:30 ET - 16:00 ET (normal market hours)',
                                                active: state.tradingHours ==
                                                    TradingHours.regular),
                                            _spaceHeight,
                                            CustomBottomSheetCardWidget(
                                                key: const Key(
                                                    'trading_hours_extended_choice'),
                                                keyButton: const Key(
                                                    'trading_hours_extended_choice_button'),
                                                onTap: () => context
                                                    .read<OrderBloc>()
                                                    .add(
                                                        const TradingHoursChanged(
                                                            TradingHours
                                                                .extended)),
                                                label:
                                                    TradingHours.extended.name,
                                                text:
                                                    'Orders will be executed from 04:00 ET - 20:00 ET',
                                                active: state.tradingHours ==
                                                    TradingHours.extended),
                                            _spaceHeight,
                                            const CustomText(
                                              'Please note that extended trading hours are only available for limit orders',
                                              type: FontType.smallText,
                                              padding:
                                                  EdgeInsets.only(bottom: 16),
                                            ),
                                            const CustomText(
                                              'When trading extended hours, you should  review the Extended Hours Trading Risk Disclosure to make sure you’re familiar with the potential risks',
                                              type: FontType.smallText,
                                              padding:
                                                  EdgeInsets.only(bottom: 16),
                                            ),
                                          ]),
                                    ),
                                  )))),
            ));
  }

  Widget get _spaceHeight => const SizedBox(
        height: 16,
      );
}
