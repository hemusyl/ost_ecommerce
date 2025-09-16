import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../app/constants.dart';

class TotalPriceAndCartSection extends StatelessWidget {
  const TotalPriceAndCartSection({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price', style: TextStyle(color: Colors.black),),
              Text('${takaSign}120', style: textTheme.titleMedium?.copyWith(color: AppColors.themeColor),)
            ],
          ),
          SizedBox(
              width: 120,
              child: FilledButton(onPressed: (){}, child: Text('Add to Cart'))),
        ],
      ),
    );
  }
}
