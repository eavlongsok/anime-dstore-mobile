// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:anime_dstore_mobile/login.dart';
import 'package:anime_dstore_mobile/main.dart';
import 'package:anime_dstore_mobile/models/user.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String emailErrorMessage = "";
  String passwordErrorMessage = "";

  // dispose is used to clean up resources
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        emailErrorMessage = "Email is required";
      });
      return false;
    }

    if (!value.contains("@")) {
      setState(() {
        emailErrorMessage = "Email is invalid";
      });
      return false;
    }

    setState(() {
      emailErrorMessage = "";
    });
    return true;
  }

  bool validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        passwordErrorMessage = "Password is required";
      });
      return false;
    }

    setState(() {
      passwordErrorMessage = "";
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(
            height: 84,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                width: 80,
              ),
            ],
          ),
          const SizedBox(
            height: 84,
          ),
          const Text(
            "Email:",
            style: TextStyle(
                color: Colors.white, fontFamily: "Raleway", fontSize: 20),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[200],
            ),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 30,
                  minHeight: 20,
                ),
                errorText: emailErrorMessage,
                // make error outside of the input
                errorStyle: const TextStyle(height: 0),
                isDense: true,
                hintText: 'Email',
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Password:",
            style: TextStyle(
                color: Colors.white, fontFamily: "Raleway", fontSize: 20),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[200],
            ),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 30,
                  minHeight: 20,
                ),
                errorText: passwordErrorMessage,
                // make error outside of the input
                errorStyle: const TextStyle(height: 0),
                isDense: true,
                hintText: 'Password',
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
            onPressed: () {
              final String email = _emailController.text;
              final String password = _passwordController.text;

              validateEmail(email);
              validatePassword(password);

              if (emailErrorMessage.isNotEmpty ||
                  passwordErrorMessage.isNotEmpty) {
                return;
              }

              register(email, password).then((success) => {
                    if (success)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            content: const Text("User registered successfully!",
                                style: TextStyle(color: Colors.white)),
                            duration: const Duration(seconds: 2),
                          ),
                        ),
                        Navigator.pop(context),
                      }
                    else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                "Failed to register user!, try another email or password.",
                                style: TextStyle(color: Colors.white)),
                            duration: Duration(seconds: 2),
                          ),
                        ),
                      }
                  });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.primary, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6), // Set the border radius
              ),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Raleway"),
                    ),
                  ]),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Login',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18,
                  fontFamily: "Raleway"),
            ),
          )
        ]),
      ),
    );
  }
}
