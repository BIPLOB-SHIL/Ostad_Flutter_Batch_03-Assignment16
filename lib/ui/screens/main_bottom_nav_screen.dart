import 'package:assignment16/presentation/state_holders/category_controller.dart';
import 'package:assignment16/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:assignment16/presentation/state_holders/new_product_controller.dart';
import 'package:assignment16/presentation/state_holders/popular_product_controller.dart';
import 'package:assignment16/presentation/state_holders/read_profile_controller.dart';
import 'package:assignment16/presentation/state_holders/special_product_controller.dart';
import 'package:assignment16/ui/%20utility/color_palettes.dart';
import 'package:assignment16/ui/screens/cart_screen.dart';
import 'package:assignment16/ui/screens/category_list_screen.dart';
import 'package:assignment16/ui/screens/home_screen.dart';
import 'package:assignment16/ui/screens/wish_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../presentation/state_holders/home_slider_controller.dart';


class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {


  final List<Widget> _screens =[
     const HomeScreen(),
     const CategoryListScreen(),
     const CartScreen(),
     const WishListScreen(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomeSlidersController>().getHomeSliders();
      Get.find<CategoryController>().getCategory();
      Get.find<PopularProductController>().getPopularProduct();
      Get.find<SpecialProductController>().getSpecialProduct();
      Get.find<NewProductController>().getNewProduct();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
      builder: (controller) {
        return Scaffold(
          body: _screens[controller.currentSelectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentSelectedIndex,
            onTap: controller.changeScreen,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_filled,),label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.dashboard,),label: "Categories"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,),label: "Cart"),
              BottomNavigationBarItem(icon: Icon(Icons.wallet_giftcard_sharp,),label: "Wish"),
            ],
          ),
        );
      }
    );
  }
}
