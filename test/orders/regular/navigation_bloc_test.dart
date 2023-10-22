import 'package:asklora_mobile_app/core/presentation/navigation/bloc/navigation_bloc.dart';
import 'package:asklora_mobile_app/feature/orders/bloc/order_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  group('Navigation Bloc Tests', () {
    late NavigationBloc<OrderPageStep> navigationBloc;

    setUp(() async {
      navigationBloc = NavigationBloc(OrderPageStep.symbolDetails);
    });

    test('Navigation Bloc init state', () {
      expect(navigationBloc.state,
          const NavigationState(page: OrderPageStep.symbolDetails));
    });

    blocTest<NavigationBloc, NavigationState>(
        'emits `page` = OrderPageStep.order WHEN change page to order page',
        build: () => navigationBloc,
        act: (bloc) async =>
            bloc.add(const PageChanged<OrderPageStep>(OrderPageStep.order)),
        expect: () => {
              const NavigationState(page: OrderPageStep.order),
            });

    blocTest<NavigationBloc, NavigationState>(
        'emits `page` = OrderPageStep.order then `page` = OrderPageStep.orderType '
        'WHEN change page to order page then change page to order type',
        build: () => navigationBloc,
        act: (bloc) async => {
              bloc.add(const PageChanged<OrderPageStep>(OrderPageStep.order)),
              bloc.add(
                  const PageChanged<OrderPageStep>(OrderPageStep.orderType)),
            },
        expect: () => {
              const NavigationState(page: OrderPageStep.order),
              const NavigationState(page: OrderPageStep.orderType),
            });

    blocTest<NavigationBloc, NavigationState>(
        'emits `page` = OrderPageStep.order then `page` = OrderPageStep.symbolDetails '
        'WHEN change page to order page then back to symbol details page',
        build: () => navigationBloc,
        act: (bloc) async => {
              bloc.add(const PageChanged<OrderPageStep>(OrderPageStep.order)),
              bloc.add(const PagePop<OrderPageStep>()),
            },
        expect: () => {
              const NavigationState(page: OrderPageStep.order),
              const NavigationState(page: OrderPageStep.symbolDetails),
            });

    tearDown(() => {navigationBloc.close()});
  });
}
