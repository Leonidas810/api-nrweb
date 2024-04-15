import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'result_screen.dart';

class HomeScreen extends StatelessWidget {
  Future<Map<String, dynamic>> _fetchData() async {
    final response = await http.get(Uri.parse('http://nrweb.com.mx/reportes/api_prueba.php?nombre=%22alejandro%22&hora=10'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Objeto no encontrado');
    } else if (response.statusCode == 500) {
      throw Exception('Error interno del servidor');
    } else {
      throw Exception('Error desconocido');
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
            try {
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
            } catch (e) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text(e.toString()),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cerrar'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('Iniciar'),
        ),
      ),
    );
  }
}
