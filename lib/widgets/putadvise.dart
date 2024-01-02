import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PutAdvisePage extends StatefulWidget {
  @override
  _PutAdvisePageState createState() => _PutAdvisePageState();
}

class _PutAdvisePageState extends State<PutAdvisePage> {
  TextEditingController adviseController = TextEditingController();

  Future<void> postAdvise(String advise) async {
    final Uri apiUrl = Uri.parse('https://advice-xchq.onrender.com/createAdvice');

    try {
      final response = await http.post(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'advise': advise,
        }),
      );

      if (response.statusCode == 200) {
        // Successful POST request
        print('Advice posted successfully');
        // Handle any further logic here
      } else {
        // Error in the POST request
        print('Failed to post advice. Status Code: ${response.statusCode}');
        // Handle error logic here
      }
    } catch (e) {
      // Exception occurred during the POST request
      print('Exception while posting advice: $e');
      // Handle exception logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Put Advise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: adviseController,
              decoration: InputDecoration(
                labelText: 'Enter your advice',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String advise = adviseController.text.trim();
                if (advise.isNotEmpty) {
                  postAdvise(advise);
                } else {
                  // Handle empty advice case
                  print('Please enter advice before posting');
                }
              },
              child: Text('Post Advice'),
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
