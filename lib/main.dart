import 'package:flutter/material.dart';
import 'package:revenda_gas_2/models/revenda_model.dart';
import 'package:revenda_gas_2/screens/revenda_screen.dart';
import 'package:revenda_gas_2/screens/selecion_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RevendaScreen(),
      routes: {
        SelecionScreen.routerName: (_) {
          var revenda = ModalRoute.of(_)!.settings.arguments as RevendaModel;
          return SelecionScreen(revenda: revenda);
        }
      },
    );
  }
}
