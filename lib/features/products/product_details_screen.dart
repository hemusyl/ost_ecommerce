import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ost_ecommerce/features/products/widgets/color_picker.dart';
import 'package:ost_ecommerce/features/products/widgets/product_image_slider.dart';
import 'package:ost_ecommerce/features/products/widgets/size_picker.dart';
import 'package:ost_ecommerce/features/products/widgets/total_price_and_cart_section.dart';

import '../../app/app_colors.dart';

import '../shared/presentation/controllers/product_details_contorller.dart';
import '../shared/presentation/widgets/centered_circular_progress.dart';
import '../shared/presentation/widgets/inc_dec_button.dart';
import '../shared/presentation/widgets/snack_bar_message.dart';
import '../wish/controller/wishlist_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId,});


  static const String name = '/product-details';

  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsController _productDetailsController =
  ProductDetailsController();

  String? _selectedColor;
  String? _selectedSize;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productDetailsController.getProductDetails(widget.productId);
    });
  }

  Future<void> _toggleWishlist(String productId) async {
    try {
      final WishlistController wishlistController =
      Get.find<WishlistController>();

      if (wishlistController.isInWishlist(productId)) {
        // Remove from wishlist
        String? wishlistItemId = wishlistController.getWishlistItemId(
          productId,
        );
        if (wishlistItemId != null) {
          bool isSuccess = await wishlistController.removeFromWishlist(
            wishlistItemId,
          );
          if (isSuccess) {
            showSnackBarMessage(context, 'Removed from wishlist');
          } else {
            showSnackBarMessage(
              context,
              wishlistController.errorMessage ??
                  'Failed to remove from wishlist',
            );
          }
        }
      } else {
        // Add to wishlist
        bool isSuccess = await wishlistController.addToWishlist(productId);
        if (isSuccess) {
          showSnackBarMessage(context, 'Added to wishlist');
        } else {
          showSnackBarMessage(
            context,
            wishlistController.errorMessage ?? 'Failed to add to wishlist',
          );
        }
      }
    } catch (e) {
      showSnackBarMessage(context, 'Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: GetBuilder(
        init: _productDetailsController,
        builder: (controller) {
          if (controller.getProductDetailsInProgress) {
            return CenteredCircularProgress();
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }
          final product = controller.productDetails;

          if (product == null) {
            return const Center(child: Text("No product details found."));
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductImageSlider(
                        imageUrls: controller.productDetails?.photos ?? [],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 5,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.productDetails?.title ?? '',
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
                                                size: 18,
                                                color: Colors.amber,
                                              ),
                                              Text(
                                                controller
                                                    .productDetails
                                                    ?.rating ??
                                                    '',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: Text('Reviews'),
                                          ),
                                          GetBuilder<WishlistController>(
                                            builder: (wishlistController) {
                                              final isInWishlist = wishlistController
                                                  .isInWishlist(product.id);
                                              return GestureDetector(
                                                onTap: () => _toggleWishlist(product.id),
                                                child: Card(
                                                  color: isInWishlist
                                                      ? Colors.red
                                                      : AppColors.themeColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(
                                                      4,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(2),
                                                    child: Icon(
                                                      isInWishlist
                                                          ? Icons.favorite
                                                          : Icons.favorite_outline,
                                                      size: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 86,
                                  // Need to complete
                                  child: IncDecButton(onChange: (int value) {}),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Visibility(
                              visible: (controller.productDetails?.colors ?? [])
                                  .isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  'Color',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ColorPicker(
                              colors: controller.productDetails?.colors ?? [],
                              onSelected: (String color) {
                                setState(() {
                                  _selectedColor = color;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            Visibility(
                              visible: (controller.productDetails?.sizes ?? [])
                                  .isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  'Size',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            SizePicker(
                              sizes: controller.productDetails?.sizes ?? [],
                              onSelected: (String size) {
                                setState(() {
                                  _selectedSize = size;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            Text('Description', style: TextStyle(fontSize: 18)),
                            Text(
                              controller.productDetails?.description ?? '',
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
              TotalPriceAndCartSection(
                productModel: controller.productDetails!,
                selectedColor: _selectedColor,
                selectedSize: _selectedSize,
              ),
            ],
          );
        },
      ),
    );
  }
}