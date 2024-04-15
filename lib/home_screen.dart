import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'result_screen.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse('http://nrweb.com.mx/reportes/api_prueba.php?nombre=%22alejandro%22&hora=10'));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
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
            await _fetchData();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResultScreen()), 
            );
          },
          child: Text('Iniciar'),
        ),
      ),
    );
  }
}