import 'package:flutter/material.dart';

class FiltroBusqueda extends StatefulWidget {
  const FiltroBusqueda({super.key});

  @override
  State<FiltroBusqueda> createState() => _FiltroBusquedaState();
}

class _FiltroBusquedaState extends State<FiltroBusqueda> {
  TextEditingController _searchController = TextEditingController();

  List<String> items = ['Manzana', 'Banana', 'Naranja', 'Pera'];
  List<String> filteredItems = [];
  void searchItems(String searchTerm) {
    filteredItems = items.where((item) {
      return item.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
                labelText: 'Buscar', prefixIcon: Icon(Icons.search)),
            onChanged: (value) {
              searchItems(value);
            },
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////
