import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/contenido/actualiacion_contenido.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/contenido/dise%C3%B1o_general_widget.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/contenido/fondo_contenido.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/contenido/preferencias.dart';
import 'package:upec_library_bloc/pages/paginaBody.dart';

class NuevoContenido extends StatefulWidget {
  const NuevoContenido({super.key});

  @override
  State<NuevoContenido> createState() => _NuevoContenidoState();
}

class _NuevoContenidoState extends State<NuevoContenido> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: SafeArea(
              child: Column(
            children: const [
              TabBar(
                indicatorColor: Colors.cyanAccent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.article_rounded,
                      color: Colors.blueGrey,
                    ),
                    text: 'Noticias',
                  ),
                  Tab(
                    icon:
                        Icon(Icons.auto_mode_sharp, color: Colors.purpleAccent),
                    text: 'Actializaciones',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.recommend_sharp,
                      color: Colors.red,
                    ),
                    text: 'Likes',
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FondoContenido(),
                    ActualizacionContenido(),
                    PreferenciasUsuario()
                  ],
                ),
              )
            ],
          )),
        ));
  }
}

class ContenidoGeneral extends StatelessWidget {
  const ContenidoGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/fondo_naturaleza.png'), // Ruta de la imagen de fondo
          fit: BoxFit.cover, // Ajuste de la imagen en el contenedor
        ),
      ),
    );
  }
}
