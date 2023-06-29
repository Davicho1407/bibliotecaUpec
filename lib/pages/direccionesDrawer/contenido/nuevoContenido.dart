import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/contenido/dise%C3%B1o_barra.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/contenido/dise%C3%B1o_general_widget.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/contenido/fondo_contenido.dart';

class NuevoContenido extends StatefulWidget {
  const NuevoContenido({super.key});

  @override
  State<NuevoContenido> createState() => _NuevoContenidoState();
}

class _NuevoContenidoState extends State<NuevoContenido> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContenidoGeneral(),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: Icon(Icons.view_carousel_rounded),
              label: 'Noticias',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FondoContenido()));
              }),
          SpeedDialChild(
              child: Icon(Icons.replay_circle_filled_outlined),
              label: 'Actualizaciones',
              onTap: () {}),
          SpeedDialChild(
              child: Icon(Icons.recommend),
              label: 'Libros que me gustan',
              onTap: () {}),
        ],
      ),
    );
  }
}

class ContenidoGeneral extends StatelessWidget {
  const ContenidoGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/img/fondo_naturaleza.png'), // Ruta de la imagen de fondo
          fit: BoxFit.cover, // Ajuste de la imagen en el contenedor
        ),
      ),
    );
  }
}
