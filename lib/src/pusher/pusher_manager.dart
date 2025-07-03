import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:osm/src/components/custom_snack_bar/app_snackbar.dart';
import 'package:osm/src/themes/app_colors.dart';
import 'package:osm/src/themes/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:vibration/vibration.dart';

import '../core/data_sources/local/local_storage.dart';
import '../di/services_locator.dart';
import '../utils/SoundHelper.dart';
import '../utils/app_notifications.dart';

class PusherManager {
  static final PusherManager _instance = PusherManager._internal();

  factory PusherManager() => _instance;

  late PusherClient _pusher;
  Channel? _clientChannel;
  Channel? _driverChannel;
  BuildContext? _context;
  Timer? _locationRequestTimer; //
  PusherManager._internal() {
    _pusher = PusherClient(
      "5b2a9fa8b8300129c2d2",
      PusherOptions(
        cluster: "eu",
      ),
      autoConnect: true,
    );
    _pusher.connect();
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  void subscribeToClientChannel(String clientId, BuildContext context) {
    _clientChannel = _pusher.subscribe("client.$clientId");

    _clientChannel?.bind("driver.accepted_journey", (event) {
      print("driver.accepted.journey SSS");
      Vibration.vibrate(duration: 50);
      final soundHelper = SoundHelper();
      soundHelper.playNotificationSound();
    });
  }

  void subscribeToDriverChannel(String driverId, BuildContext context) {
    try {
      _driverChannel = _pusher.subscribe("driver.$driverId");

      _driverChannel!.bind("journey.ended", (event) {
        _locationRequestTimer?.cancel();
        print("Journey ended. Location requests stopped.");
      });
      print("Successful IN PUSHER ::: ");
    } catch (e) {
      print("ERROR IN PUSHER ::: ${e}");
    }
  }

  void unsubscribeAll() {
    // _clientChannel?.unsubscribe();
    // _driverChannel?.unsubscribe();
    _locationRequestTimer?.cancel();
  }
}
