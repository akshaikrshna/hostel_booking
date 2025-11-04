import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationPickerPage extends StatefulWidget {
  // optional initial location
  final LatLng? initialLocation;
  const LocationPickerPage({Key? key, this.initialLocation}) : super(key: key);

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _pickedLatLng;
  String? _pickedAddress;
  bool _loading = true;
  CameraPosition? _initialCamera;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      // 1) Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, show UI
          setState(() {
            _loading = false;
          });
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        // Permissions are permanently denied.
        setState(() {
          _loading = false;
        });
        return;
      }

      // 2) Get current position (or use initialLocation if provided)
      Position position;
     if (widget.initialLocation != null) {
  position = Position(
    latitude: widget.initialLocation!.latitude,
    longitude: widget.initialLocation!.longitude,
    timestamp: DateTime.now(),
    accuracy: 1,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    altitudeAccuracy: 0,
    headingAccuracy: 0
  );
} else {
  position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.best,
  );
}

      final initialLatLng = LatLng(position.latitude, position.longitude);
      _initialCamera = CameraPosition(target: initialLatLng, zoom: 16);

      // Set picked location default to current
      _pickedLatLng = initialLatLng;
      _pickedAddress = await _reverseGeocode(_pickedLatLng!);
    } catch (e) {
      debugPrint('Error getting location: $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<String?> _reverseGeocode(LatLng latLng) async {
    try {
      List<Placemark> places =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (places.isNotEmpty) {
        final p = places.first;
        final address = [
          if (p.name != null && p.name!.isNotEmpty) p.name,
          if (p.street != null && p.street!.isNotEmpty) p.street,
          if (p.locality != null && p.locality!.isNotEmpty) p.locality,
          if (p.postalCode != null && p.postalCode!.isNotEmpty) p.postalCode,
          if (p.country != null && p.country!.isNotEmpty) p.country,
        ].join(', ');
        return address;
      }
    } catch (e) {
      debugPrint('Reverse geocode failed: $e');
    }
    return null;
  }

  void _onMapTapped(LatLng latLng) async {
    setState(() {
      _pickedLatLng = latLng;
      _pickedAddress = null;
    });
    final address = await _reverseGeocode(latLng);
    setState(() {
      _pickedAddress = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_initialCamera == null) {
      // permission denied or failed to fetch location
      return Scaffold(
        appBar: AppBar(title: const Text('Pick location')),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('Location permission denied or unavailable.'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Geolocator.openAppSettings(),
              child: const Text('Open app settings'),
            ),
          ]),
        ),
      );
    }

    final markers = <Marker>{
      if (_pickedLatLng != null)
        Marker(
          markerId: const MarkerId('picked'),
          position: _pickedLatLng!,
          draggable: true,
          onDragEnd: (newPos) => _onMapTapped(newPos),
        ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick location'),
        actions: [
          TextButton(
            onPressed: _pickedLatLng == null
                ? null
                : () {
                    // Return selected info to caller
                    Navigator.of(context).pop({
                      'lat': _pickedLatLng!.latitude,
                      'lng': _pickedLatLng!.longitude,
                      'address': _pickedAddress,
                    });
                  },
            child: const Text('Select', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: _initialCamera!,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) => _controller.complete(controller),
              onTap: _onMapTapped,
              markers: markers,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey[100],
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _pickedLatLng != null
                            ? '${_pickedLatLng!.latitude.toStringAsFixed(6)}, ${_pickedLatLng!.longitude.toStringAsFixed(6)}'
                            : 'No location selected',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(_pickedAddress ?? 'Address not available'),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.my_location),
                  onPressed: () async {
                    // Center map on current position again
                    try {
                      final pos = await Geolocator.getCurrentPosition();
                      final controller = await _controller.future;
                      final cam = CameraPosition(
                        target: LatLng(pos.latitude, pos.longitude),
                        zoom: 16,
                      );
                      controller.animateCamera(CameraUpdate.newCameraPosition(cam));
                      _onMapTapped(LatLng(pos.latitude, pos.longitude));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Could not get current location: $e')),
                      );
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
