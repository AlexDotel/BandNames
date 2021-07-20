import 'package:flutter/material.dart';

import 'package:bandnames/models/band.dart';

Widget bandListTile(Band band) {
  return Dismissible(
    direction: DismissDirection.startToEnd,
    onDismissed: (direction){
      print('direction: $direction');
      // TODO: Borrar en el servidor
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
                SizedBox(width: 16,),
                Text('Delete ${band.name}?', style: TextStyle(color: Colors.white),)
              ],
            ))),
    key: Key(band.id),
    child: ListTile(
      onTap: () {
        print('${band.name} tapped!' );
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
              child:
                  Text(band.votes, style: TextStyle(color: Colors.blue[50])))),
    ),
  );
}
