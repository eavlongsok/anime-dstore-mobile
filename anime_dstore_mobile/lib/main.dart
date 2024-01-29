// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:anime_dstore_mobile/item_detail.dart';
import 'package:anime_dstore_mobile/profile_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define your custom color
    Color myPrimaryColor = const Color.fromRGBO(255, 0, 128, 1.0);

    Color mySecondaryColor = const Color.fromRGBO(20, 20, 20, 1.0);
    return MaterialApp(
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
              children: <Widget>[
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
                Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Column(
                          children: [
                            CartItem(
                              itemName: "Cosplay Costume New Quality",
                              category: "Cosplay",
                              price: 48.56,
                              quantity: 3,
                            ),
                            CartItem(
                              itemName: "Cosplay Costume New Quality",
                              category: "Cosplay",
                              price: 48.56,
                              quantity: 3,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Total: ",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontFamily: "Raleway",
                                  fontSize: 20),
                            ),
                            const Text(
                              "\$45.23",
                              style: TextStyle(
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
                            // Add your button action here
                            print('Elevated Button Pressed');
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
                                    'Check Out',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: "Raleway"),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: MySearchBar(),
              ),
              Categories(),
              Padding(
                padding: EdgeInsets.all(16),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text(
                    "All Products",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Raleway",
                        fontSize: 18),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: MyGrid(),
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
            // Navigate to the home page
            // Example: Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            // Navigate to the profile page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
          // Update the current index
          _currentIndex = index;
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
  }
}

class CartItem extends StatelessWidget {
  final String itemName;
  final String category;
  final double price;
  final int quantity;

  const CartItem({
    super.key,
    required this.itemName,
    required this.category,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show the bottom sheet for editing the quantity
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
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
                            icon: const Icon(Icons.remove, color: Colors.white),
                            onPressed: () {
                              // Add your plus button action here
                              print('Minus Button Pressed');
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
                              "3",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.primary),
                            )),
                        const SizedBox(
                          width: 12,
                        ),
                        Container(
                          color: Theme.of(context).colorScheme.primary,
                          child: IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              // Add your plus button action here
                              print('Plus Button Pressed');
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
                        // Add your button action here
                        print('Outline Button Pressed');
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
                          borderRadius:
                              BorderRadius.circular(6), // Set the border radius
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                        // Add your button action here
                        print('Elevated Button Pressed');
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
          },
        );
      },
      child: Row(
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
      ),
    );
  }
}

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[200],
      ),
      child: const TextField(
        decoration: InputDecoration(
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
      ),
    );
  }
}

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isExpanded = false;
  Map<String, bool> categoryToggles = {
    "Figure": false,
    "Cosplay": false,
    "Apparel": false,
    "Accessory": false,
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
                buildCategory("Figure", 'assets/figure.png'),
                const SizedBox(width: 8),
                buildCategory("Cosplay", 'assets/cosplay.png'),
                const SizedBox(width: 8),
                buildCategory("Apparel", 'assets/apparel.png'),
                const SizedBox(width: 8),
                buildCategory("Accessory", 'assets/accessory.png'),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildCategory(String categoryName, String imagePath) {
    bool isToggled = categoryToggles[categoryName]!;
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              categoryToggles[categoryName] = !isToggled;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: isToggled
                  ? Border.all(
                      color: Theme.of(context).colorScheme.primary, width: 2.0)
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
          categoryName,
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
  }
}

class MyGrid extends StatelessWidget {
  const MyGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 8.0, // Spacing between columns
            mainAxisSpacing: 8.0, // Spacing between rows
            childAspectRatio: 1 / 1.5),
        itemCount: 10, // Number of items in the grid
        // You can replace this container with your own widget
        itemBuilder: (BuildContext context, int index) {
          // You can replace this container with your own widget
          return InkWell(
            onTap: () {
              // Navigate to the ItemDetailPage and pass necessary parameters
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailPage(
                    itemName:
                        "Cosplay Costume New Quality", // Replace with actual data
                    itemImage: 'assets/cosplay.png', // Replace with actual data
                    itemPrice: 45.77, // Replace with actual data
                  ),
                ),
              );
            },
            child: const MyItem(),
          );
        });
  }
}

class MyItem extends StatelessWidget {
  const MyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(children: [
            AspectRatio(
              aspectRatio: 1 / 1.1, // Set your desired aspect ratio here
              child: Image.asset(
                width: 100,
                'assets/cosplay.png',
                fit: BoxFit.cover, // Adjust the fit property as needed
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(4),
              child: Column(children: [
                Text(
                  "Cosplay Costume New Quality",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center, // Set text alignment to center
                ),
                Text(
                  "\$45.77",
                  style: TextStyle(fontSize: 14, fontFamily: "Raleway"),
                  textAlign: TextAlign.center, // Set text alignment to center
                ),
              ]),
            )
          ]),
        ));
  }
}
