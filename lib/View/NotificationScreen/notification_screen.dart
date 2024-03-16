

import 'package:flutter/material.dart';
import 'package:trogon_offline/Utilities/Styles/text_styles.dart';
import 'package:trogon_offline/Utilities/Widgets/appbar_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars,
      body: notificationBody(),
    );
  }

  notificationBody() {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height* 0.9,
      width: size.width,
      child: Center(
        child: Text("No notifications found!",style: coursePageTitle,),
      ),
    );
  }
}
