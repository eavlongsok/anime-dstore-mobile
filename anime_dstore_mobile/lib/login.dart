// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:anime_dstore_mobile/main.dart';
import 'package:anime_dstore_mobile/models/user.dart';
import 'package:anime_dstore_mobile/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, child) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                onChanged: (value) => email = value,
                decoration: const InputDecoration(
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
              child: TextField(
                onChanged: (value) => password = value,
                decoration: const InputDecoration(
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
                login(email, password).then((value) => {
                      if (value.email.isNotEmpty && value.id > 0)
                        {
                          appProvider.setUser(value),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage()),
                          )
                        }
                    });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.primary, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(6), // Set the border radius
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()),
                    );
                  },
                  child: Text(
                    'Shop as Guest',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                        fontFamily: "Raleway"),
                  ),
                )
              ],
            )
          ]),
        ),
      );
    });
  }
}
