import 'package:assignment16/data/models/cart_list_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CartListController extends GetxController{

  bool _getCartListInProgress = false;
  bool get getCartListInProgress => _getCartListInProgress;

  CartListModel _cartListModel = CartListModel();
  CartListModel get cartListModel => _cartListModel;

  String _message = '';
  String get message => _message;

  double _totalPrice = 0;
  double get totalPrice => _totalPrice;


  Future<bool> getCartList() async {
    _getCartListInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(Urls.getCartList);
    _getCartListInProgress = false;


    if (response.isSuccess) {
      _cartListModel = CartListModel.fromJson(response.responseBody!);
      _calculateTotalPrice();
      update();
      return true;
    } else {
      _message = 'Get cart list failed! Try again';
      return false;
    }
  }

  Future<bool> removeFromCart(int productId) async {
    _getCartListInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(Urls.getDeleteCartList(productId));
    _getCartListInProgress = false;
    if (response.isSuccess) {
      _cartListModel.data?.removeWhere((element) => element.productId == productId);
      _calculateTotalPrice();
      update();
      return true;
    } else {
      _message = 'Remove cart list failed! Try again';
      return false;
    }
  }

  void changeItem(int cartId, int noOfItems) {
    _cartListModel.data?.firstWhere((cartData) => cartData.id == cartId).quantity = noOfItems;
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    _totalPrice = 0;
    for (CartData data in _cartListModel.data ?? []) {
      _totalPrice += ((data.quantity ?? 1) *
          (double.tryParse(data.product?.price ?? '0') ?? 0));
    }
    update();
  }


}