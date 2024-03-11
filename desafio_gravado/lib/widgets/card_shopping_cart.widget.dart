import 'package:flutter/material.dart';
import 'package:shopping_cart/models/shopping_list.model.dart';

class CardShoppingCart extends StatelessWidget {
  final ShoppingList shoppingList;
  const CardShoppingCart({super.key, required this.shoppingList});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shoppingList.name,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "${shoppingList.qtdBuyedItems}/${shoppingList.items.length}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            LinearProgressIndicator(
              backgroundColor: Colors.grey,
              value: shoppingList.items.isEmpty
                  ? 0
                  : (shoppingList.qtdBuyedItems / shoppingList.items.length),
              minHeight: 6,
            ),
          ],
        ),
      ),
    );
  }
}
