import 'package:assignment16/presentation/state_holders/home_slider_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectionHeader extends StatefulWidget {
  const SelectionHeader({
    super.key, required this.title, required this.onTap
  });

  final String title;
  final VoidCallback onTap;

  @override
  State<SelectionHeader> createState() => _SelectionHeaderState();
}

class _SelectionHeaderState extends State<SelectionHeader> {

  bool _isTextButtonEnable = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeSlidersController>(
      builder: (homeSlidersController) {
        if(homeSlidersController.getHomeSlidersInProgress){
          _isTextButtonEnable = false;
        }else {
          _isTextButtonEnable = true;
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700
              ),),
            Visibility(
              visible: _isTextButtonEnable,
              child: TextButton(onPressed: widget.onTap,
                child: const Text("See All"),),
            )
          ],
        );
      }
    );
  }
}