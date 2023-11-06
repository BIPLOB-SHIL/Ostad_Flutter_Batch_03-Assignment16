import 'package:assignment16/data/models/product_model.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class PopularProductController extends GetxController{

  bool _getPopularProductInProgress = false;
  bool get getPopularProductInProgress => _getPopularProductInProgress;

  String _message ='';
  String get message => _message;

  ProductDetails _popularProductModel = ProductDetails();
  ProductDetails get popularProductModel => _popularProductModel;


  Future<bool> getPopularProduct() async {
    _getPopularProductInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller
        .getRequest(Urls.getProductByRemarks('popular'));

    _getPopularProductInProgress = false;

    if (response.isSuccess) {
      _popularProductModel = ProductDetails.fromJson(response.responseBody ?? {});
      update();
      return true;

    } else {
      _message = 'Popular product data fetch to failed! Try again';
      update();
      return false;
    }
  }

}