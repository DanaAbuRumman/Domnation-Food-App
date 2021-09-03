class Farm {
  String? id;
  List images = [];
  double? lat;
  double? lng;
  String? describe;
  String? phone;
  String? title;
  double? price;
  String? user_phone;
  Farm();
  Farm.fromJson(Map<String, dynamic> json)
      : images = json['images'] ?? [],
        lat = json['lat'] ?? 0.0,
        lng = json['lng'] ?? 0.0,
        describe = json['describe'] ?? "",
        id = json['id'] ?? "",
        title = json['title'] ?? "",
        price = json['price'] ?? "",
        user_phone = json['user_phone'],
        phone = json['phone'] ?? "";

  Map<String, dynamic> toJson() => {
        'images': images,
        'describe': describe,
        'lat': lat,
        'lng': lng,
        'user_phone': user_phone,
        'price': price,
        'phone': phone,
        'id': id,
        'title': title
      };
}
