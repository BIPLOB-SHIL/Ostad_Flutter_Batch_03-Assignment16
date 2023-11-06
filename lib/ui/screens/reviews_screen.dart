import 'package:assignment16/ui/screens/create_review_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ utility/color_palettes.dart';
import '../../presentation/state_holders/product_review_list_controller.dart';
import '../widgets/reviews_card.dart';

class ReviewsScreen extends StatefulWidget {
  final int productId;
  const ReviewsScreen({super.key, required this.productId });

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<ProductReviewListController>().getProductDetails(widget.productId);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reviews",
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
        child: GetBuilder<ProductReviewListController>(
          builder: (productReviewListController) {
            if(productReviewListController.getProductReviewListInProgress){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                        itemCount: productReviewListController.productReviewListModel.data?.length ?? 0,
                        itemBuilder: (context,index){
                          return  ReviewsCard(
                            productReviewListData:
                             productReviewListController.productReviewListModel.data![index]);
                        },
                      ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reviews \(${productReviewListController.productReviewListModel.data?.length})",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, color: Colors.black54),
                          ),
                        ],
                      ),
                      FittedBox(
                        child: CircleAvatar(
                          radius: 23,
                          backgroundColor: AppColors.primaryColor,
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Get.to(()=> CreateReviewScreen(productId: widget.productId,));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}


