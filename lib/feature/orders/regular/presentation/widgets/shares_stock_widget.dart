import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/presentation/custom_text.dart';
import '../../../bloc/market/market_bloc.dart';

class SharesStockWidget extends StatelessWidget {
  const SharesStockWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketBloc, MarketState>(
        builder: (context, state) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomText(
                    state.sharesAmount.toString(),
                    type: FontType.highlight,
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                        onTap: () => context
                            .read<MarketBloc>()
                            .add(const SharesAmountIncremented()),
                        child: const Icon(Icons.add_circle_outline)),
                    const SizedBox(height: 10),
                    InkWell(
                        onTap: () => context
                            .read<MarketBloc>()
                            .add(const SharesAmountDecremented()),
                        child:
                            const Icon(Icons.remove_circle_outline_outlined)),
                  ],
                )
              ],
            ));
  }
}
