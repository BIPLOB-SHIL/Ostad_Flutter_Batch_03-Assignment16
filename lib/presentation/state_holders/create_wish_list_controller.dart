import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../data/models/network_response.dart';
import '../../data/models/product_details.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CreateWishListController extends GetxController{

  bool _createWishListInProgress = false;
  bool get createWishListInProgress => _createWishListInProgress;

  String _message = '';
  String get message => _message;

  ProductDetails _createProductWishList = ProductDetails();
  ProductDetails get createProductWishListModel => _createProductWishList;

  Future<bool> createWishList(int productId) async {
    _createWishListInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(Urls.createWishList(productId));
    _createWishListInProgress = false;
    update();
    if (response.isSuccess) {
      _createProductWishList = ProductDetails.fromJson(response.responseBody ?? {});
      return true;
    } else {
      _message = 'Create wish list data failed! Try again';
      return false;
    }
  }

  Future<bool> removeWishList(int productId) async {
    _createWishListInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(Urls.removeProductWishList(productId));
    _createWishListInProgress = false;
    update();
    if (response.isSuccess) {
      _createProductWishList = ProductDetails.fromJson(response.responseBody ?? {});
      return true;
    } else {
      _message = 'Remove wish list data failed! Try again';
      return false;
    }
  }

}