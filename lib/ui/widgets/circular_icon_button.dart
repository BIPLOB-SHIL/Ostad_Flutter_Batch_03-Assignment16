import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    super.key, required this.icon, required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.grey.shade200,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon,color: Colors.grey,),
      ),
    );
  }
}