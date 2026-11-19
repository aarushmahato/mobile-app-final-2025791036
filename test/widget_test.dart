import 'package:flutter_test/flutter_test.dart';
import 'package:recipie_explorer_app/main.dart';

void main() {
  testWidgets('App displays the welcome message', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const RecipeExplorerApp());

    expect(
      find.text('Welcome to Recipe Explorer!'),
      findsOneWidget,
    );
  });
}