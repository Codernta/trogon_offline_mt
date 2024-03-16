

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trogon_offline/Models/home_page_model.dart';
import 'package:trogon_offline/Utilities/Common/api.dart';
import 'package:trogon_offline/Utilities/Common/commons.dart';

class HomePageServices{

  static Future<HomePageModel?> getHomePageData({required BuildContext context}) async {
    HomePageModel? homePageModel;
    String? token = Common.token;
    try {
      Response userData = await Dio().get(Api.homeScreenApi
          , queryParameters: {
            "auth_token": token
      },
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ));
      print('home page Info: ${userData.data}');
      if (userData.statusCode == 200) {
        homePageModel = HomePageModel.fromJson(userData.data);
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
        return homePageModel;
      }
      return homePageModel;
    }
    return homePageModel;
  }
}