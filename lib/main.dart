import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:trogon_offline/Provider/feed_page_provider.dart';
import 'package:trogon_offline/Provider/home_page_provider.dart';
import 'package:trogon_offline/Provider/my_courses_provider.dart';
import 'package:trogon_offline/View/Dashboard/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomePageProvider()),
        ChangeNotifierProvider(create: (_) => MyCoursePageProvider()),
        ChangeNotifierProvider(create: (_) => FeedPageProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: DashBoard(index: 0),
      ),
    );
  }
}
