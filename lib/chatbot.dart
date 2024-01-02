import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'widgets/drawer_widget.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  List<String> _currentTips = ['Click "Get UI/UX Design Tip" to get advice.'];
  String _error = '';

  void getRandomTip() async {
    try {
      final response = await http.get(Uri.parse('https://advice-xchq.onrender.com/advice'));
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final newTip = json.decode(response.body)['advice'] as String;
          if (!_currentTips.contains(newTip)) {
            setState(() {
              _currentTips.add(newTip);
            });
          } else {
            getRandomTip();
          }
        } else {
          print('Error: Empty response body');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        _error = 'Error loading advice: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FancyDrawerWidget(
      title: "UI/UX Advice Bot",
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListView(
                  children: _currentTips
                      .asMap()
                      .entries
                      .map(
                        (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        entry.key == 0
                            ? entry.value
                            : '${entry.key} - ${entry.value}',
                        style: TextStyle(
                          fontSize: 20,
                          color: entry.key == 0 ? Colors.amberAccent[200] : Colors.grey[400],
                        ),
                      ),
                    ),
                  )
                      .toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: getRandomTip,
                child: const Text(
                  'Get UI/UX Design Tip',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[850],
                  onPrimary: Colors.grey[400],
                  elevation: 4.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: ChatBot(),
    ),
  );
}
