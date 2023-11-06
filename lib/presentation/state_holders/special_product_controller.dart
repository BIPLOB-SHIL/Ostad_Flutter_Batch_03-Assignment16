import 'package:assignment16/data/models/product_model.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class SpecialProductController extends GetxController{

  bool _getSpecialProductInProgress = false;
  bool get getSpecialProductInProgress => _getSpecialProductInProgress;

  String _message ='';
  String get message => _message;

  ProductDetails _specialProductModel = ProductDetails();
  ProductDetails get specialProductModel => _specialProductModel;


  Future<bool> getSpecialProduct() async {
    _getSpecialProductInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller
        .getRequest(Urls.getProductByRemarks('special'));

    _getSpecialProductInProgress = false;

    if (response.isSuccess) {
      _specialProductModel = ProductDetails.fromJson(response.responseBody ?? {});
      update();
      return true;

    } else {
      _message = 'Special product data fetch to failed! Try again';
      update();
      return false;
    }
  }

}