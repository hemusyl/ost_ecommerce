import 'package:flutter/material.dart';
import 'package:ost_ecommerce/features/products/widgets/product_image_slider.dart';
import 'package:ost_ecommerce/features/products/widgets/total_price_and_cart_section.dart';

import '../../app/app_colors.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  static const String name = '/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                ProductImageSlider(),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Nikw A123 - New Edition Of Jordan',
                                style: textTheme.bodyLarge,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 18,
                                        color: Colors.amber,
                                      ),
                                      Text('4.2'),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Card(
                                      color: AppColors.themeColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: Icon(
                                        Icons.favorite_outline,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          TotalPriceAndCartSection(),
        ],
      ),
    );
  }
}
