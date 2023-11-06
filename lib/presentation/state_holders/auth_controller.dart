import 'dart:convert';
import 'package:assignment16/data/models/create_profile_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/create_profile_model.dart';


class AuthController{
  static String? _accessToken;
  static String? get accessToken => _accessToken;

 static CreateProfileModel userProfile = CreateProfileModel();

  static Future<void> setAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('access-token', token);
    _accessToken = token;
  }

  static Future<void> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _accessToken = sharedPreferences.getString('access-token');
    }


  static Future<void> clearUserInfo() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();

  }


  static Future<void> saveUserInfo(CreateProfileModel userModel)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('user-data',jsonEncode(userModel.toJson()));
    userProfile = userModel;
  }

  static Future<void> updateUserInfo(CreateProfileData userData)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userProfile.data = userData;
    await sharedPreferences.setString('user-data',jsonEncode(userProfile.toJson()));
  }

  static Future<CreateProfileModel> getUserInfo() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String value = sharedPreferences.getString('user-data')!;
    return CreateProfileModel.fromJson(jsonDecode(value));
  }

  static Future<bool> checkIfUserLoggedIn() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLogin =  sharedPreferences.containsKey('user-data');
    debugPrint("UserLogin: $isLogin");
   if(isLogin){
      userProfile = await getUserInfo();
   }
    return isLogin;
  }


  static bool get isLoggedIn  {
    return _accessToken != null;
  }

}