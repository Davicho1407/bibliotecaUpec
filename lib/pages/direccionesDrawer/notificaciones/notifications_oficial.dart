import 'package:flutter/material.dart';

class ListNotifications extends StatefulWidget {
  const ListNotifications({super.key});

  @override
  State<ListNotifications> createState() => _ListNotificationsState();
}

class _ListNotificationsState extends State<ListNotifications> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Text('Aqui va las notificaciones'),
    );
  }
}
