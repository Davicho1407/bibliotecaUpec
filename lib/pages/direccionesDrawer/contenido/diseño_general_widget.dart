import 'package:flutter/material.dart';

class VistaWidgets extends StatefulWidget {
  const VistaWidgets({super.key});

  @override
  State<VistaWidgets> createState() => _VistaWidgetsState();
}

class _VistaWidgetsState extends State<VistaWidgets> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: 200,
          child: Stack(
            children: [
              Positioned(
                  top: 35,
                  left: 20,
                  child: Material(
                    child: Container(
                      height: 150.0,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            new BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                offset: new Offset(-10.0, 10.0),
                                blurRadius: 20.0,
                                spreadRadius: 4.80),
                          ]),
                    ),
                  )),
              Positioned(
                  top: 5,
                  left: 45,
                  child: Card(
                    elevation: 10.0,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      height: 100,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  AssetImage("assets/img/shanti lesur.jpg"))),
                    ),
                  )),
              Positioned(
                top: 120,
                left: 35,
                child: Container(
                  height: 50,
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: Colors.black,
                      ),
                      Text('Titulo',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text(
                        'Autor',
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
