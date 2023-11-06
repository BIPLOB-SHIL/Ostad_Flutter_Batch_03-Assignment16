import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ utility/color_palettes.dart';

class ProductImageSlider extends StatefulWidget {
  final List<String> imageList;
  const ProductImageSlider({super.key, required this.imageList});

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 330,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 1,
              onPageChanged: (index, reason){
                setState(() {
                  currentIndex = index;
                });

              }
          ),
          items: widget.imageList.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return  Container(
                  width: MediaQuery.of(context).size.width,
                  decoration:  BoxDecoration(
                   //color: Colors.grey.shade200,
                    image:  DecorationImage(
                      image: NetworkImage(
                        imageUrl
                      ),
                      fit: BoxFit.scaleDown,
                    // scale: 1,
                    ),
                   // borderRadius: BorderRadius.circular(0),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i= 0; i<widget.imageList.length; i++)
                Container(
                  height: 13,
                  width: 13,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: currentIndex == i ? AppColors.primaryColor : Colors.grey,
                    shape: BoxShape.circle,
                  ),

                )
            ],
          ),
        ),
      ],
    );
  }
}