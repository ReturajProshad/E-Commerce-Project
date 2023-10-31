import 'package:crafty_bay_app/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay_app/presentation/state_holders/product_list_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utility/app_colors.dart';

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
                          return InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              Get.to(ProductDetailsScreen(
                                productId: product.product!.id!,
                              ));
                            },
                            child: Card(
                              shadowColor:
                                  AppColors.primaryColor.withOpacity(0.1),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: SizedBox(
                                width: 25,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor
                                            .withOpacity(0.1),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              product.product!.image ?? ''),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            product.product!.title ?? '',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blueGrey),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\$${product.product!.price ?? 0}',
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Wrap(
                                                crossAxisAlignment:
                                                    WrapCrossAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    size: 15,
                                                    color: Colors.amber,
                                                  ),
                                                  Text(
                                                    '${product.product!.star ?? 0}',
                                                    style: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.blueGrey),
                                                  ),
                                                ],
                                              ),
                                              const Card(
                                                color: AppColors.primaryColor,
                                                child: Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: Icon(
                                                    Icons.format_overline_sharp,
                                                    size: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          ;
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
