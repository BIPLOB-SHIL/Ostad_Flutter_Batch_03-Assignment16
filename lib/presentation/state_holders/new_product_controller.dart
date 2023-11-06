import 'package:assignment16/data/models/product_model.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class NewProductController extends GetxController{

  bool _getNewProductInProgress = false;
  bool get getNewProductInProgress => _getNewProductInProgress;

  String _message ='';
  String get message => _message;

  ProductDetails _newProductModel = ProductDetails();
  ProductDetails get newProductModel => _newProductModel;


  Future<bool> getNewProduct() async {
    _getNewProductInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller
        .getRequest(Urls.getProductByRemarks('new'));

    _getNewProductInProgress = false;

    if (response.isSuccess) {
      _newProductModel = ProductDetails.fromJson(response.responseBody ?? {});
      update();
      return true;

    } else {
      _message = 'New product data fetch to failed! Try again';
      update();
      return false;
    }
  }

}