import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CreateProductReviewController extends GetxController{

  bool _createProductReviewInProgress = false;
  bool get createProductReviewInProgress => _createProductReviewInProgress;

  String _message = '';
  String get message => _message;


  Future<bool> createProductReview(String description, int productId , String ratings) async {
    _createProductReviewInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.postRequest(Urls.createProductReview, {
      "description": description,
      "product_id": productId,
      "rating": ratings
    });
    _createProductReviewInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      _message = 'Create product review failed! Try again';
      return false;
    }
  }

}