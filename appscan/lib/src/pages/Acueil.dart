import 'package:flutter/material.dart';

class Accuiel extends StatefulWidget {
  const Accuiel({super.key});
  
  @override
  State<StatefulWidget> createState() =>_Body();
}
class _Body extends State<Accuiel> {
  @override
  Widget build(BuildContext context) {
   return SizedBox(
    child: Stack(
      children:  <Widget>[
        Positioned(
          top: 0,
          child: Container(),
        )
      ],
    ),
   );
  }
}