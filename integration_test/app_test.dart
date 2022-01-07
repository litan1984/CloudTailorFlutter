import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_tutorial/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Verify error validation", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(TypingPage), findsOneWidget);
    expect(find.byType(DisplayPage), findsNothing);
    expect(find.text("Input at least one character"), findsOneWidget);
  });

  testWidgets("Verify successful", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    final inputText = "Testing, Please Ignore";
    await tester.enterText(find.byKey(Key('your-text-field')), inputText);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(TypingPage), findsNothing);
    expect(find.byType(DisplayPage), findsOneWidget);
    expect(find.text(inputText), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    expect(find.byType(TypingPage), findsOneWidget);
    expect(find.byType(DisplayPage), findsNothing);
    expect(find.text(inputText), findsNothing);
  });
}
