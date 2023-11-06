import 'package:assignment16/data/models/product_model.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class ProductListController extends GetxController{

  bool _getProductListInProgress = false;
  bool get getProductListInProgress => _getProductListInProgress;

  String _message ='';
  String get message => _message;

  ProductDetails _productListModel = ProductDetails();
  ProductDetails get productListModel => _productListModel;


  Future<bool> getProductList(int categoryId) async {
    _getProductListInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller
        .getRequest(Urls.getProductListByCategory(categoryId));

    _getProductListInProgress = false;

    if (response.isSuccess) {
      print(_productListModel.data);
      _productListModel = ProductDetails.fromJson(response.responseBody ?? {});
      update();
      return true;

    } else {
      _message = ' Product list data fetch to failed! Try again';
      update();
      return false;
    }
  }
  void setProduct(ProductDetails productModel){
    _productListModel = productModel;
    update();
  }

}