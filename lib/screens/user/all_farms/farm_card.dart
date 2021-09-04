import 'package:final_project/constant.dart';
import 'package:final_project/models/farm_model.dart';
import 'package:final_project/screens/user/farm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class FarmCard extends StatelessWidget {
  Farm model;
  FarmCard({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => FarmView(
                    model: model,
                  )));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.images.length,
                    itemBuilder: (context, index) {
                      return ImageSlideshow(
                        width: getWidth(context) - 50,
                        height: 200,
                        initialPage: 0,
                        indicatorBackgroundColor: Colors.white,
                        children: [
                          ...model.images
                              .map((e) => Image.network(
                                    e,
                                    fit: BoxFit.fill,
                                    width: getWidth(context) - 100,
                                    height: 200,
                                  ))
                              .toList(),
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    model.title!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    model.price.toString() + "JD",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                model.describe!,
                textAlign: TextAlign.justify,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
