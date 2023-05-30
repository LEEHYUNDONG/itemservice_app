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
      title: 'Order',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Item Order Service'),
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
      ),
      body: Center(
          child: FutureBuilder<List<Item>>(
        future: fetchItem(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data!.first.itemName);
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  // Item item = snapshot.data!.elementAt(index);

                  return Card(
                    child: Text('$snapshot.data[index]'),
                  );
                });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      )),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
    //     return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //       child: FutureBuilder<List<Item>>(
    //     future: itemLst,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         print(snapshot.data!.first.itemName);
    //         return ListView.builder(
    //             itemCount: snapshot.data?.length,
    //             itemBuilder: (context, index) {
    //               // Item item = snapshot.data!.elementAt(index);

    //               return Card(
    //                 child: Text('$itemLst[index]'),
    //               );
    //             });
    //       } else if (snapshot.hasError) {
    //         return Text("${snapshot.error}");
    //       }
    //       return CircularProgressIndicator();
    //     },
    //   )),
    //   // floatingActionButton: FloatingActionButton(
    //   //   onPressed: _incrementCounter,
    //   //   tooltip: 'Increment',
    //   //   child: const Icon(Icons.add),
    //   // ),
    // );
  }
}
