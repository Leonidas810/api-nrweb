import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'result_screen.dart';

class HomeScreen extends StatelessWidget {
  Future<Map<String, dynamic>> _fetchData() async {
    final response = await http.get(Uri.parse('http://nrweb.com.mx/reportes/api_prueba.php?nombre=%22alejandro%22&hora=10'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print('======= JSON Recibido =======');
      print(jsonData);
      return jsonData;
    } else {
      throw Exception('Fallo al cargar la API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Obtener datos del API
            Map<String, dynamic> data = await _fetchData();
            // Navegar a ResultScreen pasando los datos obtenidos
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResultScreen(
                numeros: List<int>.from(data['numeros']),
                colores: List<String>.from(data['colores']),
              )), 
            );
          },
          child: Text('Iniciar'),
        ),
      ),
    );
  }
}
