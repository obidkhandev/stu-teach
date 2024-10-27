// // ignore_for_file: deprecated_member_use
//
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:tma_mobie/features/buildings/presentation/cubit/map/map_state.dart';
// import 'package:tma_mobie/features/buildings/presentation/pages/map/widget/cluster_painter.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';
//
// class LocationService {
//   Future<Position> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       debugPrint('Location services are disabled.');
//       throw Exception('Location services are disabled.');
//     }
//
//     // Check if the app has location permissions
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         debugPrint('Location permissions are denied.');
//         throw Exception('Location permissions are denied.');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       debugPrint('Location permissions are permanently denied.');
//       throw Exception('Location permissions are permanently denied.');
//     }
//
//     // Get the current location
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       debugPrint(
//           'Location obtained: ${position.latitude}, ${position.longitude}');
//       return position;
//     } catch (e) {
//       debugPrint('Failed to get location: $e');
//       throw Exception('Failed to get location: $e');
//     }
//   }
//
//   // Clusterized Placemark Collectionni yaratish
//   ClusterizedPlacemarkCollection buildClusterizedPlacemarkCollection(
//       MapState state) {
//     return ClusterizedPlacemarkCollection(
//       mapId: const MapObjectId('clusterized-1'),
//       placemarks: state.placemarks,
//       radius: 50,
//       minZoom: 15,
//       onClusterAdded: (self, cluster) async {
//         return cluster.copyWith(
//           appearance: cluster.appearance.copyWith(
//             opacity: 1.0,
//             icon: PlacemarkIcon.single(
//               PlacemarkIconStyle(
//                 image: BitmapDescriptor.fromBytes(
//                   await ClusterIconPainter(
//                     cluster.size,
//                   ).getClusterIconBytes(),
//                 ),
//                 scale: 1,
//               ),
//             ),
//           ),
//         );
//       },
//       onClusterTap: (self, cluster) async {
//         await state.mapController?.moveCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: cluster.placemarks.first.point,
//               zoom: state.mapZoom + 1,
//             ),
//           ),
//           animation: const MapAnimation(
//             type: MapAnimationType.linear,
//             duration: 0.3,
//           ),
//         );
//       },
//     );
//   }
//
//   Future<UserLocationView> onUserLocationAdded(
//       UserLocationView view, MapState state) async {
//     // получаем местоположение пользователя
//     CameraPosition? userLocation =
//         await state.mapController?.getUserCameraPosition();
//     // если местоположение найдено, центрируем карту относительно этой точки
//     if (userLocation != null) {
//       await state.mapController?.moveCamera(
//         CameraUpdate.newCameraPosition(userLocation.copyWith(zoom: 14)),
//         animation: const MapAnimation(
//           type: MapAnimationType.linear,
//           duration: 0.3,
//         ),
//       );
//     }
//     // меняем внешний вид маркера - делаем его непрозрачным
//     return view.copyWith(pin: view.pin.copyWith(opacity: 1));
//   }
// }
