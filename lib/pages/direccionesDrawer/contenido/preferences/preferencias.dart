import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upec_library_bloc/pages/direccionesDrawer/libros/card_information.dart';

class PreferenciasUsuario extends StatefulWidget {
  const PreferenciasUsuario({super.key});

  @override
  State<PreferenciasUsuario> createState() => _PreferenciasUsuarioState();
}

class _PreferenciasUsuarioState extends State<PreferenciasUsuario> {
  String? titulofavoritolibro;
  String? autorfavoritolibro;
  String? materiafavoritolibro;
  Map<String, dynamic> userPreferences = {};

  Future<void> loadPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      titulofavoritolibro = preferences.getString('titulofavoritolibro');
      autorfavoritolibro = preferences.getString('autorfavoritolibro');
      materiafavoritolibro = preferences.getString('materiafavoritolibro');
    });
  }

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/fondo_contenido.png'), // Ruta de la imagen de fondo
            fit: BoxFit.cover, // Ajuste de la imagen en el contenedor
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                CardsInformation(
                    titulo: '${titulofavoritolibro ?? 'Ninguno'}',
                    autor: ' ${autorfavoritolibro ?? 'Ninguno'}',
                    materia: ' ${materiafavoritolibro ?? 'Ninguno'}')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
