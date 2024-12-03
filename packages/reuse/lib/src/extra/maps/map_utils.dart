// lib/common/map_utils.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// A helper class to manage Google Maps operations
class MapUtils {
  // Create a Google Map widget
  static Widget createMap({
    required LatLng initialPosition,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
    Function(LatLng)? onTap,
    Function(LatLng)? onLongPress,
    Function(CameraPosition)? onCameraMove,
    double zoom = 14.0,
  }) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: zoom,
      ),
      markers: markers ?? {},
      polylines: polylines ?? {},
      onTap: onTap,
      onLongPress: onLongPress,
      onCameraMove: onCameraMove != null
          ? (CameraPosition position) => onCameraMove(position)
          : null,
    );
  }

  // Create a marker
  static Marker createMarker({
    required String markerId,
    required LatLng position,
    String title = '',
    String snippet = '',
    BitmapDescriptor? icon,
  }) {
    return Marker(
      markerId: MarkerId(markerId),
      position: position,
      infoWindow: InfoWindow(
        title: title,
        snippet: snippet,
      ),
      icon: icon ?? BitmapDescriptor.defaultMarker,
    );
  }

  // Create a polyline
  static Polyline createPolyline({
    required String polylineId,
    required List<LatLng> points,
    Color color = Colors.blue,
    int width = 5, // Changed from double to int
  }) {
    return Polyline(
      polylineId: PolylineId(polylineId),
      points: points,
      color: color,
      width: width, // Ensure this is an int
    );
  }

  // Convert LatLng to a string for storage or display
  static String latLngToString(LatLng latLng) {
    return '${latLng.latitude}, ${latLng.longitude}';
  }

  // Convert a string to LatLng
  static LatLng stringToLatLng(String str) {
    final parts = str.split(',');
    if (parts.length == 2) {
      final latitude = double.tryParse(parts[0].trim());
      final longitude = double.tryParse(parts[1].trim());
      if (latitude != null && longitude != null) {
        return LatLng(latitude, longitude);
      }
    }
    throw FormatException('Invalid LatLng string format');
  }
}

// Example usage of MapUtils in a Flutter widget
class MapPage extends StatelessWidget {
  final LatLng initialPosition =
      LatLng(37.7749, -122.4194); // Example: San Francisco

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Example'),
      ),
      body: MapUtils.createMap(
        initialPosition: initialPosition,
        markers: {
          MapUtils.createMarker(
            markerId: 'sf_marker',
            position: initialPosition,
            title: 'San Francisco',
            snippet: 'A cool city in California',
          ),
        },
        onTap: (LatLng position) {
          print('Map tapped at: $position');
        },
        onLongPress: (LatLng position) {
          print('Map long-pressed at: $position');
        },
      ),
    );
  }
}
//Purpose: Integrates with mapping services and provides utilities for handling maps.
// Usage: Used to manage and integrate map services and features.
