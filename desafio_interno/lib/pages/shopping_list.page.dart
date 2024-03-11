import 'package:flutter/material.dart';
import 'package:lista_de_compras/models/item_list.model.dart';
import 'package:lista_de_compras/models/shopping_list.model.dart';
import 'package:lista_de_compras/pages/create_list.page.dart';
import 'package:lista_de_compras/pages/itens_list.page.dart';

import '../widgets/empty_shopping_list.widget.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final List<ShoppingList> shoppingLists = [];

  void updateShoppingList(int index) async {
    final itens = await Navigator.of(context).push<List<ItemList>>(
      MaterialPageRoute(
        builder: (_) => ItensListPage(
          shoppingList: shoppingLists[index],
        ),
      ),
    );

    if (itens != null) {
      setState(() {
        shoppingLists[index].itens = itens;
      });
    }
  }

  void addShoppingList() async {
    final shoppingListName = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => const CreateListPage(),
      ),
    );

    if (shoppingListName != null) {
      setState(() {
        shoppingLists.add(ShoppingList(name: shoppingListName));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Minhas listas",
          key: Key("appBarTitle"),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.diamond,
              color: Colors.amber,
              size: 30,
            ),
          )
        ],
      ),
      body: shoppingLists.isEmpty
          ? const EmptyShoppingList()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              itemCount: shoppingLists.length,
              itemBuilder: (ctx, index) {
                final shoppingList = shoppingLists[index];
                return InkWell(
                  key: const Key("shoppingListCard"),
                  onTap: () => updateShoppingList(index),
                  child: Card(
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
                              Text(shoppingList.name),
                              Text(
                                "${shoppingList.qtdBuyedItens}/${shoppingList.itens.length}",
                                style: const TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          LinearProgressIndicator(
                            value: shoppingList.itens.isNotEmpty
                                ? shoppingList.qtdBuyedItens /
                                    shoppingList.itens.length
                                : 0,
                            color: Colors.green,
                            backgroundColor: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        key: const Key("addListBtn"),
        onPressed: addShoppingList,
        child: const Icon(Icons.add),
      ),
    );
  }
}
