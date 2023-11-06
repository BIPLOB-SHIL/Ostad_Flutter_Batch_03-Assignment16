import 'package:assignment16/data/models/product_wish_list_model.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class ProductWishListController extends GetxController{

  bool _getProductWishListInProgress = false;
  bool get getProductWishListInProgress => _getProductWishListInProgress;

  String _message ='';
  String get message => _message;

  ProductWishListModel _productWishListModel = ProductWishListModel();
  ProductWishListModel get productWishListModel => _productWishListModel;


  Future<bool> getProductWishList() async {
    _getProductWishListInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller
        .getRequest(Urls.getProductWishList);

    _getProductWishListInProgress = false;

    if (response.isSuccess) {
      _productWishListModel = ProductWishListModel.fromJson(response.responseBody ?? {});
      update();
      return true;

    } else {
      _message = ' Product wish list data fetch to failed! Try again';
      update();
      return false;
    }

  }

}