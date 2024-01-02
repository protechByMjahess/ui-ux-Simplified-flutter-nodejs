import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PutAdvisePage extends StatefulWidget {
  @override
  _PutAdvisePageState createState() => _PutAdvisePageState();
}

class _PutAdvisePageState extends State<PutAdvisePage> {
  final TextEditingController adviceController = TextEditingController();

  Future<void> _createAdvice(String advice) async {
    final String apiUrl = 'https://advice-xchq.onrender.com/createAdvice';

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'advice': advice,
        }),
      );

      if (response.statusCode == 200) {
        // Successful request, handle the response if needed
        print('Advice created successfully');
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to create advice');
      }
    } catch (e) {
      // Handle errors during the HTTP request
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Advice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: adviceController,
              decoration: InputDecoration(labelText: 'Enter advice'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String advice = adviceController.text.trim();
                if (advice.isNotEmpty) {
                  _createAdvice(advice);
                } else {
                  // Handle empty advice case
                  print('Please enter advice');
                }
              },
              child: Text('Create Advice'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PutAdvisePage(),
  ));
}
