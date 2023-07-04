import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/notificaciones/calendario.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/notificaciones/eventos.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/redSocial.dart';

class Notificaciones extends StatefulWidget {
  const Notificaciones({super.key});

  @override
  State<Notificaciones> createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificaciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Notificaciones",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.tealAccent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Material(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Center(
            widthFactor: 2.4,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                BotonPersonalizado(),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BotonPersonalizado extends StatefulWidget {
  const BotonPersonalizado({super.key});

  @override
  State<BotonPersonalizado> createState() => _BotonPersonalizadoState();
}

class _BotonPersonalizadoState extends State<BotonPersonalizado> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Column(
            children: [
              MaterialButton(
                height: 50,
                splashColor: Colors.greenAccent,
                color: Colors.blueAccent,
                onPressed: () {},
                child: Text('Notificaciones',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                  height: 50,
                  splashColor: Colors.blueAccent,
                  color: Colors.greenAccent,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Calendario()));
                  },
                  child: Text(
                    'Calendario',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class Rectangulo extends StatelessWidget {
  final Color customColor;

  const Rectangulo({super.key, required this.customColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(color: customColor),
    );
  }
}
