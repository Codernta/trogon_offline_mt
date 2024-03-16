


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trogon_offline/Models/feed_page_model.dart';
import 'package:trogon_offline/Utilities/Common/api.dart';
import 'package:trogon_offline/Utilities/Common/commons.dart';

class FeedPageServices{

  static Future<FeedPageModel?> getFeedPageData({required BuildContext context}) async {
    FeedPageModel? feedPageModel;
    String? token = Common.token;
    try {
      Response userData = await Dio().get(Api.feedScreenApi
          , queryParameters: {
            "auth_token": token
          },
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ));
      print('feed page Info: ${userData.data}');
      if (userData.statusCode == 200) {
        feedPageModel = FeedPageModel.fromJson(userData.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
        return feedPageModel;
      }
      return feedPageModel;
    }
    return feedPageModel;
  }
}