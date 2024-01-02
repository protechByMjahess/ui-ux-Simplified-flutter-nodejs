import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
              ),
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: _handleSignup,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSignup() async {
    // Get values from controllers
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    // Prepare signup data
    final Map<String, dynamic> signupData = {
      'name': name, // Adjust to the correct column name in your database
      'email': email,
      'password': password,
    };

    try {
      // Make a POST request to the backend API with JSON data
      final response = await http.post(
        Uri.parse('https://advice-xchq.onrender.com/signUp'),
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode(signupData), // Encode the data as JSON
      );

      if (response.statusCode == 200) {
        // Successful signup
        print('Signup successful');
        // Add navigation logic here if needed
      } else {
        // Handle unsuccessful signup
        print('Signup failed: ${response.body}');
        // You might want to display an error message to the user
      }
    } catch (error) {
      // Handle network or other errors
      print('Error during signup: $error');
    }
  }
}
