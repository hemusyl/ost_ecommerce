import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../shared/presentation/widgets/inc_dec_button.dart';
import '../controllers/cart_list_controller.dart';
import '../data/models/cart_item_model.dart';


class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.cartItemModel});

  final CartItemModel cartItemModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16),
      shadowColor: AppColors.themeColor.withOpacity(0.3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(),
            child: Image.network(
              cartItemModel.product.photos.isEmpty
                  ? ''
                  : cartItemModel.product.photos.first,
              height: 80,
              width: 80,
              errorBuilder: (_, __, ___) => Container(
                height: 80,
                width: 80,
                alignment: Alignment.center,
                child: Icon(Icons.error_outline),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItemModel.product.title,
                              style: TextTheme.of(context).titleSmall,
                            ),
                            Text(
                              'Size: ${cartItemModel.size ?? 'Nil'}  Color: ${cartItemModel.color ?? 'Nil'}',
                              style: TextTheme.of(context).bodySmall,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          // Ask user to confirm before deleting
                          final confirm = await Get.dialog<bool>(
                            AlertDialog(
                              title: Text('Remove Item'),
                              content: Text('Are you sure you want to delete this item from your cart?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(result: false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Get.back(result: true),
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {

                           final controller = Get.find<CartListController>();
                           final success = await controller.removeCart(cartItemModel.id);

                            if (success) {
                              Get.snackbar(
                                'Removed',
                                'Item removed from cart',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green.shade50,
                                colorText: Colors.black,
                              );
                            } else {
                              Get.snackbar(
                                'Error',
                                controller.errorMessage ?? 'Failed to remove item',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red.shade50,
                                colorText: Colors.black,
                              );
                            }
                          }
                        },
                        icon: Icon(Icons.delete_forever_outlined, color: Colors.redAccent, size: 26,),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$takaSign${cartItemModel.product.currentPrice}',
                        style: TextTheme.of(
                          context,
                        ).titleSmall?.copyWith(color: AppColors.themeColor),
                      ),
                      IncDecButton(onChange: (int value) {
                        Get.find<CartListController>().updateCart(cartItemModel.id, value);
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


