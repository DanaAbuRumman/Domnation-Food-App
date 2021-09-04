class Farm {
  String? id;
  List images = [];
  double? lat;
  double? lng;
  String? describe;
  String? phone;
  DateTime? date;
  String? title;
  double? price;
  String? user_phone;
  Farm();
  Farm.fromJson(Map<String, dynamic> json)
      : images = json['images'] ?? [],
        lat = json['lat'] ?? 0.0,
        lng = json['lng'] ?? 0.0,
        date = json['date'] == null
            ? null
            : DateTime.parse(json['date'] as String),
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
        'date': date!.toIso8601String(),
        'user_phone': user_phone,
        'price': price,
        'phone': phone,
        'id': id,
        'title': title
      };
}
