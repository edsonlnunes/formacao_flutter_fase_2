import 'package:lista_de_compras/models/item_list.model.dart';

class ShoppingList {
  String name;
  List<ItemList> itens;

  ShoppingList({
    required this.name,
  }) : itens = [];

  int get qtdBuyedItens {
    return itens.where((i) => i.buyed).length;
  }
}
