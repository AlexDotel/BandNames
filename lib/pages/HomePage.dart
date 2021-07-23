import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:bandnames/services/socket_service.dart';
import 'package:bandnames/models/band.dart';

import 'package:bandnames/widgets/ListTileWidget.dart';
import 'package:bandnames/widgets/AndroidDialogWidget.dart';
import 'package:bandnames/widgets/CupertinoDialogWidget.dart';
import 'package:bandnames/widgets/ConnectedIconWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Band> bands = getBandList();
  List<Band> bands = [];
  final more = 'more';

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket!.on('active-bands', _handleActiveBands);

    super.initState();
  }

  _handleActiveBands(dynamic payload) {
    print(payload);
    this.bands = (payload as List).map((band) => Band.fromMap(band)).toList();
    setState(() {});
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket!.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: myAppBar(title: 'BandNames', socket: socketService),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Container(
                height: MediaQuery.of(context).size.width / 1.5,
                child: _myGraph())),
            Expanded(
              child: ListView.builder(
                  itemCount: bands.length,
                  itemBuilder: (context, index) =>
                      bandListTile(bands[index], context)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 1, onPressed: () => addNewBand(), child: Icon(Icons.add)),
    );
  }

  addNewBand() {
    TextEditingController nameController = new TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) {
            return AndroidDialogWidget(nameController, addingNewBand);
          });
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoDialogWidget(nameController, addingNewBand);
        });

    print('Added');
  }

  void addingNewBand(String bandName) {
    final SocketService socket =
        Provider.of<SocketService>(context, listen: false);

    if (bandName.length >= 1) {
      print(bandName);
      socket.emit('addBand', {'name': bandName.toString()});
    } else {
      print('Error en los valores introducidos');
    }

    Navigator.pop(context);
  }

  myAppBar({title: String, socket: Socket}) {
    return AppBar(
        actions: [
          Container(
              padding: EdgeInsets.only(right: 16), child: ConnectedIcon(socket))
        ],
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ));
  }

  Widget _myGraph() {

    Map<String, double> dataMap = Map();
    bands.forEach((banda) { 
      dataMap.putIfAbsent(banda.name, () => banda.votes.toDouble());
    });

    List<Color> colorList = [];


    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 5000),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 2.2,
      // colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 15,
      centerText: "BANDS",
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.w300,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 0,
      ),
      );

  }
}
