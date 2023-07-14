import 'package:flutter/material.dart';

class PreferenciasUsuario extends StatefulWidget {
  const PreferenciasUsuario({super.key});

  @override
  State<PreferenciasUsuario> createState() => _PreferenciasUsuarioState();
}

class _PreferenciasUsuarioState extends State<PreferenciasUsuario> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/fondo_contenido.png'), // Ruta de la imagen de fondo
          fit: BoxFit.cover, // Ajuste de la imagen en el contenedor
        ),
      ),
    );
  }
}
