import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _readConfig();
  }

  Future<void> _readConfig() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/config.json');
      final List<dynamic> configList = jsonDecode(jsonString);

      // Assuming the config file contains an array of objects with 'email' and 'password' fields
      if (configList.isNotEmpty) {
        final Map<String, dynamic> firstConfig = configList[0];

        emailController.text = firstConfig['email'] ?? '';
        passwordController.text = firstConfig['password'] ?? '';
      }
    } catch (e) {
      print('Error reading config file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    // Read the email and password from the JSON file
    final String enteredEmail = emailController.text;
    final String enteredPassword = passwordController.text;

    try {
      final String jsonString =
          await rootBundle.loadString('assets/config.json');
      final List<dynamic> configList = jsonDecode(jsonString);

      // Assuming the config file contains an array of objects with 'email' and 'password' fields
      if (configList.isNotEmpty) {
        bool isLoginSuccessful = false;

        for (var config in configList) {
          final String expectedEmail = config['email'] ?? '';
          final String expectedPassword = config['password'] ?? '';

          // Check if the entered email and password match the stored values
          if (enteredEmail == expectedEmail &&
              enteredPassword == expectedPassword) {
            isLoginSuccessful = true;
            break;
          }
        }

        if (isLoginSuccessful) {
          // Navigate to the "/home" route for a successful login
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // Display an error message or handle invalid login
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Invalid Login'),
              content: Text('Please check your email and password.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      print('Error reading config file: $e');
    }
  }
}
