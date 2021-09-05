import 'package:final_project/models/farm_model.dart';
import 'package:final_project/services/farm_service.dart';
import 'package:flutter/foundation.dart';

class FarmsProvider with ChangeNotifier {
  List<Farm> farms = [];
  String? phone = "";
  void addFarm(Farm data) {
    farms.add(data);

    notifyListeners();
  }

  void addPhone(String phone) {
    if (phone != "")
      this.phone = phone;
    else
      this.phone = null;
    notifyListeners();
  }

  String? getPhone() {
    return phone;
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
