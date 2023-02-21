import 'package:flutter/material.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<StatefulWidget> createState() => _Body();
}

class _Body extends State<Scan> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(),
          )
        ],
      ),
    );
  }
}
