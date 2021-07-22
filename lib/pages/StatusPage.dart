import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bandnames/services/socket_service.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  socketService.serverStatus == ServerStatus.Online
                      ? 'ONLINE'
                      : 'OFFLINE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))
            ],
          ),
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: () {
              enviarMensaje(socketService);
            }, child: Icon(Icons.message)));
  }
}

enviarMensaje(SocketService localSocket) {
  localSocket.emit(
      'emitirSaludo', {'nombre': 'Flutter', 'mensaje': 'Hola desde flutter'});
  print('Mensaje Enviado al server');
}
