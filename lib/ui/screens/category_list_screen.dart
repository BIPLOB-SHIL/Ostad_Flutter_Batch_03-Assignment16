import 'package:assignment16/presentation/state_holders/category_controller.dart';
import 'package:assignment16/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:assignment16/ui/screens/product_list_screen.dart';
import 'package:assignment16/ui/widgets/category_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<MainBottomNavController>().backToHome();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Categories",
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
        body: RefreshIndicator(
          onRefresh: () async{
            Get.find<CategoryController>().getCategory();
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: GetBuilder<CategoryController>(builder: (categoryController) {
              if(categoryController.getCategoryInProgress){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                  itemCount: categoryController.categoryModel.data?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    //  crossAxisSpacing: 4,
                    //mainAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) {
                    return FittedBox(
                      child: CategoryCard(
                          categoryData:
                              categoryController.categoryModel.data![index],
                        onTap: () {
                           Get.to(()=>ProductListScreen(
                               categoryId: categoryController.categoryModel.data![index].id!, categoryName: 'All categories',),);
                        },),

                    );
                  });
            }),
          ),
        ),
      ),
    );
  }
}
