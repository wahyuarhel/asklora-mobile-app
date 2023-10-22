part of '../order_screen.dart';

class TrailTypeWidget extends StatelessWidget {
  final bool showOnlyInformation;

  const TrailTypeWidget(
      {this.showOnlyInformation = false, Key key = const Key('trail_widget')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
        buildWhen: (previous, current) =>
            previous.trailType != current.trailType,
        builder: (context, state) => Column(
              children: [
                if (!showOnlyInformation)
                  CustomExpandedRow(
                    'Trail Type',
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                            key: const Key('trail_type_button'),
                            label: Text(state.trailType.name),
                            icon: const Icon(Icons.arrow_drop_down),
                            onPressed: () => showModalBottomSheet(
                                context: context,
                                builder: (_) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                          value: BlocProvider.of<OrderBloc>(
                                              context),
                                        ),
                                        BlocProvider.value(
                                          value: BlocProvider.of<
                                              TrailingOrderBloc>(context),
                                        ),
                                      ],
                                      child: BlocBuilder<OrderBloc, OrderState>(
                                        builder: (context, state) =>
                                            OrderBottomSheetWidget(
                                                key: const Key(
                                                    'trail_type_bottom_sheet'),
                                                title: 'Select Trail Type',
                                                children: [
                                              CustomBottomSheetCardWidget(
                                                  key: const Key(
                                                      'trail_type_amount_choice'),
                                                  keyButton: const Key(
                                                      'trail_type_amount_choice_button'),
                                                  onTap: () {
                                                    context.read<OrderBloc>().add(
                                                        const TrailTypeChanged(
                                                            TrailType.amount));
                                                    context
                                                        .read<
                                                            TrailingOrderBloc>()
                                                        .add(
                                                            const ResetTrailingOrderValue());
                                                  },
                                                  label: TrailType.amount.name,
                                                  text:
                                                      'Trail an amount that is below the current price of the stock',
                                                  active: state.trailType ==
                                                      TrailType.amount),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              CustomBottomSheetCardWidget(
                                                  key: const Key(
                                                      'trail_type_percentage_choice'),
                                                  keyButton: const Key(
                                                      'trail_type_percentage_choice_button'),
                                                  onTap: () {
                                                    context.read<OrderBloc>().add(
                                                        const TrailTypeChanged(
                                                            TrailType
                                                                .percentage));
                                                    context
                                                        .read<
                                                            TrailingOrderBloc>()
                                                        .add(
                                                            const ResetTrailingOrderValue());
                                                  },
                                                  label:
                                                      TrailType.percentage.name,
                                                  text:
                                                      'Trail a percentage that is below the current price of the stock',
                                                  active: state.trailType ==
                                                      TrailType.percentage)
                                            ]),
                                      ),
                                    )))),
                  ),
                state.trailType == TrailType.amount
                    ? CustomExpandedRow(
                        'Trail Amount',
                        text: r'$15',
                        child: showOnlyInformation
                            ? null
                            : CustomTextInput(
                                key: const Key('trail_amount_input'),
                                prefixText: r'$',
                                textInputType: TextInputType.number,
                                textInputFormatterList: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                labelText: 'Amount',
                                hintText: '0',
                                onChanged: (value) {
                                  context.read<TrailingOrderBloc>().add(
                                        TrailingAmountChanged(
                                          value.isNotEmpty
                                              ? double.parse(value)
                                              : 0,
                                        ),
                                      );
                                },
                              ),
                      )
                    : CustomExpandedRow(
                        'Trail Percentage',
                        text: '10%',
                        child: showOnlyInformation
                            ? null
                            : CustomTextInput(
                                key: const Key('trail_percentage_input'),
                                suffixText: '%',
                                textInputType: TextInputType.number,
                                textInputFormatterList: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                labelText: 'Percentage',
                                hintText: '0',
                                onChanged: (value) {
                                  context.read<TrailingOrderBloc>().add(
                                        TrailingPercentageChanged(
                                          value.isNotEmpty
                                              ? double.parse(value)
                                              : 0,
                                        ),
                                      );
                                },
                              ),
                      ),
              ],
            ));
  }
}
