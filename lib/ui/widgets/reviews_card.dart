import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/product_review_list_model.dart';

class ReviewsCard extends StatelessWidget {
  const ReviewsCard( {
    super.key, required this.productReviewListData
  });


  final ProductReviewListData productReviewListData;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(
            horizontal: 8, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  FittedBox(
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(
                        Icons.person_2_outlined,
                        color: Colors.black38,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8,),
                   Text(
                    "${productReviewListData.profile?.cusName}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 8,),
               Column(
                children: [
                  Text(
                    "${productReviewListData.description}",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}