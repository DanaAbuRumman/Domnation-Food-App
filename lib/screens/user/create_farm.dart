import 'dart:async';
import 'dart:io';

import 'package:final_project/constant.dart';
import 'package:final_project/models/farm_model.dart';
import 'package:final_project/screens/user/map.dart';
import 'package:final_project/services/farm_service.dart';
import 'package:final_project/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'farm_view.dart';

class CreateFarm extends StatefulWidget {
  const CreateFarm({Key? key}) : super(key: key);

  @override
  _CreateFarmState createState() => _CreateFarmState();
}

class _CreateFarmState extends State<CreateFarm> {
  var title = new TextEditingController();
  var description = new TextEditingController();
  var price = new TextEditingController();
  var phone = new TextEditingController();
  Iterable markers = [];
  List<File> images = [];
  List urlImages = [];
  double? lat;
  double? long;
  Completer<GoogleMapController> _controller = Completer();

  bool isLoading = false;
  var createFarm = GlobalKey<FormState>();
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void getAddress(double lati, double longi) async {
    final coordinates = new Coordinates(lati, longi);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    debugPrint("${first.locality}");
    setState(() {
      _goToLocationOnMap(lati, longi);
    });
    print("Address :${first.addressLine.toString()}");
  }

  Future<void> _goToLocationOnMap(double latitude, double longitude) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
//            bearing: 192.8334901395799,
          target: LatLng(latitude, longitude),
          zoom: 16.151926040649414),
    ));

    markers = List.generate(1, (index) {
      LatLng latLngMarker = LatLng(latitude, longitude);

      return Marker(
        markerId: MarkerId("marker$index"),
        position: latLngMarker,
      );
    });

    lat = latitude;
    long = longitude;
  }

  Future getImage() async {
    var imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    var image = imagePicked != null ? File(imagePicked.path) : null;

    setState(() {
      if (image != null) {
        images.add(image);
      }
    });
  }

  Future<void> create() async {
    for (var item in images) {
      await uploadImage(item);
    }
    Farm model = new Farm();
    model.describe = description.text;
    model.images = urlImages;
    model.lat = lat;
    model.lng = long;
    model.title = title.text;
    model.price = double.parse(price.text);
    model.phone = phone.text;
    model.user_phone = FirebaseAuth.instance.currentUser!.phoneNumber;
    model.id = Uuid().v1();

    FarmService.createFarm(model).then((value) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => FarmView()));
    });
  }

  Future uploadImage(File _image) async {
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref()
          .child("Farm/${_image.path.split('/').last}")
          .putFile(_image);
      if (snapshot.state == TaskState.success) {
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        print(downloadUrl);

        urlImages.add(downloadUrl);
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _determinePosition().then((value) {
      lat = value.latitude;
      long = value.longitude;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new farm"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: createFarm,
            child: Column(
              children: [
                if (images.length != 0)
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...images
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image(
                                      width: getWidth(context) - 100,
                                      height: 300,
                                      image: FileImage(
                                        e,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                                .toList()
                                .reversed
                          ],
                        )),
                  ),
                if (images.length < 5)
                  ElevatedButton(
                      onPressed: () {
                        getImage();
                      },
                      child: Text("Add image")),
                textFiled(
                    controller: title,
                    label: "Title",
                    function: (value) {
                      if (value.isEmpty) return "Title can't be empty";
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      cursorColor: Colors.black,
                      controller: description,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: "description",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty)
                          return "description  can't be empty";
                      }),
                ),
                textFiled(
                    controller: price,
                    label: "Price",
                    function: (value) {
                      if (value.isEmpty) return "Price can't be empty";
                    }),
                textFiled(
                    controller: phone,
                    label: "Phone",
                    function: (value) {
                      if (value.isEmpty) return "Phone can't be empty";
                      if (value.length != 10)
                        return "Phone number should content 10 numbers";
                    }),
                if (lat != null && long != null)
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    height: getHeight(context) * 0.469,
                    width: getWidth(context),
                    child: GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(lat!, long!),
                        zoom: 14.4746,
                      ),
                      markers: Set.from(markers),
                      padding: EdgeInsets.only(bottom: 30),
                      onMapCreated: (GoogleMapController controller) {
                        if (!_controller.isCompleted) {
                          _controller.complete(controller);
                        }
                      },
                    ),
                  ),
                ElevatedButton(
                    onPressed: () {
                      if (lat != null && long != null) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (_) => Map(
                                      lat: lat!,
                                      long: long!,
                                    )))
                            .then((value) {
                          if (value != null) {
                            _goToLocationOnMap(
                                value!.latitude, value.longitude);
                            setState(() {});
                          }
                        });
                      } else {
                        _determinePosition().then((value) {
                          lat = value.latitude;
                          long = value.longitude;
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (_) => Map(
                                        lat: lat!,
                                        long: long!,
                                      )))
                              .then((value) {
                            if (value != null) {
                              _goToLocationOnMap(
                                  value!.latitude, value.longitude);
                            }
                          });
                        });
                      }
                    },
                    child: Text(lat == null && long == null
                        ? "Add Location"
                        : "Change Location")),
                ElevatedButton(
                    onPressed: () {
                      if (createFarm.currentState!.validate() &&
                          images.isNotEmpty) create();
                    },
                    child: Text("Upload"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
