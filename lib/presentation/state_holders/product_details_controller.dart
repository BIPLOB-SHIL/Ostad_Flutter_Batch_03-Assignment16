import 'package:assignment16/data/models/product_details.dart';
import 'package:assignment16/data/models/product_details_model.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class ProductDetailsController extends GetxController{

  bool _getProductDetailsInProgress = false;
  bool get getProductDetailsInProgress => _getProductDetailsInProgress;

  String _message ='';
  String get message => _message;

  ProductDetails _productDetails = ProductDetails();
  ProductDetails get productDetails => _productDetails;

  List<String> _availableColors = [];
  List<String> get availableColors => _availableColors;


  List<String> _availableSizes = [];
  List<String> get availableSizes => _availableSizes;


  Future<bool> getProductDetails(int productId) async {
    _getProductDetailsInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller
        .getRequest(Urls.getProductDetailsById(productId));

    _getProductDetailsInProgress = false;

    if (response.isSuccess) {
      _productDetails = ProductDetailsModel.fromJson(response.responseBody ?? {}).data!.first;
      _convertStringToColor(_productDetails.color ?? '');
      _convertStringToSizes(_productDetails.size ?? '');
      update();
      return true;

    } else {
      _message = ' Product details data fetch to failed! Try again';
      update();
      return false;
    }
  }

  void _convertStringToColor(String color) {
    _availableColors = color.split(',');
  }

  void _convertStringToSizes(String sizes) {
    _availableSizes = sizes.split(',');
  }

}