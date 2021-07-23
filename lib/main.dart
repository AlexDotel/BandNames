import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bandnames/services/socket_service.dart';

import 'package:bandnames/pages/HomePage.dart';
import 'package:bandnames/pages/StatusPage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SocketService() ,)],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BandNames',
        routes: {
          'home': (context) => HomePage(),
          'status': (context) => StatusPage()
        },
        initialRoute: 'home',
      ),
    );
  }
}
