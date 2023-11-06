import 'package:assignment16/data/models/read_profile_data.dart';
import 'package:assignment16/data/models/read_profile_model.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';


class ReadProfileController extends GetxController{

  bool _readProfileInProgress = false;
  bool get readProfileInProgress => _readProfileInProgress;

  String _message ='';
  String get message => _message;

  ReadProfileData _readProfileData = ReadProfileData();
  ReadProfileData get readProfileData => _readProfileData;

  Future<bool> readProfile() async {
    _readProfileInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller
        .getRequest(Urls.readProfile);
    _readProfileInProgress = false;
    update();

    if (response.isSuccess && response.responseBody?['data'] != null) {
      _readProfileData = ReadProfileModel.fromJson(response.responseBody!).data!;

       update();
      return true;

    } else {
      _message = 'Read profile data fetch to failed! Try again';
      update();
      return false;
    }
  }

}