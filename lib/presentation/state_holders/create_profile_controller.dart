import 'package:assignment16/presentation/state_holders/auth_controller.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../data/models/create_profile_data.dart';
import '../../data/models/create_profile_model.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CreateProfileController extends GetxController{

  bool _createProfileInProgress = false;
  bool get createProfileInProgress => _createProfileInProgress;

  String _message = '';
  String get message => _message;

  CreateProfileData _createProfileData = CreateProfileData();
  CreateProfileData get createProfileData => _createProfileData;



  Future<bool> createProfile(
      String customerName,
      String customerAddress,
      String customerCity,
      String customerPostCode,
      String country,
      String customerMobile,
      String shippingAddress
      ) async {
    _createProfileInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.postRequest(Urls.createProfile, {
      "cus_name": customerName,
      "cus_add": customerAddress,
      "cus_city": customerCity,
      "cus_state": customerCity,
      "cus_postcode": customerPostCode,
      "cus_country": country,
      "cus_phone": customerMobile,
      "cus_fax":  customerMobile,
      "ship_name": customerName,
      "ship_add": shippingAddress,
      "ship_city": customerCity,
      "ship_state": customerCity,
      "ship_postcode": customerPostCode,
      "ship_country": country,
      "ship_phone": customerMobile
    });
    _createProfileInProgress = false;
    update();
    if (response.isSuccess) {
      _createProfileData = CreateProfileModel.fromJson(response.responseBody ?? {}).data!;
      await AuthController.saveUserInfo(CreateProfileModel.fromJson(response.responseBody!));
      return true;
    } else {
      _message = 'Create profile failed! Try again';
      return false;
    }
  }

}