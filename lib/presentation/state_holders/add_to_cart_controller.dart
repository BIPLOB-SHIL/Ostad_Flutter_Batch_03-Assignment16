import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class AddToCartController extends GetxController{

  bool _addToCartInProgress = false;
  bool get addToCartInProgress => _addToCartInProgress;

  String _message = '';
  String get message => _message;


  Future<bool> addToCart(int productId, String color, String size,int quantity) async {
    _addToCartInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.postRequest(Urls.addToCart, {
      "product_id": productId,
      "color": color,
      "size": size,
      "qty": quantity
    });
    _addToCartInProgress = false;
    update();
    if (response.isSuccess) {
      return true;
    } else {
      _message = 'Add to cart failed! Try again';
      return false;
    }
  }

}