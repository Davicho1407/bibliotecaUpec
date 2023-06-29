import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/notificaciones.dart';

void main() {
  testWidgets('Prueba de Notificaciones', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Notificaciones(),
      ),
    );

    // Verificar que el widget AppBar existe
    expect(find.byType(AppBar), findsOneWidget);

    // Verificar el estilo del texto en el AppBar
    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    final title = appBar.title as Text;
    expect(title.style?.color, equals(Colors.black));
    expect(title.style?.fontWeight, equals(FontWeight.bold));
    expect(title.data, equals('Notificaciones'));

    // Verificar el color de fondo del AppBar
    expect(appBar.backgroundColor, equals(Colors.tealAccent));

    // Otras pruebas...
  });
}
