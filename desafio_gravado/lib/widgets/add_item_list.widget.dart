import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_cart/models/item_list.model.dart';

class AddItemList extends StatefulWidget {
  const AddItemList({super.key});

  @override
  State<AddItemList> createState() => _AddItemListState();
}

class _AddItemListState extends State<AddItemList> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<void> addItem() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    var price = 0.0;

    if (priceController.text.isNotEmpty) {
      price = double.parse(
        priceController.text.replaceAll(".", "").replaceAll(",", "."),
      );
    }

    final newItem = ItemList(
      name: nameController.text,
      price: price,
    );

    Navigator.of(context).pop(newItem);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
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
                    "Adicionar item",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 2,
                height: 0,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: "Nome do item",
                  border: InputBorder.none,
                ),
                cursorColor: Colors.blue,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Campo Obrigatório";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "R\$ 0,00",
                  border: InputBorder.none,
                ),
                cursorColor: Colors.blue,
                inputFormatters: [
                  CurrencyTextInputFormatter(locale: "pt_BR", symbol: ""),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: addItem,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "Adicionar",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
