import 'package:bandnames/services/socket_service.dart';
import 'package:flutter/material.dart';

import 'package:bandnames/models/band.dart';
import 'package:provider/provider.dart';

Widget bandListTile(Band band, BuildContext context) {
  final socketService = Provider.of<SocketService>(context, listen: false);

  return Dismissible(
    direction: DismissDirection.startToEnd,
    onDismissed: (direction) {
      socketService.socket!
          .emit('deleteBand', {'id': band.id, 'name': band.name});
      print('${band.name} deleted');
    },
    background: Container(
        padding: EdgeInsets.only(left: 16),
        color: Colors.red[500],
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(Icons.delete, color: Colors.white),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'Delete ${band.name}?',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ))),
    key: Key(band.id),
    child: ListTile(
      onTap: () {
        socketService.socket!.emit('voteBand', {'id': band.id, 'name': band.name });
        print('Voto por ${band.name}');
      },
      leading: CircleAvatar(
        backgroundColor: Colors.blue[50],
        child: Text(band.name.substring(0, 2)),
      ),
      title: Text(band.name),
      trailing: Container(
          height: 30,
          width: 30,
          color: Colors.blue[600],
          child: Center(
              child: Text(band.votes.toString(),
                  style: TextStyle(color: Colors.blue[50])))),
    ),
  );
}
