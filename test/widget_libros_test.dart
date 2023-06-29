import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/libros/card_information.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/libros/filtroBusqueda.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/libros/libros.dart'; // Reemplaza "tu_paquete" por el nombre de tu paquete o directorio donde se encuentra el archivo Libros.

void main() {
  testWidgets('Prueba de Libros', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Libros(),
      ),
    );

    // Verificar que el texto "Hola" existe
    expect(find.text('Hola'), findsOneWidget);

    // Verificar que el widget FiltroBusqueda existe
    expect(find.byType(FiltroBusqueda), findsOneWidget);

    // Verificar que el widget CardsInformation existe
    expect(find.byType(CardsInformation), findsOneWidget);

    // Verificar el texto y las propiedades de los widgets CardsInformation
    final cardsInformationWidget =
        tester.widget<CardsInformation>(find.byType(CardsInformation));
    expect(cardsInformationWidget.titulo, equals('titulo'));
    expect(cardsInformationWidget.autor, equals('autor'));
    expect(cardsInformationWidget.materia, equals('materia'));

    // Otras pruebas...
  });
}
