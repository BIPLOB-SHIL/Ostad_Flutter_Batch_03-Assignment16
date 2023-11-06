import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class EmailVerificationController extends GetxController{

  bool _emailVerificationInProgress = false;
  bool get emailVerificationInProgress => _emailVerificationInProgress;

  String _message ='';
  String get message => _message;



  Future<bool> verifyEmail(String email) async {
    _emailVerificationInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller
        .getRequest(Urls.emailVerification(email));

    _emailVerificationInProgress = false;
    update();

    if (response.isSuccess) {
      _message = response.responseBody?['data'] ?? '';
      return true;

    } else {
      return false;
    }
  }

}