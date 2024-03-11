import 'item_list.model.dart';

class ShoppingList {
  String name;
  List<ItemList> items;

  ShoppingList({
    required this.name,
  }) : items = [];

  int get qtdBuyedItems {
    return items.where((item) => item.buyed).length;
  }
}
