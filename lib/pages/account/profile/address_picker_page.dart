import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressPickerPage extends StatelessWidget {
  const AddressPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final initialLocation = Get.arguments as LatLng;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Your Address'),
      ),
      body: AddressPickerMap(initialLocation: initialLocation),
    );
  }
}

class AddressPickerMap extends StatefulWidget {
  final LatLng initialLocation;

  const AddressPickerMap({super.key, required this.initialLocation});

  @override
  _AddressPickerMapState createState() => _AddressPickerMapState();
}

class _AddressPickerMapState extends State<AddressPickerMap> {
  late GoogleMapController _mapController;
  late LatLng _selectedLocation;

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.initialLocation;
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onMapTapped(LatLng tappedLocation) {
    setState(() {
      _selectedLocation = tappedLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _selectedLocation,
        zoom: 15,
      ),
      onTap: _onMapTapped,
    );
  }
}
