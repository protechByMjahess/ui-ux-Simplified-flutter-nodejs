import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text(
                'Next chapter',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              color: Colors.grey[850],
              textColor: Colors.grey[400],
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    final String enteredEmail = emailController.text;
    final String enteredPassword = passwordController.text;

    try {
      final Map<String, dynamic> loginData = {
        'email': enteredEmail,
        'password': enteredPassword,
      };

      final response = await http.post(
        Uri.parse('https://advice-xchq.onrender.com/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(loginData),
      );

      if (response.statusCode == 200) {
        // Successful login
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
    } catch (e) {
      print('Error during login: $e');
    }
  }
}
