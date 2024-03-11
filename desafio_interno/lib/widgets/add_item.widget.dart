import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_compras/models/item_list.model.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  addItem() {
    if (!formKey.currentState!.validate()) return;

    var price = 0.0;

    if (priceController.text.isNotEmpty) {
      price = double.parse(
          priceController.text.replaceAll(".", "").replaceAll(",", "."));
    }

    final item = ItemList(
      name: nameController.text,
      price: price,
    );

    Navigator.of(context).pop(item);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Adicionar Item",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
              height: 0,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              key: const Key("inputItem"),
              controller: nameController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Nome do item",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Campo obrigatório";
                }
                return null;
              },
            ),
            TextField(
              key: const Key("inputValue"),
              controller: priceController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "R\$ 0,00",
              ),
              inputFormatters: [
                CurrencyTextInputFormatter(locale: "pt-BR", symbol: ""),
              ],
              keyboardType: TextInputType.number,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                key: const Key("addItemBtn"),
                onPressed: addItem,
                child: const Text("Adicionar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
