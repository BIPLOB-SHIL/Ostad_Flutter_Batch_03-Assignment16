import 'package:assignment16/data/models/product_wish_list_model.dart';
import 'package:assignment16/presentation/state_holders/create_wish_list_controller.dart';
import 'package:assignment16/presentation/state_holders/product_wish_list_controller.dart';
import 'package:assignment16/ui/screens/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../ utility/color_palettes.dart';
import '../../data/models/product.dart';


class ProductWishListCard extends StatelessWidget {
  const ProductWishListCard({
    super.key, required this.productWishListData,
  });


  final ProductWishListData productWishListData;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppColors.primaryColor.withOpacity(0.1),
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),),
      child: SizedBox(
        width: 110,
        child: Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(30),
              highlightColor: Colors.blue.withOpacity(0.5),
              splashColor: AppColors.primaryColor.withOpacity(0.5),
              onTap: (){
                Get.to(()=> ProductDetailsScreen(productId: productWishListData.id!,),);
              },
              child: Container(
               height: 80,
               // width: 110,
                decoration: BoxDecoration(
                    color: AppColors.productColor,
                    borderRadius:  const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                   image:  DecorationImage(
                     image: NetworkImage(productWishListData.product?.image ?? '',),
                     scale: 1,
                   ),
                ),
              ),
            ),
             Column(
              children: [
                Text(
                  productWishListData.product?.title ?? '',
                  maxLines: 1,
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis, fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey
                  ),
                ),
                const SizedBox(height: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "\$${productWishListData.product?.price ?? 0}",
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          Text(
                            "${productWishListData.product?.star ?? 0}",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ]),
                    GetBuilder<CreateWishListController>(
                      builder: (createWishListController) {
                        return InkWell(
                          onTap: (){
                            createWishListController.removeWishList(
                              productWishListData.productId!
                            ).then((value){
                              if(value == true){
                                Get.find<ProductWishListController>().getProductWishList();
                              }
                            });
                          },
                          child: const Card(
                            color: AppColors.primaryColor,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.delete_outline_outlined,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}