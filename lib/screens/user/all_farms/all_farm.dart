import 'package:final_project/provider/farms.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'farm_card.dart';

class AllFarm extends StatelessWidget {
  const AllFarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: context.watch<FarmsProvider>().getFarms().length,
          itemBuilder: (context, index) {
            return FarmCard(
                model: context.watch<FarmsProvider>().getFarms()[index]);
          }),
    );
  }
}
