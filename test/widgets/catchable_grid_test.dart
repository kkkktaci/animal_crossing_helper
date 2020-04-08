import 'package:animal_crossing_helper/models/catchable.dart';
import 'package:animal_crossing_helper/models/type.dart';
import 'package:animal_crossing_helper/redux/app/app_reducer.dart';
import 'package:animal_crossing_helper/redux/app/app_state.dart';
import 'package:animal_crossing_helper/redux/price_sort.dart';
import 'package:animal_crossing_helper/widgets/catchable_grid.dart';
import 'package:animal_crossing_helper/widgets/grid_card.dart';
import 'package:animal_crossing_helper/widgets/loading.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test/flutter_test.dart';

import 'wrapper.dart';

void main() {
  testWidgets('loading with no data', (WidgetTester tester) async {
    CatchableViewModel vm = CatchableViewModel(
      fetching: true,
      data: [],
      error: null,
      priceSort: PRICE.NONE,
      selectedFilter: []
    );
    await tester.pumpWidget(CatchableGridPresentation(
      vm: vm,
      type: TYPE.FISH,
    ));

    final loadingFinder = find.byType(Loading);
    expect(loadingFinder, findsOneWidget);
  });

  group('render data', () {
    Store<AppState> store;

    setUp(() {
      store = Store<AppState>(
        appReducer,
        initialState: AppState.initial(),
        distinct: true
      );
    });

    testWidgets('loading with data', (WidgetTester tester) async {
      CatchableViewModel vm = CatchableViewModel(
        fetching: true,
        data: [
          Catchable(name: 'foo1', image: 'boo1', type: TYPE.FISH),
          Catchable(name: 'foo2', image: 'boo2', type: TYPE.FISH)
        ],
        error: null,
        priceSort: PRICE.NONE,
        selectedFilter: []
      );
      
      await tester.pumpWidget(StoreProvider(
        store: store,
        child: wrapWithDirectionality(wrapMediaQuery(
          CatchableGridPresentation(
            vm: vm,
            type: TYPE.FISH,
          ),
        )),
      ));

      final cardsFinder = find.byType(GridCard);
      expect(cardsFinder, findsNWidgets(2));
    });

    testWidgets('render data with no loading', (WidgetTester tester) async {
      CatchableViewModel vm = CatchableViewModel(
        fetching: false,
        data: [
          Catchable(name: 'foo1', image: 'boo1', type: TYPE.FISH),
          Catchable(name: 'foo2', image: 'boo2', type: TYPE.FISH)
        ],
        error: null,
        priceSort: PRICE.NONE,
        selectedFilter: []
      );
      
      await tester.pumpWidget(StoreProvider(
        store: store,
        child: wrapWithDirectionality(wrapMediaQuery(
          CatchableGridPresentation(
            vm: vm,
            type: TYPE.FISH,
          ),
        )),
      ));

      final cardsFinder = find.byType(GridCard);
      expect(cardsFinder, findsNWidgets(2));
    });
  });
}