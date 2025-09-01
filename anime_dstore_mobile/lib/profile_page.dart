import 'package:anime_dstore_mobile/login.dart';
import 'package:anime_dstore_mobile/main.dart';
import 'package:anime_dstore_mobile/models/user.dart';
import 'package:anime_dstore_mobile/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<List<PurchaseHistory>> purchaseHistories;

  @override
  void initState() {
    super.initState();
    final provider = context.read<AppProvider>();
    purchaseHistories = getPurchaseHistory(provider.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, child) {
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
                    Text(
                      appProvider.user.email,
                      style: const TextStyle(
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
                        appProvider.setUser(const User(email: "", id: -1));

                        // clear the navigation stack keep only home page then navigate to login page
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
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
                FutureBuilder(
                  future: purchaseHistories,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error occurred',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Raleway",
                                fontSize: 18)),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No purchase history found',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Raleway",
                                  fontSize: 18)),
                        );
                      }

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'History',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: "Raleway",
                                ),
                              ),
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
                              ),
                            ],
                          ),
                          Column(
                              children: snapshot.data!
                                  .map((purchaseHistory) => HistoryItem(
                                      purchaseHistory: purchaseHistory))
                                  .toList()),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text('An error occurred',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Raleway",
                                fontSize: 18)),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
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
                final provider = context.read<AppProvider>();

                if (provider.isLoggedIn() == true) {
                  clearPurchaseHistory(provider.user.id).then((success) => {
                        Navigator.pop(context),
                        if (success)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                content: const Text(
                                    "History cleared successfully",
                                    style: TextStyle(color: Colors.white)),
                                duration: const Duration(seconds: 2),
                              ),
                            ),
                            setState(() {
                              purchaseHistories =
                                  getPurchaseHistory(provider.user.id);
                            })
                          }
                      });
                }
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
                // hintText: 'New Password',
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
                final provider = context.read<AppProvider>();

                if (provider.isLoggedIn() == true) {
                  changePassword(provider.user.id, newPasswordController.text)
                      .then((success) => {
                            Navigator.pop(context), // Close the dialog
                            if (success)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    content: const Text(
                                        "Password changed successfully",
                                        style: TextStyle(color: Colors.white)),
                                    duration: const Duration(seconds: 2),
                                  ),
                                )
                              }
                          });
                }
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
  final PurchaseHistory purchaseHistory;

  const HistoryItem({
    super.key,
    required this.purchaseHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Image.network(
            purchaseHistory.item.image,
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
                    purchaseHistory.item.name,
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
                      categories[purchaseHistory.item.category]!,
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
                      "\$${purchaseHistory.item.price}",
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
                      purchaseHistory.quantity.toString(),
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
      ),
    );
  }
}
