import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/redSocial.dart';

void main() {
  testWidgets('Prueba de RedSocial', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RedSocial(),
      ),
    );

    // Verificar que el widget AppBar existe
    expect(find.byType(AppBar), findsOneWidget);

    // Verificar que el widget Text con el texto "Red Social" existe en el AppBar
    expect(find.text('Red Social'), findsOneWidget);

    // Simular toque en el botón
    await tester.tap(find.byType(GestureDetector));

    // Volver a construir el widget después de la interacción
    await tester.pump();
  });
}
