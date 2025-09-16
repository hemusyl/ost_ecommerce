import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/presentation/controllers/main_nav_controller.dart';
import '../shared/presentation/widgets/product_card.dart';


class wishListScreen extends StatefulWidget {
  const wishListScreen({super.key});
  static const String name = '/wish-list';

  @override
  State<wishListScreen> createState() => _wishListScreenState();
}

class _wishListScreenState extends State<wishListScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        _backToHome();

      } ,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wishlist'),
          leading: BackButton(onPressed: _backToHome),
        ),
        body: GridView.builder(
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index){
              return FittedBox(child: ProductCard());
            }),
      ),
    );
  }

  void _backToHome() {
    Get.find<MainNavController>().backToHome();

  }
}