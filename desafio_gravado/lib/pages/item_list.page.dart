import 'package:flutter/material.dart';
import 'package:shopping_cart/widgets/item_tile.widget.dart';

import '../models/item_list.model.dart';
import '../models/shopping_list.model.dart';
import '../widgets/add_item_list.widget.dart';
import '../widgets/summary_values.widget.dart';

class ItemListPage extends StatefulWidget {
  final ShoppingList shoppingList;

  const ItemListPage({super.key, required this.shoppingList});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  final items = <ItemList>[];

  double get calculateBuyedItem {
    return items
        .where((item) => item.buyed)
        .fold(0, (sum, next) => sum + next.price);
  }

  double get calculateNotBuyedItem {
    return items
        .where((item) => !item.buyed)
        .fold(0, (sum, next) => sum + next.price);
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      items.addAll(widget.shoppingList.items);
    });
  }

  Future<void> addNewItem() async {
    final newItem = await showModalBottomSheet<ItemList>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => const AddItemList(),
    );

    if (newItem != null) {
      setState(() {
        items.add(newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop(items);
            },
            child: const Text(
              "Atualizar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.shoppingList.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ItemTile(
                  item: item,
                  toggleCheckbox: () {
                    setState(() {
                      item.buyed = !item.buyed;
                    });
                  },
                );
              },
            ),
            SummaryValues(
              calculateNotBuyedItem: calculateNotBuyedItem,
              calculateBuyedItem: calculateBuyedItem,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: addNewItem,
        label: const Text("Adicionar"),
      ),
    );
  }
}
