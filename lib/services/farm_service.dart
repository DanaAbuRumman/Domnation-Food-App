import 'package:final_project/models/farm_model.dart';
import 'package:final_project/services/firebase_service.dart';

class FarmService {
  static FirebaseApi api = new FirebaseApi();

  static Future createFarm(Farm farm) async {
    var res =
        await api.upload(url: "Farms/${farm.id}.json", body: farm.toJson());

    return res;
  }
}
