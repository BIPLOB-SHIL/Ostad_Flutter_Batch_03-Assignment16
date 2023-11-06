import 'package:assignment16/data/models/slider_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class HomeSlidersController extends GetxController{

  bool _getHomeSlidersInProgress = false;
  bool get getHomeSlidersInProgress => _getHomeSlidersInProgress;

  String _message ='';
  String get message => _message;

  SliderModel _sliderModel = SliderModel();
  SliderModel get sliderModel => _sliderModel;



  Future<bool> getHomeSliders() async {
    _getHomeSlidersInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller
        .getRequest(Urls.getHomeSliders);

    _getHomeSlidersInProgress = false;

    if (response.isSuccess) {
      _sliderModel = SliderModel.fromJson(response.responseBody ?? {});
      update();
      return true;

    } else {
      _message = 'Slider data fetch to failed! Try again';
      update();
      return false;
    }
  }

}