import 'package:assignment16/data/models/cart_list_model.dart';
import 'package:assignment16/data/models/product_review_list_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../data/models/network_response.dart';
import '../../data/models/product_details.dart';
import '../../data/models/product_details_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class ProductReviewListController extends GetxController {
  bool _getProductReviewListInProgress = false;
  bool get getProductReviewListInProgress => _getProductReviewListInProgress;

  String _message = '';
  String get message => _message;

  ProductReviewListModel _productReviewListModel = ProductReviewListModel();
  ProductReviewListModel get productReviewListModel => _productReviewListModel;


  Future<bool> getProductDetails(int productId) async {
    _getProductReviewListInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getListReviewByProduct(productId));

    _getProductReviewListInProgress = false;

    if (response.isSuccess) {
      _productReviewListModel = ProductReviewListModel.fromJson(response.responseBody ?? {});
      update();
      return true;
    } else {
      _message = ' Product review data fetch to failed! Try again';
      update();
      return false;
    }
  }

}
