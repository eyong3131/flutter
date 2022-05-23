import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class Mapbox extends StatefulWidget {
  const Mapbox({Key? key}) : super(key: key);

  @override
  State<Mapbox> createState() => _MapboxState();
}

class _MapboxState extends State<Mapbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(14.0229, 121.2827),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/eyong3131/cl3ia6x8y000t15oxg6kkmpve/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZXlvbmczMTMxIiwiYSI6ImNrbHQyamtoNDA5aXUycG1zdGtocHZlNWcifQ.TnRwScwnRu9ezb6XA70dEg",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoiZXlvbmczMTMxIiwiYSI6ImNrbHQyamtoNDA5aXUycG1zdGtocHZlNWcifQ.TnRwScwnRu9ezb6XA70dEg',
              'id': 'mapbox.satellite'
            },
            attributionBuilder: (_) {
              return const Text("© OpenStreetMap contributors");
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: latLng.LatLng(51.5, -0.09),
                builder: (ctx) => Container(
                  child: FlutterLogo(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
