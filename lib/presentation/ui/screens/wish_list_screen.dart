import 'package:crafty_bay_app/presentation/state_holders/Wish_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay_app/presentation/state_holders/product_list_controller.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/category_card.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final productListController = Get.put(ProductListController());

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
            onRefresh: () async {
              Get.find<wishListController>().getWishList();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child:
                  GetBuilder<wishListController>(builder: (wishListController) {
                if (wishListController.getWishListInProgress) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GridView.builder(
                  itemCount: wishListController.wishlistModel.data?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return FittedBox(
                        //child: Text("Returaj"),
                        // child: ProductCard(
                        //   product:
                        //       productListController.productModel.data![index],
                        // ),
                        );
                  },
                );
              }),
            ),
          ),
        ));
  }
}
