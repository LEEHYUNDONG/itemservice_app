# itemservice_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


---

<br>


### fromJson()

```dart
// /data/model/item.dart

  factory Item.fromJson(Map<String, dynamic> itemMap) {
    return Item(
      itemName: itemMap['itemName'],
      price: itemMap['price'],
      quantity: itemMap['quantity'],
    );
  }
```
위 코드는 서버와 통신할때 JSON 형식으로 통신을 하게 되는데, 이떄 String 값을 Map 자료형으로 매핑해서 생성된 객체를 반환하는 함수입니다. 여기서 눈여겨 볼 점은 `factory` 라는 예약어 입니다.

Factory는 싱글톤 패턴을 사용할 때 쓰는데요. 싱글톤 패턴은 쉽게 말해 여러번 호출해도 초기에 만들어진 하나의 생성된 객체만 이용하게 해주는 디자인 패턴이라고 생각하시면 됩니다. 뿐만 아니라 factory는 static의 효과도 있어 객체를 생성하지 않고 호출해도 되기 때문에 import해서 바로 사용할 수 있습니다.

### 서버와의 통신

Flutter에서 서버와 통신하는 부분이 매우 간단 한데요.
```dart
Future<List<Item>> fetchItem() async {
  String itemListUrl = 'http://localhost:8080/basic/items';
  final resp = await http.get(Uri.parse(itemListUrl));
                        .
                        .
}
```

`http` 키워드를 활용하여 뒤에 참조 방식으로 method를 붙여 사용하면 됩니다. 이후에 전달받은 `response`를 통해 `status`의 여부에 따라 데이터를 casting 하여 사용하면 됩니다.
전달받은 데이터를 이제 Flutter의 Widget을 이용하여 화면에 보여주면 됩니다.

실제로 간단하게 개발한 애플리케이션에서 item을 추가하기 전 @PostConstruct를 사용하여 2개의 item을 삽입해준 화면과 item을 2개 삽입했을 때 화면의 변화를 알아보겠습니다.

