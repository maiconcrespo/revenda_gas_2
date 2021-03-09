import 'dart:ui';

import 'package:flutter/material.dart';

class Mainbutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(30),
      child: Text(
        'IR PARA O PAGAMENTO',
        style: TextStyle(
            color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent]),
      ),
    );
  }
}
