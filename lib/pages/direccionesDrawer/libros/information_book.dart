import 'package:flutter/material.dart';

class InformationBook extends StatefulWidget {
  const InformationBook({
    super.key,
  });

  @override
  State<InformationBook> createState() => _InformationBookState();
}

class _InformationBookState extends State<InformationBook> {
  @override
  Widget build(BuildContext context) {
    // double iconSize = 55;

    // void _onPressed() {
    //   setState(() {
    //     iconSize = 45; // Tamaño más pequeño al hundir el icono
    //   });

    //   Future.delayed(Duration(milliseconds: 200), () {
    //     setState(() {
    //       iconSize = 55; // Tamaño original después de un tiempo de espera
    //     });
    //   });

    //   // Aquí puedes realizar otras acciones al presionar el botón
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => InformationBook()),
    //   );
    // }

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Material(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Información del libro",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.tealAccent,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: SafeArea(
              child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                child: SizedBox(
                  height: height * 0.7,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 35,
                          left: 20,
                          child: Material(
                            child: Container(
                              height: height * 0.6,
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
                                      image: AssetImage(
                                          "assets/shanti lesur.jpg"))),
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
                                Text('titulo',
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )),
                      Positioned(
                        top: 120,
                        left: 20,
                        width: width * 0.92,
                        height: 190,
                        child: const Divider(
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Autor:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Materia:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Editorial:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Descripcion:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                        top: 230,
                        left: 50,
                      ),
                      Positioned(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'autor',
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '',
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'editorial',
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'N.N',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        top: 230,
                        left: 150,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: null,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            child: Icon(
                              size: 70,
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: MaterialButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: null,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            child: Icon(
                              size: 70,
                              Icons.download,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ))),
    );
  }
}
