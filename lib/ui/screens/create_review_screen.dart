import 'package:assignment16/presentation/state_holders/create_product_review_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../ utility/show_snackbar.dart';
import '../../presentation/state_holders/product_review_list_controller.dart';

class CreateReviewScreen extends StatefulWidget {
 final int productId;
  const CreateReviewScreen({super.key, required this.productId});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {

  final _ratingsController = TextEditingController();
  final _writeReviewController = TextEditingController();
  final _createReviewFormKey = GlobalKey<FormState>();

  final ProductReviewListController productReviewListController= Get.put<ProductReviewListController>(ProductReviewListController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Review",
          style: TextStyle(color: Colors.black),
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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _createReviewFormKey,
            child: Column(
              children: [
                TextFormField(
                    controller: _ratingsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "Ratings"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field is empty';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _writeReviewController,
                    maxLines: 10,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: "Write Review",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field is empty';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<CreateProductReviewController>(
                    builder: (createProductReviewController) {
                      if(createProductReviewController.createProductReviewInProgress){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_createReviewFormKey.currentState!.validate()) {
                            createProductReviewController.createProductReview(
                                _writeReviewController.text,
                                widget.productId,
                            _ratingsController.text
                            ).then((value) {
                                  if(value == true){
                                    Get.back();
                                    productReviewListController.getProductDetails(widget.productId);
                                    if (mounted)
                                    {
                                      showSnackBar(
                                          "Review submitted successfully",
                                          context,
                                          Colors.green[500],
                                          true);
                                    }
                                  }else{
                                    if (mounted)
                                    {
                                      showSnackBar(
                                          "Review add to failed",
                                          context,
                                          Colors.red[500],
                                          false);
                                    }
                                  }
                            });
                          }
                        },
                        child: const Text("Submit",
                        style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),),
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
