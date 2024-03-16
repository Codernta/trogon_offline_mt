import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:trogon_offline/View/FeedScreen/feed_screen.dart';
import 'package:trogon_offline/View/HomeScreen/home_screen.dart';
import 'package:trogon_offline/View/MyCoursesScreen/my_courses_screen.dart';
import 'package:trogon_offline/View/NotificationScreen/notification_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DashBoard extends StatefulWidget {
  final int index;

  DashBoard({required this.index});
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;
  var currentIndex = 0;

  String countryCode = '';

  List<Widget> _screens = [
    HomeScreen(),
    MyCourseScreen(),
    NotificationScreen(),
    FeedScreen()
  ];



  void _onItemTapped(int index) async  {
    bool hasInternetConnection =
    await InternetConnectionChecker().hasConnection;
    if(hasInternetConnection){
      setState(() {
        _selectedIndex = index;
        print(_selectedIndex);
      });
    }else{
      if(index == 3){
      Get.to(()=> DashBoard(index: 3));      
      }else if(index == 0) {
Get.to(()=> DashBoard(index: 0));      }
      else if(index == 1){
        Get.to(()=> DashBoard(index: 1));
      }
      else{
        Get.snackbar("Info", "Please connect internet and try again");
      }

    }
  }

 /* setPrefData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(Common.stateIdPass, '');
    sharedPreferences.setString(Common.searchKeyword, '');
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setData();
    setState(() {
      _selectedIndex = widget.index;
      currentIndex = _selectedIndex;
    });
  }

  /*setData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(Common.searchKeyword, '');
    sharedPreferences.setString(Common.stateIdPass, '');
    sharedPreferences.setString(Common.searchKeyword, '');
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Future<bool> showExitPopup() async {
    return await
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              actions: <Widget>[
                Center(
                  child: Container(
                    height: 150,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(15)),
                    child: Stack(
                      children: [
                        SizedBox.expand(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                                  child: Text(
                                    'Are you sure \nDo you want to Exit ?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff888888),
                                      fontFamily: 'URWGeometricBold',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.015,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: Size(80, 40),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12)),
                                            backgroundColor: Color(0xffF6F6F6)),
                                        child: const Text(
                                          'No',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xffFF814B),
                                            fontFamily: 'URWGeometricBold',),
                                        )),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // SystemNavigator.pop();
                                        // SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
                                        exit(0);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(80, 40),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12)),
                                          backgroundColor: Color(0xffFF814B)),
                                      child: const Text(
                                        'Yes',
                                        style: TextStyle(
                                            fontFamily: 'URWGeometricBold',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            )
    )
        ??
        false; //if showDialouge had returned null, then return false
  }


  bottomNavBar() {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xffC4DCD9), width: 1),
        ),
      ),
      child: BottomNavigationBar(
        iconSize: 15,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          home(),
          myCourse(),
          notification(),
          feed(),
        ],
      ),
    );
  }

  home() {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/images/home_icon.svg',
        color: Colors.grey,
      ),
      activeIcon:
      SvgPicture.asset('assets/images/home_icon.svg',color: Color(0xff256EEE),),
      label: '',
    );
  }

  myCourse() {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/images/mycouse_icon.svg',color: Colors.grey,),
      activeIcon: SvgPicture.asset(
          'assets/images/mycouse_icon.svg',color:Color(0xff256EEE),),
      label: '',
    );
  }

  notification() {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/images/notification_icon.svg',color: Colors.grey,),
      activeIcon: SvgPicture.asset('assets/images/notification_icon.svg',color: Color(0xff256EEE),),
      label: '',
    );
  }

  feed() {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/images/feed_icon.svg',color: Colors.grey,),
      activeIcon: SvgPicture.asset(
          'assets/images/feed_icon.svg',color: Color(0xff256EEE),),
      label: '',
    );
  }
}


