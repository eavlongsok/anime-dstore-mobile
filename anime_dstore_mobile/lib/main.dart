// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:anime_dstore_mobile/item_detail.dart';
import 'package:anime_dstore_mobile/login.dart';
import 'package:anime_dstore_mobile/models/item.dart';
import 'package:anime_dstore_mobile/models/cart.dart';
import 'package:anime_dstore_mobile/models/user.dart';
import 'package:anime_dstore_mobile/profile_page.dart';
import 'package:anime_dstore_mobile/utils/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProvider extends ChangeNotifier {
  String query = "";
  List<dynamic> selectedCategories = [];
  late Future<List<Item>> items = getItem(query, selectedCategories);

  User user = const User(email: "", id: -1);

  Set<Cart> carts = {};

  void setQuery(String value) async {
    query = value;
    items = getItem(query, selectedCategories);
    notifyListeners();
  }

  void setUser(User value) {
    user = value;
    notifyListeners();
  }

  bool isLoggedIn() {
    return user.email.isNotEmpty;
  }

  void setCategory(int value) {
    if (selectedCategories.contains(value)) {
      selectedCategories.remove(value);
    } else {
      selectedCategories.add(value);
    }

    items = getItem(query, selectedCategories);
    notifyListeners();
  }

  bool isItemInCart(int id) {
    for (final cart in carts) {
      if (cart.item.id == id) {
        return true;
      }
    }

    return false;
  }

  Cart getCartItem(int id) {
    for (final cart in carts) {
      if (cart.item.id == id) {
        return cart;
      }
    }

    return Cart(
        item: const Item(
            id: -1,
            name: "",
            price: "",
            image: "",
            category: -1,
            description: ""),
        quantity: 0);
  }

  void updateCart(Cart item, UpdateCartType type) {
    switch (type) {
      case UpdateCartType.updateQuantity:
        for (final cart in carts) {
          if (cart.item.id == item.item.id) {
            cart.quantity = item.quantity;
          }
        }
        break;
      case UpdateCartType.removeItem:
        carts.remove(item);
        break;
      case UpdateCartType.addItem:
        carts.add(item);
        break;
    }

    notifyListeners();
  }

  double calculateTotal() {
    double cartTotal = 0;
    for (final cart in carts) {
      cartTotal += double.parse(cart.item.price) * cart.quantity;
    }

    return cartTotal;
  }
}

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define your custom color
    Color myPrimaryColor = const Color.fromRGBO(255, 0, 128, 1.0);

    Color mySecondaryColor = const Color.fromRGBO(20, 20, 20, 1.0);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Use colorScheme to define custom colors
        colorScheme: ColorScheme.light(
          primary: myPrimaryColor,
          background: mySecondaryColor,
          // You can customize other color properties here
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Theme.of(context).colorScheme.background,
            title: const Text(
              'Anime D. Store',
              style: TextStyle(
                  color: Colors.white, fontFamily: "BebasNeue", fontSize: 42),
            ),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    // This is for the purple carts icon in the app bar
                    // Checking carts requires user to be logged in
                    if (appProvider.isLoggedIn() == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                      return;
                    }

                    // Open the drawer when the IconButton is pressed
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Image.asset(
                    'assets/logo.png',
                    width: 42.0,
                    height: 42.0,
                  ),
                ),
              ),
            ],
          ),
          endDrawer: Drawer(
              width: double.infinity,
              // Add the Drawer widget here
              child: Container(
                color: Theme.of(context).colorScheme.background,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                        color: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "CART",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontFamily: 'BebasNeue'),
                            ),
                            Builder(
                              builder: (context) => IconButton(
                                onPressed: () {
                                  // Open the drawer when the IconButton is pressed
                                  Scaffold.of(context).closeEndDrawer();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                          ],
                        )),
                    Builder(builder: (context) {
                      if (appProvider.carts.isEmpty) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Column(
                              children: [
                                const Text('No items in cart',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Raleway",
                                        fontSize: 18)),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primary, // Text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          6), // Set the border radius
                                    ),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8),
                                    child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Browse Item',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: "Raleway"),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                  children: appProvider.carts
                                      .map((item) => CartItem(cartItem: item))
                                      .toList()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Total: ",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontFamily: "Raleway",
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "\$${appProvider.calculateTotal().toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Raleway",
                                        fontSize: 20),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Address:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Raleway",
                                    fontSize: 20),
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
                                    hintText: 'Address',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Phone:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Raleway",
                                    fontSize: 20),
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
                                    hintText: '+855 24 4535 333',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (appProvider.isLoggedIn() == false) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                    );
                                    return;
                                  }

                                  checkout(appProvider.carts,
                                          appProvider.user.id)
                                      .then((checkOutSuccess) => {
                                            if (checkOutSuccess)
                                              {
                                                appProvider.carts.clear(),
                                                _checkOutDialog(context)
                                              }
                                          });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primary, // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        6), // Set the border radius
                                  ),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Checkout',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: "Raleway"),
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ));
                    })
                  ],
                ),
              )),
          body: SingleChildScrollView(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: MySearchBar(),
                  ),
                  const Categories(),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "All Products",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Raleway",
                                fontSize: 18),
                          ),
                        ]),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: MyItems(),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              // Handle navigation or other actions based on the selected index
              if (index == 0) {
                // Update the current index
                _currentIndex = index;
                // pass
              } else if (index == 1) {
                if (appProvider.isLoggedIn() == false) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                  return;
                }

                // Navigate to the profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              }
            },
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 32,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 32,
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }

  void _checkOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          surfaceTintColor: Colors.transparent,
          title: const Text(
            'Check Out Success',
            style: TextStyle(
                color: Colors.white, fontFamily: "Raleway", fontSize: 24),
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Your order has been placed successfully.',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Raleway",
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          content: const Text(
                              "Order placed successfully, Thanks for shopping with us!",
                              style: TextStyle(color: Colors.white)),
                          duration: const Duration(seconds: 3),
                        ),
                      );

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()),
                        (Route<dynamic> route) => false,
                      );
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
                              'OK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Raleway"),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class CartItem extends StatelessWidget {
  final Cart cartItem;

  const CartItem({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, child) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: GestureDetector(
          onTap: () {
            // Show the bottom sheet for editing the quantity
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                // use stateful builder to update the quantity modal state otherwise the quantity will not update the ui
                return StatefulBuilder(builder: (context, setModalState) {
                  return Container(
                      color: Theme.of(context).colorScheme.background,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: Theme.of(context).colorScheme.primary,
                                child: IconButton(
                                  icon: const Icon(Icons.remove,
                                      color: Colors.white),
                                  onPressed: () {
                                    if (cartItem.quantity > 1) {
                                      setModalState(() {
                                        cartItem.quantity -= 1;
                                      });
                                    }

                                    appProvider.updateCart(cartItem,
                                        UpdateCartType.updateQuantity);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  color: Colors.white,
                                  child: Text(
                                    cartItem.quantity.toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  )),
                              const SizedBox(
                                width: 12,
                              ),
                              Container(
                                color: Theme.of(context).colorScheme.primary,
                                child: IconButton(
                                  icon: const Icon(Icons.add,
                                      color: Colors.white),
                                  onPressed: () {
                                    setModalState(() {
                                      cartItem.quantity += 1;
                                    });

                                    // Update the cart
                                    appProvider.updateCart(cartItem,
                                        UpdateCartType.updateQuantity);
                                  },
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              appProvider.updateCart(
                                  cartItem, UpdateCartType.removeItem);
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary, // Change this color to the desired border color
                                width: 2.0, // You can adjust the border width
                              ),
                              // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    6), // Set the border radius
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Remove',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontFamily: "Raleway",
                                          fontSize: 20),
                                    ),
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primary, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    6), // Set the border radius
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Confirm',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: "Raleway"),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ));
                });
              },
            );
          },
          child: Row(
            children: [
              Image.network(
                cartItem.item.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250, // Adjust the width as needed
                      child: Text(
                        cartItem.item.name,
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
                          categories[cartItem.item.category]!,
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
                          "\$${cartItem.item.price}",
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
                          cartItem.quantity.toString(),
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
        ),
      );
    });
  }
}

