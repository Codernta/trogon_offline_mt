


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trogon_offline/Models/my_course_model.dart';
import 'package:trogon_offline/Utilities/Common/api.dart';
import 'package:trogon_offline/Utilities/Common/commons.dart';

class MyCourseServices{
  static Future<MyCoursePageModel?> getCoursePageData({required BuildContext context}) async {
    MyCoursePageModel? myCoursePageModel;
    String? token = Common.token;
    try {
      final userData = await Dio().get(Api.myCourseScreenApi
          ,queryParameters: {
            "auth_token": token
          },
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ));
      if (userData.statusCode == 200) {
        print('request success');
        myCoursePageModel = MyCoursePageModel.fromJson(userData.data);
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
        return myCoursePageModel;
      }
      return myCoursePageModel;
    }
    return myCoursePageModel;
  }
}