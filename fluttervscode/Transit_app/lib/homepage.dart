// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transit_app/Assistants/assistantMethods.dart';
import 'search_page.dart';
import 'Payment_page.dart';
import 'Work_trips.dart';
import 'My_trips.dart';
import 'support_page.dart';
import 'settings_page.dart';
import 'about_us.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods.searchCoordinateAddress(position);
    print('This is your address :: ' + address);
  }

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 45,
                          ),
                          Text(user.email!,
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 15)),
                          Text('Edit Profile',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 15))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const PaymentScreen();
                          },
                        ),
                      );
                    },
                    leading: Icon(Icons.payment),
                    title: Text('Payment',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const WorkTrips();
                          },
                        ),
                      );
                    },
                    title: Text('Work Trips',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                    leading: Icon(Icons.work),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MyTrips();
                          },
                        ),
                      );
                    },
                    title: Text('My Trips',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                    leading: Icon(Icons.time_to_leave_rounded),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SupportPage();
                          },
                        ),
                      );
                    },
                    title: Text('Support',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                    leading: Icon(Icons.message),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SettingsPage();
                          },
                        ),
                      );
                    },
                    title: Text('Settings',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                    leading: Icon(Icons.settings),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const AboutPage();
                          },
                        ),
                      );
                    },
                    title: Text('About',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                    leading: Icon(Icons.question_mark),
                  ),
                  ListTile(
                    title: Text('Logout',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                    leading: Icon(Icons.logout),
                    onTap: signUserOut,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            padding: EdgeInsets.only(top: 60, bottom: bottomPaddingOfMap),
            initialCameraPosition: HomePage._kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              setState(() {
                bottomPaddingOfMap = 210;
              });
              locatePosition();
            },
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
          ),
          Positioned(
            top: 50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                // ignore: sort_child_properties_last
                child: IconButton(
                    icon: const Icon(Icons.menu),
                    alignment: Alignment.center,
                    onPressed: () => _scaffoldKey.currentState!.openDrawer()),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.25,
            maxChildSize: 0.6,
            builder: (context, scrollController) => Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset('pictures/Line 3.png'),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SearchPage();
                              },
                            ),
                          );
                        },
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Where to?',
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
