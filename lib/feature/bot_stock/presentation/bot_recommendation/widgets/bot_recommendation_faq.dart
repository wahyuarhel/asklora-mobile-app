part of '../bot_recommendation_screen.dart';

class BotRecommendationFaq extends StatelessWidget {
  const BotRecommendationFaq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BotStockBloc, BotStockState>(
        buildWhen: (previous, current) =>
            previous.faqActiveIndex != current.faqActiveIndex,
        builder: (context, state) {
          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.red),
            child: CustomExpansionPanelList(
              elevation: 0,
              expandedHeaderPadding: EdgeInsets.zero,
              expansionCallback: (int index, bool isExpanded) => context
                  .read<BotStockBloc>()
                  .add(FaqActiveIndexChanged(index)),
              children: botRecommendationFaqs.map<CustomExpansionPanel>((e) {
                return CustomExpansionPanel(
                    dividerAtEndOfWidget: botRecommendationFaqs.indexOf(e) ==
                        botRecommendationFaqs.length - 1,
                    isExpanded: botRecommendationFaqs.indexOf(e) ==
                        state.faqActiveIndex,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        contentPadding: AppValues.screenHorizontalPadding
                            .copyWith(top: 14, bottom: 14),
                        title: CustomTextNew(
                          e.left,
                          style: AskLoraTextStyles.subtitle1
                              .copyWith(color: AskLoraColors.charcoal),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AskLoraColors.primaryGreen)),
                          padding: const EdgeInsets.all(3),
                          child: Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: AskLoraColors.primaryGreen,
                            size: 18,
                          ),
                        ),
                      );
                    },
                    body: ListTile(
                      title: CustomTextNew(
                        e.right,
                        style: AskLoraTextStyles.body1,
                      ),
                    ));
              }).toList(),
            ),
          );
        });
  }
}
