import 'package:assignment16/data/models/category_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ utility/color_palettes.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,  required this.categoryData, required this.onTap,
  });

  final CategoryData categoryData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(1),
            highlightColor: AppColors.primaryColor.withOpacity(0.1),
            splashColor: AppColors.primaryColor.withOpacity(0.1),
            onTap: onTap,
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),),
              child: Image.network(
                categoryData.categoryImg ?? '',
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
           Text(
            categoryData.categoryName ?? '',
            style: const TextStyle(
                fontSize: 15,
                color: AppColors.primaryColor,
                letterSpacing: 0.4),
          )
        ],
      ),
    );
  }
}
