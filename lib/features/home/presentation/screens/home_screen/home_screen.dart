import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ost_ecommerce/features/shared/presentation/controllers/category_controller.dart';
import 'package:ost_ecommerce/features/shared/presentation/widgets/centered_circular_progress.dart';

import '../../../../../app/asset_paths.dart';
import '../../../../shared/presentation/controllers/main_nav_controller.dart';
import '../../../../shared/presentation/controllers/new_product_controller.dart';
import '../../../../shared/presentation/screens/search_results_page.dart';
import '../../../../shared/presentation/widgets/app_bar_icon_button.dart';
import '../../../../shared/presentation/widgets/home_banner_slider.dart';
import '../../../../shared/presentation/widgets/product_card.dart';
import '../../../../shared/presentation/widgets/product_category_item.dart';
import '../../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../../../wish/controller/wishlist_controller.dart';
import '../../controllers/home_slider_controller.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late ScrollController _scrollController;


  @override
  void initState() {
    super.initState();

    Get.put(NewProductController());

    Get.find<NewProductController>().getNewProductList();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Trigger load more when user scrolls near the bottom
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Get.find<NewProductController>().getNewProductList();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(AssetPaths.logoNavSvg),
        actions: [
          AppBarIconButton(onTap: () {}, iconData: Icons.person),
          AppBarIconButton(onTap: () {}, iconData: Icons.call),
          AppBarIconButton(
            onTap: () {},
            iconData: Icons.notifications_on_outlined,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 16),
              GetBuilder<HomeSliderController>(
                builder: (controller) {
                  if (controller.getSlidersInProgress) {
                    return SizedBox(
                      height: 180,
                      child: CenteredCircularProgress(),
                    );
                  }
                  return HomeBannerSlider(sliders: controller.sliders);
                },
              ),
              const SizedBox(height: 16),
              _buildSectionHeader(
                title: 'All Categories',
                onTapSeeAll: () {
                  Get.find<MainNavController>().moveToCategory();
                },
              ),
              _buildCategoryList(),

              _buildSectionHeader(title: 'New', onTapSeeAll: () {}),
              _buildNewProductList(),

              _buildSectionHeader(title: 'Special', onTapSeeAll: () {}),
              _buildSpecialProductList(),
              _buildSectionHeader(title: 'Popular', onTapSeeAll: () {}),
              _buildPopularProductList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 100,
      child: GetBuilder<CategoryController>(
        builder: (controller) {
          if (controller.isInitialLoading) {
            return CenteredCircularProgress();
          }
          return ListView.separated(
            itemCount: controller.categoryList.length > 10
                ? 10
                : controller.categoryList.length,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductCategoryItem(
                categoryModel: controller.categoryList[index],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 10);
            },
          );
        },
      ),
    );
  }

  Widget _buildNewProductList() {
    return SizedBox(
      height: 190,
      child: GetBuilder<NewProductController>(
        builder: (controller) {
          if (controller.isInitialLoading) {
            return SizedBox(height: 150, child: CenteredCircularProgress());
          }

          if (controller.NewProductList.isEmpty) {
            return SizedBox(
              height: 100,
              child: Center(child: Text('No new products found')),
            );
          }

          return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.NewProductList.length,
              itemBuilder: (context, index) {
                final product = controller.NewProductList[index];
                return GetBuilder<WishlistController>(
                  builder: (wishlistController) {
                    return ProductCard(
                      productModel: product,
                      onWishlistToggle: () => _toggleWishlist(product.id),
                      isInWishlist: wishlistController.isInWishlist(product.id),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }


  Widget _buildPopularProductList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // child: Row(children: [1, 2, 3, 4, 56].map((e) => ProductCard()).toList()),
    );
  }

  Widget _buildSpecialProductList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      //  child: Row(children: [1, 2, 3, 4, 56].map((e) => ProductCard()).toList()),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required VoidCallback onTapSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        TextButton(onPressed: onTapSeeAll, child: Text('See all')),
      ],
    );
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


  Widget _buildSearchBar() {
    return TextField(
      onSubmitted: (String text) {
        if (text.isNotEmpty) {
          Get.to(() => SearchResultsPage(query: text));
        }
      },
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search',
        fillColor: Colors.grey.shade100,
        filled: true,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }



}

