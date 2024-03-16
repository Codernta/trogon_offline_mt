

import 'package:flutter/cupertino.dart';
import 'package:trogon_offline/Models/home_page_model.dart';
import 'package:trogon_offline/Services/home_page_services.dart';

class HomePageProvider with ChangeNotifier{
  HomePageModel? homePageModel;
  bool loading = false;


  Future getHomePageData({required BuildContext context}) async {
    loading = true;
    homePageModel = await HomePageServices.getHomePageData(context: context);
    loading = false;
    print("|||||||||||||||||||| homepage Details|||||||||||||||||");
    print(homePageModel);
    notifyListeners();
  }
}