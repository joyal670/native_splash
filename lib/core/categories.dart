// class Category {
//   final List<String> items;

//   Category({required this.items});

//   factory Category.fromJson(List<String> json) {
//     return Category(items: json);
//   }
// }

class Category {
  final String items;

  Category({required this.items});

  factory Category.fromJson(String json) {
    return Category(items: json);
  }
}
