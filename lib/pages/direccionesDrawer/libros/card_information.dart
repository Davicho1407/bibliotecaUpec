import 'package:flutter/material.dart';

class CardsInformation extends StatefulWidget {
  final String titulo;
  final String autor;
  final String materia;
  final String imagenportada;

  const CardsInformation({
    Key? key,
    required this.titulo,
    required this.autor,
    required this.materia,
    required this.imagenportada,
  }) : super(key: key);
  @override
  State<CardsInformation> createState() => _CardsInformationState();
}

class _CardsInformationState extends State<CardsInformation> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: height * 0.05,
        ),
        GestureDetector(
          child: SizedBox(
            height: 240,
            child: Stack(
              children: [
                Positioned(
                    top: 35,
                    left: 20,
                    child: Material(
                      child: Container(
                        height: 180.0,
                        width: width * 0.92,
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
                    top: 0,
                    left: 30,
                    child: Card(
                      elevation: 10.0,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 180,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(widget.imagenportada))),
                      ),
                    )),
                Positioned(
                    top: 45,
                    left: 190,
                    child: Container(
                      height: 170,
                      width: 190,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.titulo,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.autor,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Text(
                            widget.materia,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
