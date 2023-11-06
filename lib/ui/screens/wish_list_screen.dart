import 'package:assignment16/presentation/state_holders/product_wish_list_controller.dart';
import 'package:assignment16/ui/widgets/product_wish_list_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../presentation/state_holders/main_bottom_nav_controller.dart';


class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}



class _WishListScreenState extends State<WishListScreen> {
  
  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.find<ProductWishListController>().getProductWishList();
    });
    super.initState();
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
            "Wish List",
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
          ),
        ),
        body: GetBuilder<ProductWishListController>(
          builder: (productWishListController) {
                   if (productWishListController.getProductWishListInProgress) {
                     return const Center(
                       child: CircularProgressIndicator(),
                     );
                   }
            return GridView.builder(
              itemCount: productWishListController.productWishListModel.data?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return  FittedBox(
                     child: ProductWishListCard(productWishListData: productWishListController.productWishListModel.data![index],),
                  );
                });
          }
        ),
      ),
    );
  }
}
