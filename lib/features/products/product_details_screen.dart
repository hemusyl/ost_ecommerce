import 'package:flutter/material.dart';
import 'package:ost_ecommerce/features/products/widgets/color_picker.dart';
import 'package:ost_ecommerce/features/products/widgets/product_image_slider.dart';
import 'package:ost_ecommerce/features/products/widgets/size_picker.dart';
import 'package:ost_ecommerce/features/products/widgets/total_price_and_cart_section.dart';

import '../../app/app_colors.dart';
import '../shared/presentation/widgets/inc_dec_button.dart';

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageSlider(),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nikw A123 - New Edition Of Jordan',
                                    style: textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Wrap(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 22,
                                            color: Colors.amber,
                                          ),
                                          Text('4.2', style: TextStyle(
                                            fontSize: 18,
                                          ), ),
                                        ],
                                      ),
                                      TextButton(onPressed: (){}, child: Text('Reviews'),),
                                      Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Card(
                                          color: AppColors.themeColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(2),
                                          ),
                                          child: Icon(
                                            Icons.favorite_outline,
                                            size: 22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 95,
                              child: IncDecButton(onChange: (int value) {}),
                            ),
                          ],
                        ),
                        Text('Color',style: TextStyle(fontSize: 18),),
                        const SizedBox(height: 8,),
                        ColorPicker(colors: ['Red','Black', 'White'], onSelected: (String ) {  },),
                        const SizedBox(height: 8,),
                        Text('Size',style: TextStyle(fontSize: 18),),
                        const SizedBox(height: 8,),
                        SizePicker(sizes: ['S','M', 'L'], onSelected: (String ) {  },),
                        const SizedBox(height: 15),
                        Text('Description', style: TextStyle(fontSize: 18)),
                        Text(
                          '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book''',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          TotalPriceAndCartSection(),
        ],
      ),
    );
  }
}
