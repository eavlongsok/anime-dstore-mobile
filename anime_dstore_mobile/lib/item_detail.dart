// ignore_for_file: avoid_print

import 'package:anime_dstore_mobile/models/Items.dart';
import 'package:flutter/material.dart';

class ItemDetailPage extends StatelessWidget {
  final Items item;

  const ItemDetailPage({
    super.key,
    required this.item,
  });

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                    item.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  item.name,
                  style: const TextStyle(
                      fontSize: 32,
                      fontFamily: "BebasNeue",
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${item.price}',
                  style: const TextStyle(
                      fontSize: 24, fontFamily: "Raleway", color: Colors.white),
                ),
                const SizedBox(height: 8),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Description",
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Text(
                    item.description,
                    style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 18,
                        color: Colors.white),
                  )
                ]),
                const SizedBox(height: 16),
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
                            'Add To Cart',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
