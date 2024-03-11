import 'package:flutter/material.dart';
import 'package:lista_de_compras/models/item_list.model.dart';
import 'package:lista_de_compras/models/shopping_list.model.dart';
import 'package:lista_de_compras/widgets/add_item.widget.dart';

class ItensListPage extends StatefulWidget {
  final ShoppingList shoppingList;
  const ItensListPage({super.key, required this.shoppingList});

  @override
  State<ItensListPage> createState() => _ItensListPageState();
}

class _ItensListPageState extends State<ItensListPage> {
  final List<ItemList> itens = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      itens.addAll(widget.shoppingList.itens);
    });
  }

  double calculateBuyedItens() {
    return itens
        .where((i) => i.buyed)
        .map((i) => i.price)
        .fold(0, (total, next) => total + next);
  }

  double calculateNotBuyedItens() {
    return itens
        .where((i) => !i.buyed)
        .map((i) => i.price)
        .fold(0, (total, next) => total + next);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          TextButton(
            key: const Key("updateListBtn"),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.white30),
            ),
            onPressed: () {
              Navigator.of(context).pop(itens);
            },
            child: const Text(
              "Atualizar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            ListView.builder(
              itemCount: itens.length,
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                final item = itens[index];
                return Row(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: SizedBox(
                        width: 25,
                        child: Checkbox(
                          key: const Key("productCheckbox"),
                          value: item.buyed,
                          shape: const CircleBorder(),
                          side: const BorderSide(color: Colors.blue),
                          checkColor: Colors.white,
                          activeColor: Colors.green,
                          onChanged: (_) {
                            setState(() {
                              item.toggleBuyed();
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: item.buyed ? Colors.grey : Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "R\$ ${item.price}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                );
              },
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Não marcados"),
                    Text(
                      "R\$ ${calculateNotBuyedItens().toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Marcados"),
                    Text(
                      "R\$ ${calculateBuyedItens().toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key("addNewItemBtn"),
        onPressed: () async {
          final newItem = await showModalBottomSheet<ItemList>(
            isScrollControlled: true,
            context: context,
            builder: (ctx) => const AddItem(),
          );

          if (newItem != null) {
            setState(() {
              itens.add(newItem);
            });
          }
        },
        label: const Text("Adicionar"),
      ),
    );
  }
}
