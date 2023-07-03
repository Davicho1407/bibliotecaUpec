import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:url_launcher/url_launcher.dart';

class RedSocial extends StatefulWidget {
  const RedSocial({super.key});

  @override
  State<RedSocial> createState() => _RedSocialState();
}

class _RedSocialState extends State<RedSocial> {
  final String telegramURL = "https://t.me/+OK5ZnB4KEVY1OWRh";
  bool _isPressed = false;
  double scaleFactor = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
          title: const Text(
            "Red Social",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.tealAccent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  child: Transform.scale(
                      scale: scaleFactor,
                      child: Image.asset('assets/img/telegram.png')),
                  width: 150,
                ),
                onTapDown: (_) {
                  setState(() {
                    _isPressed = true;
                    scaleFactor = 0.9;
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    _isPressed = false;
                    scaleFactor = 1.0;
                  });
                },
                onTap: () {
                  _launchUrl();
                },
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Haz clic en el botón para abrir Telegram, para unirte al grupo.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ));
  }

  final Uri _url = Uri.parse('https://t.me/+Mwm8CcguWz5hNzhh');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('No se pudo conectar $_url');
    }
  }
}
