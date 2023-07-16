import 'package:flutter/material.dart';

class ListNotifications extends StatefulWidget {
  const ListNotifications({super.key});

  @override
  State<ListNotifications> createState() => _ListNotificationsState();
}

class _ListNotificationsState extends State<ListNotifications> {
  String? titulo;
  String? cuerpo;
  Map<String, dynamic>? payload;
  void mostrarMensaje(
      String titulo, String cuerpo, Map<String, dynamic> payload) {
    // Aquí puedes utilizar los parámetros para mostrar el mensaje en el diseño de la ventana
    print('Título: $titulo');
    print('Cuerpo: $cuerpo');
    print('Payload: $payload');
    setState(() {
      this.titulo = titulo;
      this.cuerpo = cuerpo;
      this.payload = payload;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Título: ${titulo ?? ''}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Cuerpo: ${cuerpo ?? ''}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Payload:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '${payload ?? {}}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
