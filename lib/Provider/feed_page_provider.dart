


import 'package:flutter/material.dart';
import 'package:trogon_offline/Models/feed_page_model.dart';
import 'package:trogon_offline/Services/feed_page_services.dart';

class FeedPageProvider with ChangeNotifier{
  FeedPageModel? feedPageModel;
  bool loading = false;


  Future getFeedPageData({required BuildContext context}) async {
    loading = true;
    feedPageModel = await FeedPageServices.getFeedPageData(context: context);
    loading = false;
    print("|||||||||||||||||||| homepage Details|||||||||||||||||");
    print(feedPageModel);
    notifyListeners();
  }
}