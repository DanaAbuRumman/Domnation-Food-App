import 'package:final_project/models/farm_model.dart';
import 'package:final_project/provider/farms.provider.dart';
import 'package:final_project/services/farm_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'all_farms/farm_card.dart';

class MyFarms extends StatefulWidget {
  const MyFarms({Key? key}) : super(key: key);

  @override
  _MyFramsState createState() => _MyFramsState();
}

class _MyFramsState extends State<MyFarms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "My Farms",
          ),
        ),
        body: FutureBuilder<List<Farm>>(
          future: FarmService.getUserFarms(
              Provider.of<FarmsProvider>(context, listen: false).getPhone()!),
          builder: (context, snap) {
            List<Farm> data = snap.data!;
            if (snap.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snap.hasData)
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return FarmCard(model: data[index]);
                  });
            return Text("No data found");
          },
        ));
  }
}
