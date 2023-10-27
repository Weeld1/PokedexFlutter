import 'package:flutter/material.dart';
import 'package:pokedex/tela_inicio.dart';

void main() {
  runApp(Pokedex());
}

class Pokedex extends StatelessWidget {
  // const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaInicio(),
    );
  }
}