// ignore: must_be_immutable
class MySearchBar extends StatelessWidget {
  MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, child) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[200],
        ),
        child: TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 30,
              minHeight: 20,
            ),
            isDense: true,
            hintText: 'Search...',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          ),
          onChanged: (String value) {
            EasyDebounce.debounce(
                'searchDebounce',
                const Duration(milliseconds: 200),
                () => appProvider.setQuery(value));
          },
        ),
      );
    });
  }
}

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isExpanded = false;
  Map<int, bool> categoryToggles = {
    1: false,
    2: false,
    3: false,
    4: false,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(
                      color: Colors.white, fontFamily: "Raleway", fontSize: 18),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (isExpanded)
            Row(
              children: [
                buildCategory('assets/figure.png', 1),
                const SizedBox(width: 8),
                buildCategory('assets/cosplay.png', 2),
                const SizedBox(width: 8),
                buildCategory('assets/apparel.png', 3),
                const SizedBox(width: 8),
                buildCategory('assets/accessory.png', 4),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildCategory(String imagePath, int id) {
    bool isToggled = categoryToggles[id]!;
    return Consumer<AppProvider>(builder: (context, appProvider, child) {
      return Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                categoryToggles[id] = !isToggled;
              });

              EasyDebounce.debounce(
                  'category',
                  const Duration(milliseconds: 200),
                  () => appProvider.setCategory(id));
            },
            child: Container(
              decoration: BoxDecoration(
                border: isToggled
                    ? Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0)
                    : Border.all(color: Colors.transparent, width: 2.0),
              ),
              child: Image.asset(
                imagePath,
                width: 80.0,
                height: 80.0,
              ),
            ),
          ),
          Text(
            categories[id]!,
            style: TextStyle(
              color: isToggled
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              fontFamily: "Raleway",
              fontSize: 16,
            ),
          ),
        ],
      );
    });
  }
}

class MyItems extends StatelessWidget {
  const MyItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, child) {
      return FutureBuilder<List<Item>>(
        future: appProvider.items,
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
                child: Text('No data found',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Raleway",
                        fontSize: 18)),
              );
            }

            return GridView.count(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 8.0, // Spacing between columns
                mainAxisSpacing: 8.0, // Spacing between rows
                childAspectRatio: 1 / 1.5,
                children:
                    snapshot.data!.map((item) => MyItem(item: item)).toList());
          } else {
            return const Center(
              child: Text('No data found',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Raleway",
                      fontSize: 18)),
            );
          }
        },
      );
    });
  }
}

class MyItem extends StatelessWidget {
  final Item item;
  const MyItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemDetailPage(
                    item: item,
                  )),
        );
      },
      child: Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(children: [
              AspectRatio(
                aspectRatio: 1 / 1.1, // Set your desired aspect ratio here
                child: Image.network(
                  width: 100,
                  item.image,
                  fit: BoxFit.cover, // Adjust the fit property as needed
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Column(children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center, // Set text alignment to center
                  ),
                  Text(
                    "\$${item.price}",
                    style: const TextStyle(fontSize: 14, fontFamily: "Raleway"),
                    textAlign: TextAlign.center, // Set text alignment to center
                  ),
                ]),
              )
            ]),
          )),
    );
  }
}
