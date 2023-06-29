import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/contenido/fondo_contenido.dart';

void main() {
  testWidgets('Prueba de FondoContenido', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: FondoContenido(),
      ),
    );

    // Verificar que el widget Text con el texto 'Nuevo Contenido' existe
    expect(find.text('Nuevo Contenido'), findsOneWidget);

    // Verificar el estilo del texto
    final textWidget = tester.widget<Text>(find.text('Nuevo Contenido'));
    expect(textWidget.style?.color, equals(Colors.black));
    expect(textWidget.style?.fontWeight, equals(FontWeight.bold));
    expect(textWidget.style?.fontSize, equals(26.0));

    // Otras pruebas...
  });
}
