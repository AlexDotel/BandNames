import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket? _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket? get socket => this._socket;
  Function get emit => this._socket!.emit;

  SocketService() {
    
    this._initConfig();
  }

  void _initConfig() {
    String urlSocket =
        'https://serverbandnames.herokuapp.com/'; //tu ipv4 con iPconfig (windows)

    this._socket = IO.io(
        urlSocket,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            // .setExtraHeaders({'foo': 'bar'}) // optional
            .build());

    // Connect
    this._socket!.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    // Disconnect
    this._socket!.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // Escuchar
    // this._socket!.on('nuevoMensaje', (payload) {
    //   print('NuevoMensaje: $payload');
    //   print('nombre: ' + payload['nombre']);
    //   print('apellido: ' + payload['apellido']);
    //   print(payload.containsKey('edad')
    //       ? 'edad: ' + payload['edad']
    //       : 'edad: Desconocida');
    //   notifyListeners();
    // });
  }
}
