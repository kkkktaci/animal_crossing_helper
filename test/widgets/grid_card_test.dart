import 'package:animal_crossing_helper/models/name_thing.dart';
import 'package:animal_crossing_helper/widgets/grid_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Grid Card', (WidgetTester tester) async {
    NameThing nameThing = NameThing(name: 'foo', image: 'bar');
    // Why need Directionality and Material, please see: https://github.com/flutter/flutter/blob/master/packages/flutter/test/material/ink_well_test.dart
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Material(
          child: GridCard(nameThing: nameThing),
        )
      )
    );
    final titleFinder = find.text('foo');
    final imageFinder = find.byType(Image);

    expect(titleFinder, findsOneWidget);
    expect(imageFinder, findsOneWidget);
  });
}