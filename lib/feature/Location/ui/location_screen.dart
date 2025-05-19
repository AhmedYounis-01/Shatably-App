import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';

class LocationDetectionScreen extends StatefulWidget {
  const LocationDetectionScreen({super.key});

  @override
  State<LocationDetectionScreen> createState() =>
      _LocationDetectionScreenState();
}

class _LocationDetectionScreenState extends State<LocationDetectionScreen> {
  final TextEditingController _searchController = TextEditingController(
    text: 'القاهرة',
  ); // قيمة افتراضية
  final MapController _mapController = MapController();

  LatLng _currentPosition = LatLng(30.0444, 31.2357); // القاهرة افتراضي
  final String _username = 'Morgan'; // اسم المستخدم كما في الصورة
  bool _isMapLoading = true;
  bool _isLocationPermissionDenied = false;
  bool _isOfflineMode = false; // New flag for offline mode

  @override
  void initState() {
    super.initState();
    _checkInternetAndGetLocation();
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> _checkInternetAndGetLocation() async {
    setState(() {
      _isMapLoading = true;
    });

    try {
      bool hasInternet = await _checkInternetConnection();

      if (!hasInternet) {
        setState(() {
          _isMapLoading = false;
          _isOfflineMode = true;
        });
        _showOfflineDialog();
        return;
      }

      _getCurrentLocation();
    } catch (e) {
      debugPrint('Error in network check: $e');
      setState(() {
        _isMapLoading = false;
        _isOfflineMode = true;
      });
      _showOfflineDialog();
    }
  }

  void _showOfflineDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Text('Network Issue'),
            content: Text(
              'Unable to connect to map services. Please check your internet connection and try again.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _checkInternetAndGetLocation();
                },
                child: Text('Retry'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Exit this screen
                },
                child: Text('Go Back'),
              ),
            ],
          ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isLocationPermissionDenied = true;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isLocationPermissionDenied = true;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _moveMapAndFetch(position.latitude, position.longitude);
    } catch (e) {
      debugPrint('Error getting location: $e');
      setState(() {
        _isMapLoading = false;
      });
    }
  }

  Future<void> _searchLocation(String query) async {
    try {
      if (query.isEmpty) return;

      setState(() {
        _isMapLoading = true;
      });

      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        _moveMapAndFetch(loc.latitude, loc.longitude);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not find location: $query')),
        );
        setState(() {
          _isMapLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error searching location: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error searching for location')));
      setState(() {
        _isMapLoading = false;
      });
    }
  }

  void _moveMapAndFetch(double lat, double lng) {
    setState(() {
      _currentPosition = LatLng(lat, lng);
      _mapController.move(_currentPosition, 15);
    });
    _getAddressFromLatLng();
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition.latitude,
        _currentPosition.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _searchController.text = place.locality ?? place.name ?? '';
          _isMapLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error getting address: $e');
      setState(() {
        _isMapLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map or offline placeholder
          _isOfflineMode
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.signal_wifi_off, size: 64.w, color: Colors.grey),
                    SizedBox(height: 16.h),
                    Text(
                      'No Internet Connection',
                      style: TextStyles.styleBold(
                        context,
                        fontSize: 18.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Please check your connection and try again',
                      style: TextStyles.styleRegular(
                        context,
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    ElevatedButton(
                      onPressed: _checkInternetAndGetLocation,
                      child: Text('Retry'),
                    ),
                  ],
                ),
              )
              : FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _currentPosition,
                  initialZoom: 15.0,
                  onTap:
                      (tapPos, point) =>
                          _moveMapAndFetch(point.latitude, point.longitude),
                  onMapReady: () {
                    setState(() {
                      _isMapLoading = false;
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://a.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c', 'd'],
                    userAgentPackageName:
                        'com.example.shatably_app', // Add your actual package name
                    tileProvider: NetworkTileProvider(),
                    fallbackUrl:
                        'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=YOUR_MAPBOX_TOKEN', // Replace with your actual Mapbox token
                    // Add this to handle when both fail
                    // errorTileCallback: (tile, errorMsg) {
                    //   debugPrint('Error loading tile: $errorMsg');
                    // },
                  ),

                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _currentPosition,
                        width: 116.w,
                        height: 116.h,
                        child: Center(
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
                        ),
                      ),
                    ],
                  ),
                ],
              ),

          // Loading indicator
          if (_isMapLoading)
            Container(
              color: Colors.black26,
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.primaryColor,
                ),
              ),
            ),

          // Permission denied message
          if (_isLocationPermissionDenied)
            Container(
              color: Colors.black54,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_off, color: Colors.white, size: 48.w),
                      SizedBox(height: 16.h),
                      Text(
                        'Location permission denied',
                        style: TextStyles.styleBold(
                          context,
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Please enable location permission in app settings to use this feature',
                        style: TextStyles.styleRegular(
                          context,
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButton(
                        onPressed: () async {
                          await Geolocator.openAppSettings();
                        },
                        child: Text('Open Settings'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Search bar
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(18.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Add your Home',
                        style: TextStyles.styleBold(
                          context,
                          fontSize: 18.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      // height: 54.h,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Color(0x5CFFFFFF),
                        boxShadow: [BoxShadow(color: Color(0x3F000000))],
                        borderRadius: BorderRadius.circular(32.r),
                      ),
                      child: TextField(
                        controller: _searchController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: _searchLocation,
                        decoration: InputDecoration(
                          hintText: 'Search here',
                          hintStyle: TextStyles.styleRegular(
                            context,
                            fontSize: 14.sp,
                            color: ColorsManager.geryIconColor,
                          ),
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color: ColorsManager.geryIconColor,
                          ),
                          suffixIcon: InkWell(
                            onTap:
                                () => _searchLocation(_searchController.text),
                            child: const Icon(Icons.send, color: Colors.grey),
                          ),
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.symmetric(vertical: 23.h),
                          contentPadding: EdgeInsets.symmetric(vertical: 18.h),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // User info and set location
          Positioned(
            bottom: 22.h,
            left: 22.w,
            right: 22.w,
            child: Column(
              children: [
                // Stack for overlapping containers
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // First container with name - higher transparency
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        top: 18.h,
                        left: 18.w,
                        right: 18.w,
                        bottom: 30.h,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0x6016404D),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, $_username',
                            style: TextStyles.styleBold(
                              context,
                              fontSize: 16.sp,
                              color: Color(0xffFFE0AE),
                            ),
                          ),
                          SizedBox(height: 50.h),
                        ],
                      ),
                    ),
                    // Second container with set location
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 18.w,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0x5016404D),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.r),
                            bottomRight: Radius.circular(12.r),
                            topLeft: Radius.circular(25.r),
                            topRight: Radius.circular(25.r),
                          ),
                        ),
                        child: InkWell(
                          onTap: _getCurrentLocation,
                          child: Row(
                            children: [
                              Image.asset(
                                AppIcons.locationIcon2,
                                width: 18,
                                height: 18,
                                color: Colors.white,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Set location on map',
                                style: TextStyles.styleMedium(
                                  context,
                                  fontSize: 14.sp,
                                  color: Color(0x99FFFFFF),
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: 24.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Skip button
                InkWell(
                  onTap: () {
                    // Handle skip action
                    // Navigator.of(context).pop();
                  },
                  child: Text(
                    'Skip',
                    style: TextStyles.styleRegular(
                      context,
                      color: Color(0xff16404D).withOpacity(.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
