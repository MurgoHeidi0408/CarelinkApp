import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:carelink_app/main.dart';

void main() {
  testWidgets('Basic app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();

    // Verifica que la app carga (ajusta esto a algo real de tu UI)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}