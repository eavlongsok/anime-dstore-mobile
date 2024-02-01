import 'package:anime_dstore_mobile/login.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account Info",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontFamily: "Raleway",
                ),
              ),
              Row(
                children: [
                  Text(
                    "Email: ",
                    style: TextStyle(
                      fontFamily: "Raleway",
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const Text(
                    "depresso@gmail.com",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Raleway",
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showChangePasswordDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Change Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "Raleway",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontFamily: "Raleway",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: "Raleway",
                ),
              ),
              const Column(children: [
                Column(
                  children: [
                    HistoryItem(
                      itemName: "Cosplay Costume New Quality adadad",
                      category: "Cosplay",
                      price: 48.56,
                      quantity: 3,
                    ),
                    HistoryItem(
                      itemName: "Cosplay Costume New Quality adadad",
                      category: "Cosplay",
                      price: 48.56,
                      quantity: 3,
                    )
                  ],
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showConfirmClearHistory(
                          context); //Change to show confirm clear history
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Clear History',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontFamily: "Raleway",
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmClearHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // alert dialog is considered as input dialog
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          surfaceTintColor: Colors.transparent,
          title: const Text(
            "Clear History",
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          content: const Text(
            "Are you sure you want to clear your history?",
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Validate and handle password change logic here
                //String newPassword = newPasswordController.text;

                // Implement your logic here

                Navigator.pop(context); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "Raleway",
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to show the change password dialog
  void _showChangePasswordDialog(BuildContext context) {
    TextEditingController newPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // alert dialog is considered as input dialog
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          surfaceTintColor: Colors.transparent,
          title: const Text(
            "Change Password",
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[200],
            ),
            child: TextField(
              controller: newPasswordController,
              decoration: const InputDecoration(
                labelText: "New Password",
                isDense: true,
                hintText: '+855 24 4535 333',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 8,
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Validate and handle password change logic here
                //String newPassword = newPasswordController.text;

                // Implement your logic here

                Navigator.pop(context); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "Raleway",
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String itemName;
  final String category;
  final double price;
  final int quantity;

  const HistoryItem({
    super.key,
    required this.itemName,
    required this.category,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/cosplay.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 250, // Adjust the width as needed
                child: Text(
                  itemName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Raleway",
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Category: ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Raleway",
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Price: ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Raleway",
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Quantity: ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Raleway",
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
