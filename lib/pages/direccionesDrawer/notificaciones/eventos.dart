import 'package:flutter/material.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/notificaciones/calendario.dart';

class NotificacionesCalender extends StatelessWidget {
  final List<Event> events;

  const NotificacionesCalender({super.key, required this.events});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          Event event = events[index];
          return ListTile(
            title: Text(event.title),
            subtitle: Text(event.description),
            // Otras propiedades y acciones del ListTile...
          );
        },
      ),
    );
  }
}
