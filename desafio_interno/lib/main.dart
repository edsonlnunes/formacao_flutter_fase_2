import 'package:flutter/material.dart';
import 'package:lista_de_compras/pages/shopping_list.page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShoppingListPage(),
    );
  }
}
