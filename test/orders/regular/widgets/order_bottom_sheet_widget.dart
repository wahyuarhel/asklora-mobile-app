import 'package:asklora_mobile_app/core/presentation/custom_text.dart';
import 'package:asklora_mobile_app/feature/orders/bloc/order_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/regular/presentation/widgets/order_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mocks.dart';

void main() {
  group('Order Bottom Sheet Widget Test', () {
    Future<void> buildOrderBottomSheetWidget(WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BlocProvider(
            create: (_) => OrderBloc(),
            child: const OrderBottomSheetWidget(
              title: 'Some Title',
              children: [
                CustomText(
                  'Some Child',
                  key: Key('some_child_1'),
                ),
                CustomText(
                  'Some Child',
                  key: Key('some_child_2'),
                )
              ],
            ),
          ),
        ),
        navigatorObservers: [mockObserver],
      ));
    }

    final closeButton =
        find.byKey(const Key('order_bottom_sheet_close_button'));
    final title = find.byKey(const Key('order_bottom_sheet_title'));
    final child1 = find.byKey(const Key('some_child_1'));
    final child2 = find.byKey(const Key('some_child_2'));

    testWidgets('First render order bottom sheet', (WidgetTester tester) async {
      await buildOrderBottomSheetWidget(tester);
      expect(title, findsOneWidget);
      expect(closeButton, findsOneWidget);
      expect(child1, findsOneWidget);
      expect(child2, findsOneWidget);
    });
  });
}
