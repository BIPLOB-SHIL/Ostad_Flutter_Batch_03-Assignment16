import 'package:assignment16/presentation/state_holders/cart_list_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../ utility/color_palettes.dart';
import '../../presentation/state_holders/main_bottom_nav_controller.dart';
import '../widgets/cart_product_card.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  int productQuantityCount = 1;



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CartListController>().getCartList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Get.find<MainBottomNavController>().backToHome();
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
              title: const Text(
                "Cart",
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0,
              automaticallyImplyLeading: true,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              leading: IconButton(
                onPressed: () {
                  Get.find<MainBottomNavController>().backToHome();
                },
                icon: const Icon(Icons.arrow_back_ios),
              )),
          body: RefreshIndicator(
            onRefresh: ()async{
              Get.find<CartListController>().getCartList();
            },
            child: GetBuilder<CartListController>(
              builder: (cartListController) {
                if(cartListController.getCartListInProgress){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Expanded(
                        child: ListView.builder(
                              itemCount: cartListController.cartListModel.data?.length ?? 0,
                              itemBuilder: (context,index){
                                return  CartProductCard(cartData:
                                  cartListController.cartListModel.data![index],);
                              },
                         ),
                        ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                                const Text(
                                  "Total Price",
                                  style: TextStyle(fontWeight: FontWeight.w700,
                                      color: Colors.black54),
                                ),
                                Text(
                                  "\$ ${cartListController.totalPrice}",
                                  style: const TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 120,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                                onPressed: () {
                                  if(cartListController.cartListModel.data?.isNotEmpty ?? false){
                                    Get.to(() => const CheckOutScreen());

                                  }
                                },
                                child: const Text(
                                  "Checkout",
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          )),
    );
  }
}


