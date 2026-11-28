import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipie_explorer_app/main.dart';

void main() {
  testWidgets('Bottom tabs switch screens and keep the search text', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const RecipeExplorerApp());

    expect(find.text('Recipe Explorer'), findsOneWidget);

    await tester.tap(find.widgetWithText(NavigationDestination, 'Search'));
    await tester.pump();
    expect(find.text('Welcome to Recipe Explorer!'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'chicken');

    await tester.tap(find.widgetWithText(NavigationDestination, 'Favorites'));
    await tester.pump();
    expect(find.text('The saved meals list is coming next.'), findsOneWidget);

    await tester.tap(find.widgetWithText(NavigationDestination, 'Search'));
    await tester.pump();
    expect(find.text('chicken'), findsOneWidget);
  });
}
