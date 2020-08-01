import 'dart:convert';

import 'package:extreme_uber_eats_scraping/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapContent extends StatefulWidget {
  @override
  _MapContentState createState() => _MapContentState();
}

class _MapContentState extends State<MapContent> {

  GoogleMapController mapController;
  String _mapStyle;
  dynamic venueData;
  Set<Marker> markers;

  Future<String> loadMapStyle() async {
    print("debug #5: loading map style");
    return await rootBundle.loadString('assets/map-style/aubergine_google_map.txt');
  }

  Future<dynamic> loadVenues() async {
    print("debug #5: loading venues");
    String res = await DefaultAssetBundle.of(context).loadString('assets/data/map-venues.json');
    if(res==null) {
      print("error #2: Error fetching map venues from json");
      return "";
    }
    final parsed = json.decode(res.toString()).cast<Map<String,dynamic>>() ?? [];
    return parsed;
  }

  Future<Set<Marker>> loadMarkers(context, venues) async {
    print("debug #5: loading markers");
    List<Marker> markers = <Marker>[];
    if(venues == null) {
      print("error #2: Error parsing json");
      return {};
    }
    
    List<Place> places = venues.map<Place>((venue) => new Place.fromJson(venue)).toList();
    
    for(final place in places) {
      final marker = Marker(
        markerId: MarkerId(place.title),
        // icon: BitmapDescriptor.fromBytes(byteData),
        position: LatLng(double.parse(place.lat), double.parse(place.long)),
        infoWindow: InfoWindow(title: place.title),
        onTap: () {
          print("db #1: You pressed ${place.title} marker.");
        }
      );
      markers.add(marker);
    }

    return markers.toSet();
  }

  Future<Set<Marker>> loadMap(context) async {
    _mapStyle = await loadMapStyle();
    venueData = await loadVenues();
    markers = await loadMarkers(context, venueData);

    return markers;
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadMap(context),
      builder: (context, snapshot) {
        return (snapshot!=null && snapshot.data!=null) ?
          Container(
            child: GoogleMap(
              compassEnabled: true,
              onMapCreated: (controller) => setState(() {
                mapController = controller;
                mapController.setMapStyle(_mapStyle);
                // getMarkers();
                // getInitialLocation();
              }),
              markers: snapshot.data,
              initialCameraPosition: CameraPosition(
                target: LatLng(26.511485, 80.227332),
                zoom: 17.0,
                tilt: 89.0,
              ),
            )
        )
        : Center(child: CircularProgressIndicator(),);
      }
    );
  } 

  @override
  void dispose() {
    super.dispose();
  } 
}