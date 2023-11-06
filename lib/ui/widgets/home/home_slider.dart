import 'package:assignment16/ui/%20utility/image_assets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ utility/color_palettes.dart';
import '../../../data/models/slider_data.dart';

class HomeSlider extends StatefulWidget {
  final List<SliderData> slider;

  const HomeSlider({super.key, required this.slider});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        CarouselSlider(
          options: CarouselOptions(
              height: 180,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              }),
          items: widget.slider.map((sliderData) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Stack(
                   // alignment: Alignment.centerLeft,
                    children: [
                      Image.network(sliderData.image ?? '',
                      height: double.infinity,
                       width: double.infinity,
                      fit: BoxFit.fitHeight,)
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < widget.slider.length; i++)
              Container(
                height: 13,
                width: 13,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: currentIndex == i
                      ? AppColors.primaryColor
                      : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              )
          ],
        ),
      ],
    );
  }
}
