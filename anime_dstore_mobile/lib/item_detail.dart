// ignore_for_file: avoid_print

import 'package:anime_dstore_mobile/login.dart';
import 'package:anime_dstore_mobile/main.dart';
import 'package:anime_dstore_mobile/models/item.dart';
import 'package:anime_dstore_mobile/models/cart.dart';
import 'package:anime_dstore_mobile/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDetailPage extends StatefulWidget {
  final Item item;

  const ItemDetailPage({
    super.key,
    required this.item,
  });

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  late Cart currentItem;

  @override
  void initState() {
    super.initState();
    final provider = context.read<AppProvider>();
    if (provider.isItemInCart(widget.item.id)) {
      currentItem = provider.getCartItem(widget.item.id);
    } else {
      currentItem = Cart(item: widget.item, quantity: 1);
    }
  }

  void increaseQuantity() {
    setState(() {
      currentItem.quantity++;
    });
  }

  void decreaseQuantity() {
    setState(() {
      if (currentItem.quantity > 1) {
        currentItem.quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, appProvider, child) {
      return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
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
                      widget.item.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.item.name,
                    style: const TextStyle(
                        fontSize: 32,
                        fontFamily: "BebasNeue",
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${widget.item.price}',
                    style: const TextStyle(
                        fontSize: 24,
                        fontFamily: "Raleway",
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        Text(
                          widget.item.description,
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
                            decreaseQuantity();

                            if (appProvider.isItemInCart(currentItem.item.id)) {
                              appProvider.updateCart(
                                  currentItem, UpdateCartType.updateQuantity);
                            }
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
                            currentItem.quantity.toString(),
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
                            increaseQuantity();

                            if (appProvider.isItemInCart(currentItem.item.id)) {
                              appProvider.updateCart(
                                  currentItem, UpdateCartType.updateQuantity);
                            }
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
                      if (appProvider.isLoggedIn() == false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                        return;
                      }

                      final updateType =
                          appProvider.isItemInCart(currentItem.item.id)
                              ? UpdateCartType.removeItem
                              : UpdateCartType.addItem;

                      appProvider.updateCart(currentItem, updateType);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          content: Text(
                              appProvider.isItemInCart(currentItem.item.id)
                                  ? 'Item added to cart'
                                  : 'Item removed from cart',
                              style: TextStyle(color: Colors.white)),
                          duration: const Duration(seconds: 2),
                        ),
                      );

                      if (updateType == UpdateCartType.addItem) {
                        Navigator.pop(context);
                      }
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
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              appProvider.isItemInCart(currentItem.item.id)
                                  ? 'Remove From Cart'
                                  : 'Add To Cart',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
