import 'package:crafty_bay_app/data/models/product_model.dart';
import 'package:crafty_bay_app/data/utility/all_apps.dart';
import 'package:crafty_bay_app/presentation/state_holders/product_list_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  final int? categoryId;
  final ProductModel? productModel;
  const ProductListScreen({super.key, this.categoryId, this.productModel});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.categoryId != null) {
        Get.find<ProductListController>()
            .getProductsByCategory(widget.categoryId!);
      } else if (widget.productModel != null) {
        Get.find<ProductListController>().setProducts(widget.productModel!);
      }
      _refreshData();
    });
    super.initState();
  }

  List<int> Wlisted = [];
  bool iswishlisted = false;
  Future<void> _refreshData() async {
    await Get.find<ProductListController>().getWishList();
    if (mounted) {
      setState(() {
        Wlisted = appListClass.wishlistProductIds;
      });
    }
  }

  bool isProductInWishlist(int productId) {
    return Wlisted.contains(productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Product list',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: GetBuilder<ProductListController>(builder: (productListController) {
        if (productListController.getProductsInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (productListController.productModel.data?.isEmpty ?? true) {
          return const Center(
            child: Text('Empty list'),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
              itemCount: productListController.productModel.data?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return FittedBox(
                  child: ProductCard(
                    product: productListController.productModel.data![index],
                    isWlisted: isProductInWishlist(
                        productListController.productModel.data![index].id!),
                  ),
                );
              }),
        );
      }),
    );
  }
}
