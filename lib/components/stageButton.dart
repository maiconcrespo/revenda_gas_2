import 'package:flutter/material.dart';

class Stagebutton extends StatelessWidget {
  final String? label;
  final bool? staged;
  const Stagebutton({
    Key? key,
    this.label,
    this.staged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(15),
          width: 21,
          height: 21,
          decoration: BoxDecoration(
            color: staged! ? Colors.blue : Colors.white,
            shape: BoxShape.circle,
            border:
                Border.all(color: staged! ? Colors.blue : Colors.grey[500]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(staged! ? 0.3 : 0.0),
                spreadRadius: 10,
                blurRadius: 2,
              ),
            ],
          ),
        ),
        //SizedBox(height: 21),
        Text(label!)
      ],
    );
  }
}
