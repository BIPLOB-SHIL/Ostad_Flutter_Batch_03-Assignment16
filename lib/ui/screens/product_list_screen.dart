import 'package:assignment16/data/models/product_model.dart';
import 'package:assignment16/presentation/state_holders/product_list_controller.dart';
import 'package:assignment16/ui/widgets/product_wish_list_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  final int? categoryId;
  final ProductDetails? productModel;
  final String categoryName;
  const ProductListScreen({super.key, this.categoryId,  this.productModel, required this.categoryName});


  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.categoryId != null) {
        Get.find<ProductListController>().getProductList(widget.categoryId!);
      }else if(widget.productModel != null){
        Get.find<ProductListController>().setProduct(widget.productModel!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<ProductListController>(
          builder: (productListController) {
            if (productListController.getProductListInProgress){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (productListController.productListModel.data?.isEmpty ?? true){
              return const Center(
                child: Text("No available data to show"),
              );
            }
            return GridView.builder(
                  itemCount: productListController.productListModel.data?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return  FittedBox(
                  child: ProductCard(
                    product: productListController.productListModel.data![index],),
                  );
                });
          }
        ),
      ),
    );
  }
}
