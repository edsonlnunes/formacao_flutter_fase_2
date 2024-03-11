import 'package:flutter/material.dart';

class EmptyShoppingList extends StatelessWidget {
  const EmptyShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/lista-de-compras.png",
            height: 100,
            key: const Key("emptyListImage"),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Crie sua primeira lista",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const Text(
            "Toque no botao azul",
            style: TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
