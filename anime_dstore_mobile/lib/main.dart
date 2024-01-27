import 'package:anime_dstore_mobile/item_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

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
            IconButton(
              onPressed: () {
                // Add your button action here
                print('Button Pressed');
              },
              icon: Image.asset(
                'assets/logo.png', // Replace with the path to your image
                width: 42.0, // Adjust the width as needed
                height: 42.0, // Adjust the height as needed
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: MySearchBar(),
                ),
                Categories(),
                Padding(
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: MyGrid(),
                )
              ],
            ),
          ),
        ));
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
      child: TextField(
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
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
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
                  Text(
                    "Categories",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Raleway",
                        fontSize: 18),
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
            SizedBox(height: 8),
            if (isExpanded)
              Row(
                children: [
                  buildCategory("Figure", 'assets/figure.png'),
                  SizedBox(width: 8),
                  buildCategory("Cosplay", 'assets/cosplay.png'),
                  SizedBox(width: 8),
                  buildCategory("Apparel", 'assets/apparel.png'),
                  SizedBox(width: 8),
                  buildCategory("Accessory", 'assets/accessory.png'),
                ],
              ),
          ],
        ),
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
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
            child: MyItem(),
          );
        });
  }
}

class MyItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(4),
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
            Padding(
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
