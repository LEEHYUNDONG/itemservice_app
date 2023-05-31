import 'package:http/http.dart' as http;
import 'dart:convert';

class Item {
  final String itemName;
  final int price;
  final int quantity;

  Item({required this.itemName, required this.price, required this.quantity});

  factory Item.fromJson(Map<String, dynamic> itemMap) {
    return Item(
      itemName: itemMap['itemName'],
      price: itemMap['price'],
      quantity: itemMap['quantity'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'itemName': itemName, 'price': price, 'quantity': quantity};
}

Future<List<Item>> fetchItem() async {
  String itemListUrl = 'http://localhost:8080/basic/items';
  final resp = await http.get(Uri.parse(itemListUrl));
  if (resp.statusCode == 200) {
    var list = json.decode(resp.body).cast<Map<String, dynamic>>();
    var itemList = list.map<Item>((json) => Item.fromJson(json)).toList();

    return itemList;
  } else {
    print(resp.statusCode);
    throw 'Error Occured';
  }
}
