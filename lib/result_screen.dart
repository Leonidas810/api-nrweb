import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final List<int> numeros;
  final List<String> colores;

  ResultScreen({required this.numeros, required this.colores});

  @override
  Widget build(BuildContext context) {
    double cuadritoSizeX = MediaQuery.of(context).size.width / numeros[0];
    double cuadritoSizeY = MediaQuery.of(context).size.height / numeros[1];

    return Scaffold(
      body: Stack(
        children: [
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: numeros[0],
              childAspectRatio: cuadritoSizeX / cuadritoSizeY,
            ),
            itemCount: numeros[0] * numeros[1],
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(.5),
                color: _getColor(index), 
              );
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: Text('Resultados'),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(int index) {
    int colorIndex = index % colores.length;
    return Color(int.parse(colores[colorIndex].replaceAll('#', '0xFF')));
  }
}
