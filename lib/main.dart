import 'package:flutter/material.dart';
import 'package:itemservice_app/ui/item_list.dart';
import 'package:itemservice_app/data/model/item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // disable debug banner
      debugShowCheckedModeBanner: false,
      title: 'Order',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '상품 목록'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Item>> itemLst;

  @override
  void initState() {
    super.initState();
    itemLst = fetchItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Center(
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: FutureBuilder(
                  future: fetchItem(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            // loop through the list of snapshot.data
                            List<Item> itemLst = snapshot.data as List<Item>;
                            // return ListTile
                            return ListTile(
                              title: Text(itemLst[index].itemName),
                              subtitle: Text(itemLst[index].price.toString()),
                              trailing:
                                  Text(itemLst[index].quantity.toString()),
                            );
                          },
                          // Vertical viewport was given unbounded height error fix (below 2 lines)
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // OutlinedButton(
                  //   onPressed: () => _updateItem(),
                  //   child: Text("상품수정"),
                  // ),
                  OutlinedButton(
                    onPressed: () => _addItem(),
                    child: Text("상품등록"),
                  )
                ],
              )
            ],
          )),
        ));
  }
}

_addItem() {}

_updateItem() {}
