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
    // var itemLst = jsonDecode(resp.body);
    var list = jsonDecode(resp.body);
    var itemLst = list.map((element) => Item.fromJson(element)).toList();
    print(list);
    print(itemLst[0].itemName);
    print(itemLst.runtimeType);
    print(list.runtimeType);
    return list;
  } else {
    print(resp.statusCode);
    throw 'Error Occured';
  }
}
