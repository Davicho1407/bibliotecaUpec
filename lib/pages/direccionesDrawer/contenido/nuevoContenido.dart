import 'package:flutter/material.dart';

import 'package:upec_library_bloc/pages/direccionesDrawer/contenido/fondo_contenido.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/contenido/preferences/preferencias.dart';

class NuevoContenido extends StatefulWidget {
  const NuevoContenido({super.key});

  @override
  State<NuevoContenido> createState() => _NuevoContenidoState();
}

class _NuevoContenidoState extends State<NuevoContenido> {
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
                      Icons.article_rounded,
                      color: Colors.blueGrey,
                    ),
                    child: Text(
                      'Nuevo Contenido',
                      textAlign: TextAlign.center,
                    ),
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
                  children: [FondoContenido(), PreferenciasUsuario()],
                ),
              )
            ],
          )),
        ));
  }
}
