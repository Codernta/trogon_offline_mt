

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trogon_offline/View/Dashboard/dashboard.dart';

AppBar appBars = AppBar(
  elevation: 0,
  backgroundColor: Colors.transparent,
  leading: Padding(
    padding: const EdgeInsets.only(left: 20.0),
    child: SvgPicture.asset('assets/icons/appbar_menu_icon.svg',),
  ),
  actions: [
    IconButton(
        onPressed: ()=> Get.to(()=> DashBoard(index: 2)),
        icon: SvgPicture.asset('assets/icons/appbar_notification_icon.svg')),
    SizedBox(width: 20,)
  ],
);