import 'package:assignment16/data/models/cart_list_model.dart';
import 'package:assignment16/ui/screens/product_details_screen.dart';
import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ utility/color_palettes.dart';
import '../ utility/show_snackbar.dart';
import '../../presentation/state_holders/cart_list_controller.dart';

class CartProductCard extends StatefulWidget {
  final CartData cartData;

  const CartProductCard({super.key, required this.cartData});

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartListController>(builder: (cartListController) {
      return InkWell(
        onTap: () {
          Get.to(() =>
              ProductDetailsScreen(productId: widget.cartData.productId!));
        },
        child: Card(
          color: AppColors.productCartColor,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.center,
                    image: NetworkImage(widget.cartData.product?.image ?? ''),
                    scale: 7,
                  ),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.cartData.product?.title ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black54),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style:
                                        const TextStyle(color: Colors.black54),
                                    children: [
                                      TextSpan(
                                          text:
                                              "Color: ${widget.cartData.color} ,"),
                                      TextSpan(
                                          text:
                                              " Size: ${widget.cartData.size}"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FittedBox(
                            child: IconButton(
                              onPressed: () {
                                cartListController
                                    .removeFromCart(
                                        widget.cartData.productId ?? 0)
                                    .then((value) => {
                                          if (value == true)
                                            {
                                              cartListController.getCartList(),
                                              if (mounted)
                                                {
                                                  showSnackBar(
                                                      "Product deleted successfully",
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
                                                      "Failed to delete the product",
                                                      context,
                                                      Colors.red[500],
                                                      false)
                                                }
                                            }
                                        });
                              },
                              icon: const Icon(Icons.delete_forever_outlined),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "\$${widget.cartData.product?.price ?? 0}",
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          CartStepperInt(
                            value: widget.cartData.quantity ?? 1,
                            size: 26,
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
                              elevation: 0,
                              // buttonAspectRatio: 0.7,
                            ),
                            didChangeCount: (count) {
                              if (count < 1) {
                                return;
                              } else if (count > 10) {
                                return;
                              }
                              cartListController.changeItem(
                                  widget.cartData.id!, count);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
