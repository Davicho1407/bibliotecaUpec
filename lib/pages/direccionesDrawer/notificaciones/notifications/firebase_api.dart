import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

typedef MostrarMensajeCallback = void Function(
    String titulo, String cuerpo, Map<String, dynamic> payload);

MostrarMensajeCallback? mostrarMensajeCallback;
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Titulo: ${message.notification?.title}');
  print('Cuerpo: ${message.notification?.body}');
  print('Payload: ${message.data}');

  // Llama a la función de callback para mostrar el mensaje
  if (mostrarMensajeCallback != null) {
    mostrarMensajeCallback!(
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      message.data,
    );
  }
}

class FirebaseApi {
  final _fiebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _fiebaseMessaging.requestPermission();
    final fCMoken = await _fiebaseMessaging.getToken();
    print('Token: $fCMoken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
