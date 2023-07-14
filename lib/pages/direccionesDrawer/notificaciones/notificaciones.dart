import 'package:flutter/material.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/notificaciones/calender/pages/calendario.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/notificaciones/notifications_oficial.dart';

class Notificaciones extends StatefulWidget {
  const Notificaciones({super.key});

  @override
  State<Notificaciones> createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificaciones> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            TabBar(
                indicatorColor: Colors.cyanAccent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.notification_add,
                      color: Colors.deepOrangeAccent,
                    ),
                    text: 'Notificaciones',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.calendar_month,
                      color: Colors.greenAccent,
                    ),
                    text: 'Calendario',
                  )
                ]),
            Expanded(
                child: TabBarView(
              children: [ListNotifications(), TableBasicsExample()],
            ))
          ],
        )),
      ),
    );
  }
}
