import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _fullNameController = TextEditingController();
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
              controller: _fullNameController,
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

  void _handleSignup() {
    // Implement signup logic here, using the values from the controllers
    // Example:
    // Get values from controllers
    final fullName = _fullNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    // Log the input values to the console
    print('Full Name: $fullName');
    print('Email: $email');
    print('Password: $password');

    // Validate the input fields
    // ...

    // Send the signup data to your server or perform local actions
    // ...

    // Navigate to a different screen upon successful signup
    // ...
  }
}
