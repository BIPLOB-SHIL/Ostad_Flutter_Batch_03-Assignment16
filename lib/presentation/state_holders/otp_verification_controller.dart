import 'package:assignment16/presentation/state_holders/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class OtpVerificationController extends GetxController{

  bool _otpVerificationInProgress = false;
  bool get otpVerificationInProgress => _otpVerificationInProgress;

  String _message ='';
  String get message => _message;

  Future<bool> verifyOtp(String email,String otp) async {
    _otpVerificationInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller
        .getRequest(Urls.otpVerification(email,otp));

    _otpVerificationInProgress = false;
    update();

    if (response.isSuccess) {
      await AuthController.setAccessToken(response.responseBody?['data'] ?? '');
      _message = response.responseBody?['data'] ?? '';
      return true;

    } else {
      return false;
    }
  }

}