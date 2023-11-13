import 'package:assignment16/presentation/state_holders/category_controller.dart';
import 'package:assignment16/presentation/state_holders/home_slider_controller.dart';
import 'package:assignment16/presentation/state_holders/new_product_controller.dart';
import 'package:assignment16/presentation/state_holders/popular_product_controller.dart';
import 'package:assignment16/presentation/state_holders/special_product_controller.dart';
import 'package:assignment16/ui/screens/auth/email_verification_screen.dart';
import 'package:assignment16/ui/screens/product_list_screen.dart';
import 'package:assignment16/ui/screens/read_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../ utility/image_assets.dart';
import '../ utility/show_snackbar.dart';
import '../../presentation/state_holders/auth_controller.dart';
import '../../presentation/state_holders/main_bottom_nav_controller.dart';
import '../widgets/category_card.dart';
import '../widgets/circular_icon_button.dart';
import '../widgets/home/selection_header.dart';
import '../widgets/home/home_slider.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String customerSupport = '01717376932';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              SvgPicture.asset(ImageAssets.craftyBayNavLogoSVG),
              const Spacer(),
              CircularIconButton(
                onPressed: () {
                  if (Get.isDarkMode) {
                    Get.changeThemeMode(ThemeMode.light);
                  } else {
                    Get.changeThemeMode(ThemeMode.dark);
                  }
                },
                icon: Icons.light_mode_outlined,
              ),
              const SizedBox(
                width: 8,
              ),
              CircularIconButton(
                onPressed: () {
                  Get.to(() => const ReadProfileScreen());
                },
                icon: Icons.person_2_outlined,
              ),
              const SizedBox(
                width: 8,
              ),
              CircularIconButton(
                onPressed: () async {
                  FlutterPhoneDirectCaller.callNumber(customerSupport);
                },
                icon: Icons.call_outlined,
              ),
              const SizedBox(
                width: 8,
              ),
              CircularIconButton(
                onPressed: () {},
                icon: Icons.notifications_active_outlined,
              ),
              const SizedBox(
                width: 8,
              ),
              CircularIconButton(
                onPressed: () async {
                  await AuthController.clearUserInfo();
                  await AuthController.getAccessToken();
                  if (mounted) {
                      Get.offAll(() => const EmailVerificationScreen());
                    showSnackBar("Logout successful",
                        context, Colors.green[500], true);
                  } else {
                    if (mounted) {
                      showSnackBar("Logout failed", context,
                          Colors.red[500], false);
                    }
                  }
                },
                icon: Icons.login_outlined,
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: "Search",
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GetBuilder<HomeSlidersController>(
                  builder: (homeSliderController) {
                if (homeSliderController.getHomeSlidersInProgress) {
                  return const SizedBox(
                    height: 180,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return HomeSlider(
                  slider: homeSliderController.sliderModel.data ?? [],
                );
              }),
              SelectionHeader(
                title: "Categories",
                onTap: () {
                  Get.find<MainBottomNavController>().changeScreen(1);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 90,
                child: GetBuilder<CategoryController>(
                    builder: (categoryController) {
                  if (categoryController.getCategoryInProgress) {
                    return const SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount:
                        categoryController.categoryModel.data?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        categoryData:
                            categoryController.categoryModel.data![index],
                        onTap: () {
                          Get.to(
                            () => ProductListScreen(
                              categoryId: categoryController
                                  .categoryModel.data![index].id!,
                              categoryName: 'All Categories',
                            ),
                          );
                        },
                      );
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 16,
              ),
              SelectionHeader(
                title: "Popular",
                onTap: () {
                  Get.to(
                    () => ProductListScreen(
                      productModel: Get.find<PopularProductController>()
                          .popularProductModel,
                      categoryName: 'Popular product',
                    ),
                  );
                },
              ),
              SizedBox(
                height: 130, //166
                child: GetBuilder<PopularProductController>(
                    builder: (popularProductController) {
                  if (popularProductController.getPopularProductInProgress) {
                    return const SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: popularProductController
                            .popularProductModel.data?.length ??
                        0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: popularProductController
                            .popularProductModel.data![index],
                      );
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 16,
              ),
              SelectionHeader(
                  title: "Special",
                  onTap: () {
                    Get.to(
                      () => ProductListScreen(
                        productModel: Get.find<SpecialProductController>()
                            .specialProductModel,
                        categoryName: 'Special product',
                      ),
                    );
                  }),
              SizedBox(
                height: 130,
                child: GetBuilder<SpecialProductController>(
                    builder: (specialProductController) {
                  if (specialProductController.getSpecialProductInProgress) {
                    return const SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: specialProductController
                            .specialProductModel.data?.length ??
                        0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: specialProductController
                            .specialProductModel.data![index],
                      );
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 16,
              ),
              SelectionHeader(
                title: "New",
                onTap: () {
                  Get.to(
                    () => ProductListScreen(
                      productModel:
                          Get.find<NewProductController>().newProductModel,
                      categoryName: 'New product',
                    ),
                  );
                },
              ),
              SizedBox(
                height: 130,
                child: GetBuilder<NewProductController>(
                    builder: (newProductController) {
                  if (newProductController.getNewProductInProgress) {
                    return const SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount:
                        newProductController.newProductModel.data?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product:
                            newProductController.newProductModel.data![index],
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
