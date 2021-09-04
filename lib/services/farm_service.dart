import 'dart:collection';

import 'package:final_project/models/farm_model.dart';
import 'package:final_project/services/firebase_service.dart';

class FarmService {
  static FirebaseApi api = new FirebaseApi();

  static Future createFarm(Farm farm) async {
    var res =
        await api.upload(url: "Farms/${farm.id}.json", body: farm.toJson());
    print(res);
    return res;
  }

  static Future<List<Farm>> getAllFarms() async {
    var res = await api.get("Farms.json");
    List<Farm> data = [];
    if (res != null) {
      var map = HashMap.from(res);
      data = map.values.map((e) => Farm.fromJson(e)).toList();
      data.sort((a, b) => a.date!.compareTo(b.date!));
      data = data.reversed.toList();
    }

    return data;
  }
}
