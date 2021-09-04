import 'package:final_project/models/farm_model.dart';
import 'package:final_project/services/farm_service.dart';
import 'package:flutter/foundation.dart';

class FarmsProvider with ChangeNotifier {
  List<Farm> farms = [];
  void addFarm(Farm data) {
    farms.add(data);

    notifyListeners();
  }

  void initFarms() {
    FarmService.getAllFarms().then((value) {
      value.map((e) => addFarm(e)).toList();
      //farms.addAll(value);
      print(farms.length);
    });
  }

  List<Farm> getFarms() {
    return farms;
  }
}
