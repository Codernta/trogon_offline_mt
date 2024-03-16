


import 'package:flutter/material.dart';
import 'package:trogon_offline/Models/my_course_model.dart';
import 'package:trogon_offline/Services/mycourse_page_services.dart';

class MyCoursePageProvider with ChangeNotifier{
  MyCoursePageModel? myCoursePageModel;
  bool loading = false;


  Future getCoursePageData({required BuildContext context}) async {
    loading = true;
    myCoursePageModel = await MyCourseServices.getCoursePageData(context: context);
    loading = false;
    print("|||||||||||||||||||| Course page Details|||||||||||||||||");
    print(myCoursePageModel);
    notifyListeners();
  }
}