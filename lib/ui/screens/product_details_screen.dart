import 'package:assignment16/presentation/state_holders/add_to_cart_controller.dart';
import 'package:assignment16/presentation/state_holders/create_wish_list_controller.dart';
import 'package:assignment16/presentation/state_holders/product_details_controller.dart';
import 'package:assignment16/ui/screens/reviews_screen.dart';
import 'package:assignment16/ui/widgets/product_image_slider.dart';
import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../ utility/color_palettes.dart';
import '../ utility/show_snackbar.dart';
import '../../presentation/state_holders/main_bottom_nav_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;

  int quantity = 1;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductDetailsController>().getProductDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
            if (productDetailsController.getProductDetailsInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return WillPopScope(
              onWillPop: () async{
                Get.find<MainBottomNavController>().backToHome();
                return true;
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ProductImageSlider(imageList: [
                            productDetailsController.productDetails.img1 ?? '',
                            productDetailsController.productDetails.img2 ?? '',
                            productDetailsController.productDetails.img3 ?? '',
                            productDetailsController.productDetails.img4 ?? '',
                          ]),
                          AppBar(
                            title: const Text(
                              "Product Details",
                              style: TextStyle(color: Colors.black),
                            ),
                            elevation: 0,
                            automaticallyImplyLeading: true,
                            backgroundColor: Colors.grey.shade200,
                            foregroundColor: Colors.black,
                            leading: IconButton(
                              onPressed: () {
                                Get.back();
                                // Get.find<MainBottomNavController>().changeScreen(1);
                              },
                              icon: const Icon(Icons.arrow_back_ios),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    productDetailsController
                                        .productDetails.product?.title ??
                                        '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.visible,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                ),
                                CartStepperInt(
                                  value: quantity,
                                  size: 30,
                                  numberSize: 2,
                                  editKeyboardType: TextInputType.number,
                                  stepper: 1,
                                  axis: Axis.horizontal,
                                  style: CartStepperStyle(
                                    foregroundColor: Colors.black87,
                                    activeForegroundColor: Colors.black87,
                                    activeBackgroundColor: Colors.white,
                                    radius: const Radius.circular(50),
                                    border: Border.all(color: Colors.grey),
                                    elevation: 5,
                                    // buttonAspectRatio: 1,
                                  ),

                                  didChangeCount: (count) {
                                    if (count < 1) {
                                      return;
                                    } else if (count > 10) {
                                      return;
                                    }
                                    if (mounted) {
                                      quantity = count;
                                      setState(() {});
                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 18,
                                      ),
                                      Text(
                                        "${productDetailsController.productDetails
                                            .product?.star ?? 0}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                TextButton(
                                  onPressed: () {
                                    Get.to(() =>  ReviewsScreen(productId: widget.productId,));
                                  },
                                  child: const Text(
                                    "Reviews",
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                GetBuilder<CreateWishListController>(
                                  builder: (createWishListController) {
                                    return InkWell(
                                      onTap: (){
                                          createWishListController.createWishList(
                                           productDetailsController.productDetails.productId!
                                          ).then((value) =>
                                          {
                                            if (value == true)
                                              {
                                                if (mounted)
                                                  {
                                                    showSnackBar(
                                                        "Product added to wish list \nsuccessfully",
                                                        context,
                                                        Colors.green[500],
                                                        true)
                                                  }
                                              }
                                            else
                                              {
                                                if (mounted)
                                                  {
                                                    showSnackBar(
                                                        "Product added to wish list failed",
                                                        context,
                                                        Colors.red[500],
                                                        false)
                                                  }
                                              }
                                          });
                                      },
                                      child: const Card(
                                        color: AppColors.primaryColor,
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.favorite_border,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                ),
                              ],
                            ),
                            const Text(
                              "Color",
                              style: TextStyle(
                                  fontSize: 16,
                                  overflow: TextOverflow.visible,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 28,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                productDetailsController.availableColors.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(60),
                                    highlightColor: Colors.blue.withOpacity(0.6),
                                    splashColor:
                                    AppColors.primaryColor.withOpacity(0.6),
                                    onTap: () {
                                      _selectedColorIndex = index;
                                      setState(() {});
                                    },
                                      child: Container(
                                        width: 45,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black),
                                            borderRadius: BorderRadius.circular(
                                                15),
                                            color: _selectedColorIndex == index
                                                ? AppColors.primaryColor
                                                : null),
                                        alignment: Alignment.center,
                                        child: Text(
                                          productDetailsController
                                              .availableColors[index],
                                          style: TextStyle(
                                              color: _selectedColorIndex == index
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      )
                                  );
                                },
                                separatorBuilder: (BuildContext context,
                                    int index) {
                                  return const SizedBox(
                                    width: 8,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              "Size",
                              style: TextStyle(
                                  fontSize: 18,
                                  overflow: TextOverflow.visible,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 30,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                productDetailsController.availableSizes.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      borderRadius: BorderRadius.circular(50),
                                      highlightColor: Colors.blue.withOpacity(1),
                                      splashColor:
                                      AppColors.primaryColor.withOpacity(1),
                                      onTap: () {
                                        _selectedSizeIndex = index;
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: 39,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black),
                                            borderRadius: BorderRadius.circular(
                                                15),
                                            color: _selectedSizeIndex == index
                                                ? AppColors.primaryColor
                                                : null),
                                        alignment: Alignment.center,
                                        child: Text(
                                          productDetailsController
                                              .availableSizes[index],
                                          style: TextStyle(
                                              color: _selectedSizeIndex == index
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ));
                                },
                                separatorBuilder: (BuildContext context,
                                    int index) {
                                  return const SizedBox(
                                    width: 8,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              productDetailsController.productDetails.des ?? '',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black45),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                                  "Price",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54),
                                ),
                                Text(
                                  "\$${productDetailsController.productDetails
                                      .product?.price ?? ""}",
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
                              child: GetBuilder<AddToCartController>(
                                  builder: (addToCartController) {
                                    if (addToCartController.addToCartInProgress) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      onPressed: () {
                                        addToCartController
                                            .addToCart(
                                            productDetailsController
                                                .productDetails.id!,
                                            productDetailsController
                                                .availableColors[_selectedColorIndex],
                                            productDetailsController
                                                .availableSizes[_selectedSizeIndex],
                                           quantity
                                        )
                                            .then((value) =>
                                        {
                                          if (value == true)
                                            {
                                              if (mounted)
                                                {
                                                  showSnackBar(
                                                      "Product added to cart successfully",
                                                      context,
                                                      Colors.green[500],
                                                      true)
                                                }
                                            }
                                          else
                                            {
                                              if (mounted)
                                                {
                                                  showSnackBar(
                                                      "Product added to cart failed",
                                                      context,
                                                      Colors.red[500],
                                                      false)
                                                }
                                            }
                                        });
                                      },
                                      child: const Text(
                                        "Add To Cart",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
