import 'package:final_project/models/farm_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant.dart';

class FarmView extends StatefulWidget {
  Farm model;
  FarmView({Key? key, required this.model}) : super(key: key);

  @override
  _FarmViewState createState() => _FarmViewState();
}

class _FarmViewState extends State<FarmView> {
  String address = "";
  void getAddress(double lati, double longi) async {
    final coordinates = new Coordinates(lati, longi);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    debugPrint("${first.locality}");

    address = first.addressLine.toString();
    setState(() {});
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  void initState() {
    super.initState();
    getAddress(widget.model.lat!, widget.model.lng!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.title!),
      ),
      body: Column(
        children: [
          SizedBox(
            height: getHeight(context) * 0.30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.model.images.length,
                itemBuilder: (context, index) {
                  return ImageSlideshow(
                    width: getWidth(context),
                    height: getHeight(context) * 0.30,
                    initialPage: 0,
                    indicatorBackgroundColor: Colors.white,
                    children: [
                      ...widget.model.images
                          .map((e) => Image.network(
                                e,
                                fit: BoxFit.cover,
                                width: getWidth(context),
                                height: getHeight(context) * 0.30,
                              ))
                          .toList(),
                    ],
                  );
                }),
          ),
          ListTile(
            onTap: () {
              openMap(widget.model.lat!, widget.model.lng!);
            },
            leading: Icon(Icons.location_pin),
            title: Text(address),
            trailing: Text(
              widget.model.price.toString() + "JD",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Description: ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: Text(widget.model.describe!,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 17,
                    fontWeight: FontWeight.w400)),
          ),
          ElevatedButton.icon(
              onPressed: () {
                launch("tel://${widget.model.phone}");
              },
              icon: Icon(Icons.phone),
              label: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.model.phone!),
              ))
        ],
      ),
    );
  }
}
