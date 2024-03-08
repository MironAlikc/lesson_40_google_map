import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('My location'),
      position: LatLng(
        36.232845,
        49.988358,
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final GoogleMapController controller = await _controller.future;
          await controller.animateCamera(CameraUpdate.newCameraPosition(
            const CameraPosition(
              zoom: 10,
              target: LatLng(
                42.232845,
                74.988358,
              ),
            ),
          ));
        },
      ),
      body: GoogleMap(
        polygons: {
          const Polygon(
            polygonId: PolygonId('sss'),
          ),
        },
        polylines: {
          const Polyline(
              polylineId: PolylineId(
                'value',
              ),
              points: [
                LatLng(
                  26.232845,
                  39.988358,
                ),
                LatLng(
                  36.232845,
                  49.988358,
                ),
                LatLng(
                  16.232845,
                  19.988358,
                ),
                LatLng(
                  36.232845,
                  49.988358,
                ),
              ]),
        },
        mapType: MapType.terrain,
        onMapCreated: (controller) => _controller.complete(
          controller,
        ),
        markers: markers,
        onTap: (value) {
          markers.add(
            Marker(
              markerId: const MarkerId('Target location'),
              position: value,
            ),
          );
          setState(() {});
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(
            36.232845,
            49.988358,
          ),
          zoom: 15,
        ),
      ),
    );
  }
}
