import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bandnames/models/band.dart';
import 'package:bandnames/resources/BandList.dart';
import 'package:bandnames/widgets/ListTileWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = getBandList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: 'BandNames'),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, index) => bandListTile(bands[index])),
      floatingActionButton: FloatingActionButton(
          elevation: 1, onPressed: () => addNewBand(), child: Icon(Icons.add)),
    );
  }

  addNewBand() {
    TextEditingController nameController = new TextEditingController();
    TextEditingController votesController = new TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Add New Band'),
              content: Wrap(
                children: [
                  Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(hintText: 'Band Name'),
                        controller: nameController,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(hintText: 'Votation from 1 to 10'),
                        controller: votesController,
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                    child: Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addingNewBand(
                        nameController.text, votesController.text))
              ],
            );
          });
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('Add New Band'),
            content: Column(
              children: [
                CupertinoTextField(
                    keyboardType: TextInputType.text,
                    placeholder: 'Band Name',
                    controller: nameController),
                SizedBox(height: 10),
                CupertinoTextField(
                    keyboardType: TextInputType.number,
                    placeholder: 'Votation from 1 to 10',
                    controller: votesController),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Add'),
                  onPressed: () => addingNewBand(
                      nameController.text, votesController.text.toString())),
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text('Dismiss'),
                  onPressed: () => Navigator.pop(context)),
            ],
          );
        });

    print('Added');
  }

  void addingNewBand(String bandName, String votes) {
    if (bandName.length >= 1 && votes.length >= 1 && int.parse(votes) <= 10) {
      print(bandName);
      // Agregamos si es mayor a 1
      this.bands.add(Band(
            id: Random().toString(),
            name: bandName,
            votes: votes,
            ranking: '6',
          ));
      setState(() {});
    } else {
      print('Error en los valores introducidos');
    }

    Navigator.pop(context);
  }

  myAppBar({title: String}) {
    return AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ));
  }
}
