import 'package:crafty_bay_app/data/models/product_details.dart';
import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/data/utility/all_apps.dart';
import 'package:crafty_bay_app/data/utility/urls.dart';
import 'package:crafty_bay_app/presentation/state_holders/add_to_cart_controller.dart';
import 'package:crafty_bay_app/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay_app/presentation/state_holders/product_list_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screens/home_screen.dart';
import 'package:crafty_bay_app/presentation/ui/screens/review_screen.dart';
import '../utility/app_colors.dart';
import '../widgets/custom_stepper.dart';
import '../widgets/home/product_image_slider.dart';
import '../widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  HomeScreen? homescreenInstance;
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  int quantity = 1;
  List<int> Wlisted = [];
  bool iswishlisted = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductDetailsController>().getProductDetails(widget.productId);
      Get.find<ProductListController>().getWishList();
      Wlisted = appListClass.wishlistProductIds;
      //isWishlisteditem();
      iswishlisted = isProductInWishlist(widget.productId);
      // print("from pdetails");
      // print(Wlisted);
      // print(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
        if (productDetailsController.getProductDetailsInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          productImageSlider(productDetailsController),
                          productDetailsAppBar,
                        ],
                      ),
                      productDetails(productDetailsController.productDetails,
                          productDetailsController.availableColors),
                    ],
                  ),
                ),
              ),
              cartToCartBottomContainer(
                productDetailsController.productDetails,
                productDetailsController.availableColors,
                productDetailsController.availableSizes,
              ),
            ],
          ),
        );
      }),
    );
  }

  ProductImageSlider productImageSlider(
      ProductDetailsController productDetailsController) {
    return ProductImageSlider(
      imageList: [
        productDetailsController.productDetails.img1 ?? '',
        productDetailsController.productDetails.img2 ?? '',
        productDetailsController.productDetails.img3 ?? '',
        productDetailsController.productDetails.img4 ?? '',
      ],
    );
  }

  Padding productDetails(ProductDetails productDetails, List<String> colors) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                productDetails.product?.title ?? '',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5),
              )),
              CustomStepper(
                  lowerLimit: 1,
                  upperLimit: 10,
                  stepValue: 1,
                  value: 1,
                  onChange: (newValue) {
                    //  print(quantity);
                    quantity = newValue;
                  })
            ],
          ),
          Star_review_wishlist_button(productDetails),
          const Text(
            'Color',
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 28,
            child: SizedBox(
              height: 28,
              child: SizePicker(
                initialSelected: 0,
                onSelected: (int selectedSize) {
                  _selectedColorIndex = selectedSize;
                },
                sizes: productDetails.color?.split(',') ?? [],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Size',
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 28,
            child: SizedBox(
              height: 28,
              child: SizePicker(
                initialSelected: 0,
                onSelected: (int selectedSize) {
                  _selectedSizeIndex = selectedSize;
                },
                sizes: productDetails.size?.split(',') ?? [],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Description',
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(productDetails.des ?? ''),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row Star_review_wishlist_button(ProductDetails productDetails) {
    return Row(
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(
              Icons.star,
              size: 18,
              color: Colors.amber,
            ),
            Text(
              '${productDetails.product?.star ?? 0}',
              style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            //print(widget.productId);
            Get.to(ReviewScreen(
              Pid: widget.productId,
            ));
          },
          child: const Text(
            'Review',
            style: TextStyle(
                fontSize: 15,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500),
          ),
        ),
        InkWell(
          onTap: () {
            addToWishlist();
          },
          child: Card(
            color: iswishlisted ? Colors.red : AppColors.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                iswishlisted
                    ? Icons.format_overline_sharp
                    : Icons.favorite_border,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  AppBar get productDetailsAppBar {
    return AppBar(
      leading: const BackButton(
        color: Colors.black54,
      ),
      title: const Text(
        'Product details',
        style: TextStyle(color: Colors.black54),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Container cartToCartBottomContainer(
      ProductDetails details, List<String> colors, List<String> sizes) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black54),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '${details.product?.price}',
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.primaryColor),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child:
                GetBuilder<AddToCartController>(builder: (addToCartController) {
              if (addToCartController.addToCartInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ElevatedButton(
                onPressed: () async {
                  print(widget.productId);
                  final result = await addToCartController.addToCart(
                    widget.productId,
                    colors[_selectedColorIndex].toString(),
                    sizes[_selectedSizeIndex],
                    quantity,
                  );
                  if (result) {
                    Get.snackbar('Added to cart',
                        'This product has been added to cart list',
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
                child: const Text('Add to cart'),
              );
            }),
          )
        ],
      ),
    );
  }

  addToWishlist() async {
    //  print(iswishlisted);
    if (iswishlisted == false) {
      final response =
          await NetworkCaller.getRequest(Urls.addWishList(widget.productId));
      if (response.isSuccess) {
        Get.snackbar("Congratulations", "successfully added to wishlist");
        if (mounted) {
          setState(() {
            iswishlisted = true;
          });
        }
      }
    } else {
      final response = await NetworkCaller.getRequest(
          Urls.RemovefromWishList(widget.productId));
      if (response.isSuccess) {
        Get.snackbar("Removed", "successfully removed from wishlist");
        if (mounted) {
          setState(() {
            iswishlisted = false;
          });
        }
      }
    }
    //HomeScreen(Wishchanged: () {});
  }

  bool isProductInWishlist(int productId) {
    return Wlisted.contains(productId);
  }
}
