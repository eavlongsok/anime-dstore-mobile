// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:anime_dstore_mobile/main.dart';
import 'package:anime_dstore_mobile/register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            child: const TextField(
              decoration: InputDecoration(
                prefixIconConstraints: BoxConstraints(
                  minWidth: 30,
                  minHeight: 20,
                ),
                isDense: true,
                hintText: 'Email',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
            child: const TextField(
              decoration: InputDecoration(
                prefixIconConstraints: BoxConstraints(
                  minWidth: 30,
                  minHeight: 20,
                ),
                isDense: true,
                hintText: 'Password',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
            onPressed: () {
              // Add your button action here
              print('Elevated Button Pressed');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
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
                      'Login',
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Text(
              'Register',
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
