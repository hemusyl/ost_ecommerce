import 'package:flutter/material.dart';
import 'package:ost_ecommerce/features/shared/presentation/widgets/product_card.dart';

class wishListScreen extends StatefulWidget {
  const wishListScreen({super.key,});

  @override
  State<wishListScreen> createState() => _wishListScreenState();
}

class _wishListScreenState extends State<wishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: GridView.builder(
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index){
            return FittedBox(child: ProductCard());
          }),
    );
  }
}
