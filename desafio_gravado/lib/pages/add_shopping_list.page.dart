import 'package:flutter/material.dart';

class AddShoppingListPage extends StatefulWidget {
  const AddShoppingListPage({super.key});

  @override
  State<AddShoppingListPage> createState() => _AddShoppingListPageState();
}

class _AddShoppingListPageState extends State<AddShoppingListPage> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Nome da lista",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    cursorColor: Colors.blue,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildCancelButton(context),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: _buildCreateButton(context),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  TextButton _buildCancelButton(BuildContext ctx) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(.1)),
      ),
      onPressed: () {
        Navigator.of(ctx).pop();
      },
      child: const Text(
        "Voltar",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  TextButton _buildCreateButton(BuildContext ctx) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
      ),
      onPressed: () {
        if (nameController.text.isNotEmpty) {
          Navigator.of(ctx).pop(nameController.text);
        }
      },
      child: const Text(
        "Criar",
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }
}
