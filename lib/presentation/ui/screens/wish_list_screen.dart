import 'package:crafty_bay_app/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay_app/presentation/state_holders/product_list_controller.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/Wish_list_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<ProductListController>().getWishList();
    });
    super.initState();
  }

  Future<void> _refreshWishList() async {
    await Get.find<ProductListController>().getWishList();
  }

  List<int> Wishlistedids = ProductListController.wishlistProductIds;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<MainBottomNavController>().backToHome();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Wishlist',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          leading: const BackButton(
            color: Colors.black,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshWishList,
          child: GetBuilder<ProductListController>(
            builder: (ProductListController) {
              if (ProductListController.getWishListInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (ProductListController.wishlistModel.data?.isEmpty ?? true) {
                return const Center(
                  child: Text('Empty list'),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomScrollView(
                  slivers: [
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product =
                              ProductListController.wishlistModel.data![index];
                          return Wishlist_card(product: product);
                        },
                        childCount:
                            ProductListController.wishlistModel.data?.length ??
                                0,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
