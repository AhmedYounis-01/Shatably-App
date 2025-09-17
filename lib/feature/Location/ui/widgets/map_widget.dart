import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:shatably_app/core/utils/app_icons.dart';

class MapWidget extends StatelessWidget {
  final MapController mapController;
  final LatLng currentPosition;
  final Function(double, double) onTap;
  final VoidCallback onMapReady;

  const MapWidget({
    Key? key,
    required this.mapController,
    required this.currentPosition,
    required this.onTap,
    required this.onMapReady,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: currentPosition,
        initialZoom: 15.0,
        onTap: (tapPos, point) => onTap(point.latitude, point.longitude),
        onMapReady: onMapReady,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://a.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'com.example.shatably_app',
          tileProvider: NetworkTileProvider(),
          fallbackUrl:
              'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=YOUR_MAPBOX_TOKEN',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: currentPosition,
              width: 116.w,
              height: 116.h,
              child: UserLocationMarkerWidget(),
            ),
          ],
        ),
      ],
    );
  }
}

class UserLocationMarkerWidget extends StatelessWidget {
  const UserLocationMarkerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 116.w,
        height: 116.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(30, 64, 77, 100),
        ),
        child: Center(
          child: Container(
            width: 75.w,
            height: 75.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffE1CEAB),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.backgroundLocationIcon,
                  width: 55.w,
                  height: 55.h,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Image.asset(
                    AppIcons.boyIcon,
                    width: 30.w,
                    height: 30.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
