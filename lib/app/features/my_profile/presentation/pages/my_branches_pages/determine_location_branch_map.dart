import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:sirius/app/features/branches/presentation/bloc/branches_bloc.dart';
import 'package:sirius/src/components/custom_button.dart';
import 'package:sirius/src/components/svg_icon_widget.dart';

import '../../../../../../src/components/custom_snack_bar/app_snackbar.dart';
import '../../../../../../src/core/data_sources/local/local_storage.dart';
import '../../../../../../src/di/LocationService.dart';
import '../../../../../../src/di/services_locator.dart';
import '../../../../../../src/themes/app_colors.dart';
import '../../../../../../src/themes/app_theme.dart';
import '../../../../../../src/utils/app_notifications.dart';

class DetermineLocationMap extends StatefulWidget {
  BranchesBloc bloc;

  DetermineLocationMap(this.bloc);

  @override
  State<DetermineLocationMap> createState() => _DetermineLocationMapState();
}

class _DetermineLocationMapState extends State<DetermineLocationMap> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) return;

    try {
      final response = await http.get(
        Uri.parse(
            'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=1'),
        headers: {'User-Agent': 'csc-mobile1'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          _mapController.move(LatLng(lat, lon), 16);
        } else {
          AppSnackbar.show(
              context: context,
              message: 'تمت العملية',
              desc: "لم يتم العثور على الموقع",
              type: SnackbarType.error);

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('لم يتم العثور على الموقع')),
          // );
        }
      } else {
        AppSnackbar.show(
            context: context,
            message: 'حدث خطأ',
            desc: "خطأ في الاتصال بالخادم",
            type: SnackbarType.error);
      }
    } catch (e) {
      AppSnackbar.show(
          context: context,
          message: 'حدث خطأ',
          desc: "خطأ في الاتصال بالخادم",
          type: SnackbarType.error);
    }
  }

  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    localStorage = sl.get<LocalStorage>();
    _mapController = MapController();
  }

  void _onMapTap(LatLng latLng) {
    setState(() {
      destinationPoint = latLng;
    });
  }

  LatLng? _draggedsourcePoint;

  LatLng? sourcePoint;
  LatLng? destinationPoint;

  LatLng? meLocation;

  late final LocalStorage localStorage;

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("خدمة الموقع غير مفعلة");
      AppSnackbar.show(
          context: context,
          message: 'خدمة الموقع غير مفعلة',
          desc: "",
          type: SnackbarType.error);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        print("تم رفض إذن الموقع بشكل دائم");
        return;
      }
    }

    Position position;
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    meLocation = LatLng(position.latitude, position.longitude);
    _mapController.move(LatLng(position.latitude, position.longitude), 17.0);
    setState(() {
      meLocation = LatLng(position.latitude, position.longitude);
    });
  }

  late String areaName = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  onMapReady: () {
                    print("الخريطة جاهزة!");
                  },
                  onTap: (tapPosition, latLng) async {
                    AppNotifications.showMessage(
                        message: 'site_data_is_being_retrieved'.tr());

                    _onMapTap(latLng);

                    areaName = await LocationService.getAddressName(latLng);
                    print("RTTTTTTT${areaName}");

                    setState(() {});
                  },
                  onLongPress: (tapPosition, latlng) {},
                  initialCenter:
                      // widget.currentLocation ??
                      LatLng(33.5138, 36.2765),
                  minZoom: 5,
                  maxZoom: 18,
                  initialZoom: 16,
                ),
                children: [
                  TileLayer(
                    //    urlTemplate: "https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png",

                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    tileProvider: NetworkTileProvider(
                        headers: {'User-Agent': LocationService.userAgent}),
                  ),
                  CircleLayer(
                    circles: [
                      CircleMarker(
                        point: meLocation ?? LatLng(33.5138, 36.2765),
                        radius: 25,
                        color: Colors.black.withOpacity(0.3),
                        borderColor: Colors.black,
                        borderStrokeWidth: 2,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: [
                      if (meLocation != null)
                        Marker(
                          point: meLocation!,
                          width: 50.w,
                          height: 50.h,
                          child: Icon(Icons.pin_drop_outlined,
                              color: AppColors.yellow, size: 30.sp),
                        ),
                      if (destinationPoint != null)
                        Marker(
                          point: destinationPoint!,
                          width: 50.w,
                          height: 50.h,
                          child: Icon(Icons.location_on,
                              color: AppColors.primary, size: 30.sp),
                        ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 49.h,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 8.h),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20.sp,
                          )),
                    ),
                    SizedBox(
                      width: 320.w,
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'find_the_desired_location'.tr(),
                          hintStyle: textTheme.bodyMedium,
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () =>
                                  _searchLocation(_searchController.text),
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                            child: SizedBox(
                              child: SvgIcon(
                                  w: 24.w,
                                  h: 24.w,
                                  iconTitle:
                                      'assets/icons/location_google.svg'),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.5),
                          ),
                        ),
                        onChanged: (value) {
                          if (_debounceTimer?.isActive ?? false)
                            _debounceTimer?.cancel();
                          _debounceTimer = Timer(Duration(seconds: 2), () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('جاري البحث')),
                            );
                            _searchLocation(value);
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 350.h,
                  left: 35.w,
                  right: 35.w,
                  child: Text(
                    "Tap_drag_drop_pin_map".tr(),
                    style: textTheme.titleSmall!.copyWith(
                        color: AppColors.black, fontWeight: FontWeight.w700),
                  ))
            ],
          ),
        ),
        bottomSheet: (areaName != "")
            ? Container(
                height: 314.h,
                margin: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 28.h, bottom: 43.h),
                        child: Text(
                          "your_address".tr(),
                          style:
                              textTheme!.labelLarge!.copyWith(fontSize: 14.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "address".tr(),
                            style: textTheme!.labelMedium!.copyWith(
                                fontSize: 14.sp, color: AppColors.grey),
                          ),
                          SizedBox(
                            height: 130.h,
                            width: 280.w,
                            child: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                areaName,
                                style: textTheme!.labelMedium!.copyWith(
                                    fontSize: 14.sp, color: AppColors.darkest)),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      text: "add_address".tr(),
                      isGradient: true,
                      color: Colors.red,
                      textColor: AppColors.white,
                      onPressed: () {
                        if (areaName != null &&
                            areaName != "" &&
                            destinationPoint != null) {
                          widget.bloc.add(AddBranchLocationEvent(
                              areaName: areaName, location: destinationPoint!));
                          // BlocProvider.of<BranchesBloc>(context).add(
                          //     AddBranchLocationEvent(
                          //         areaName: areaName,
                          //         location: destinationPoint!));
                          context.pop();
                        }
                      },
                    )
                  ],
                ),
              )
            : SizedBox(),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 100.h),
          child: InkWell(
            onTap: () async {
              AppNotifications.showMessage(
                  message:
                      'الرجاء الانتظار بينما يتم جلب بيانات الموقع الحالي...');
              Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
              );
              AppNotifications.showMessage(message: 'تم جلب البيانات بنجاح!');

              _mapController.move(
                  LatLng(position.latitude, position.longitude), 17.0);
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  Icons.location_searching_outlined,
                  color: AppColors.grey,
                  size: 22.sp,
                )),
          ),
        ),
      ),
    );
  }
}
