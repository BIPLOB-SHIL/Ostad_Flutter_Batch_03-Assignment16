import 'package:assignment16/data/models/category_model.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CategoryController extends GetxController{

  bool _getCategoryInProgress = false;
  bool get getCategoryInProgress => _getCategoryInProgress;

  String _message ='';
  String get message => _message;

  CategoryModel _categoryModel = CategoryModel();
  CategoryModel get categoryModel => _categoryModel;


  Future<bool> getCategory() async {
    _getCategoryInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller
        .getRequest(Urls.getCategory);

    _getCategoryInProgress = false;

    if (response.isSuccess) {
      _categoryModel = CategoryModel.fromJson(response.responseBody ?? {});
      update();
      return true;

    } else {
      _message = 'Category data fetch to failed! Try again';
      update();
      return false;
    }
  }

}