import 'package:flutter/material.dart';
import 'package:bandnames/services/socket_service.dart';

class ConnectedIcon extends StatelessWidget {
  ConnectedIcon(this.socket);

  final SocketService socket;

  @override
  Widget build(BuildContext context) {
  
    return Container(
        padding: EdgeInsets.only(right: 16),
        child: socket.serverStatus == ServerStatus.Online
            ? Icon(
                Icons.check_circle,
                color: Colors.green[300],
              )
            : Icon(
                Icons.bolt_rounded,
                color: Colors.red[300],
              ));
  }
}
