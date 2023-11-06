import 'package:crafty_bay_app/data/utility/all_apps.dart';
import 'package:crafty_bay_app/presentation/state_holders/category_controller.dart';
import 'package:crafty_bay_app/presentation/state_holders/new_product_controller.dart';
import 'package:crafty_bay_app/presentation/state_holders/popular_product_controller.dart';
import 'package:crafty_bay_app/presentation/state_holders/product_list_controller.dart';
import 'package:crafty_bay_app/presentation/state_holders/special_product_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screens/read_profileScreen.dart';
import 'package:crafty_bay_app/presentation/ui/widgets/home/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../state_holders/home_slider_controller.dart';
import '../../state_holders/main_bottom_nav_controller.dart';
import '../utility/image_assets.dart';
import '../widgets/category_card.dart';
import '../widgets/circular_icon_button.dart';
import '../widgets/home/home_slider.dart';
import '../widgets/home/section_header.dart';
import '../widgets/product_card.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  // final VoidCallback Wishchanged;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<int> Wlisted = [];
  String searchValue = "";
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Get.find<ProductListController>().getWishList();
    //   Wlisted = ProductListController.wishlistProductIds;
    //   //   //isWishlisteditem();
    //   //   // iswishlisted = isProductInWishlist(widget.productId);
    //   print(Wlisted);
    // });
    _refreshData();
    //   // TODO: implement initState
    super.initState();
  }

  void isChangeInWish(bool Reload) {
    setState(() {});
  }

  Future<void> _refreshData() async {
    await Get.find<ProductListController>().getWishList();
    if (mounted) {
      setState(() {
        //Wlisted = appListClass.wishlistProductIds;
      });
    }
  }

  bool isProductInWishlist(int productId) {
    return appListClass.wishlistProductIds.contains(productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(
              ImageAssets.craftyBayNavLogoSVG,
            ),
            const Spacer(),
            CircularIconButton(
              icon: Icons.light_mode_outlined,
              onTap: () {
                // themeModeController.toggleThemeMode();
                if (Get.isDarkMode) {
                  Get.changeThemeMode(ThemeMode.light);
                } else {
                  Get.changeThemeMode(ThemeMode.dark);
                }
              },
            ),
            const SizedBox(
              width: 8,
            ),
            CircularIconButton(
              icon: Icons.person,
              onTap: () {
                Get.to(ProfileScreen());
              },
            ),
            const SizedBox(
              width: 8,
            ),
            CircularIconButton(
              icon: Icons.call,
              onTap: () {
                //_launchCall();
              },
            ),
            const SizedBox(
              width: 8,
            ),
            CircularIconButton(
              icon: Icons.notifications_none,
              onTap: () {},
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SearchBarWidget(
                  onSearch: (String value) {
                    searchValue = value;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<HomeSlidersController>(
                    builder: (homeSliderController) {
                  if (homeSliderController.getHomeSlidersInProgress) {
                    return const SizedBox(
                      height: 180.0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return HomeSlider(
                    sliders: homeSliderController.sliderModel.data ?? [],
                  );
                }),
                SectionHeader(
                  title: 'Categories',
                  onTap: () {
                    Get.find<MainBottomNavController>().changeScreen(1);
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 90,
                  child: GetBuilder<CategoryController>(
                      builder: (categoryController) {
                    if (categoryController.getCategoriesInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        itemCount:
                            categoryController.categoryModel.data?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            categoryData:
                                categoryController.categoryModel.data![index],
                            onTap: () {
                              Get.to(ProductListScreen(
                                  categoryId: categoryController
                                      .categoryModel.data![index].id!));
                            },
                          );
                        });
                  }),
                ),
                const SizedBox(
                  height: 16,
                ),
                SectionHeader(
                  title: 'Popular',
                  onTap: () {
                    Get.to(ProductListScreen(
                      productModel: Get.find<PopularProductController>()
                          .popularProductModel,
                    ));
                  },
                ),
                SizedBox(
                  height: 165,
                  child: GetBuilder<PopularProductController>(
                      builder: (productController) {
                    if (productController.getPopularProductsInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          productController.popularProductModel.data?.length ??
                              0,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: productController
                              .popularProductModel.data![index],
                          isWlisted: isProductInWishlist(productController
                              .popularProductModel.data![index].id!),
                        );
                      },
                    );
                  }),
                ),
                const SizedBox(
                  height: 16,
                ),
                SectionHeader(
                  title: 'Special',
                  onTap: () {
                    Get.to(ProductListScreen(
                      productModel: Get.find<SpecialProductController>()
                          .specialProductModel,
                    ));
                  },
                ),
                SizedBox(
                  height: 165,
                  child: GetBuilder<SpecialProductController>(
                      builder: (productController) {
                    if (productController.getSpecialProductsInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          productController.specialProductModel.data?.length ??
                              0,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: productController
                              .specialProductModel.data![index],
                          isWlisted: isProductInWishlist(productController
                              .specialProductModel.data![index].id!),
                        );
                      },
                    );
                  }),
                ),
                const SizedBox(
                  height: 16,
                ),
                SectionHeader(
                  title: 'New',
                  onTap: () {
                    Get.to(ProductListScreen(
                      productModel:
                          Get.find<NewProductController>().newProductModel,
                    ));
                  },
                ),
                SizedBox(
                  height: 165,
                  child: GetBuilder<NewProductController>(
                      builder: (productController) {
                    if (productController.getNewProductsInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          productController.newProductModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product:
                              productController.newProductModel.data![index],
                          isWlisted: isProductInWishlist(productController
                              .newProductModel.data![index].id!),
                        );
                      },
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // _launchCall() async {
  //   print("clicked");
  //   const phoneNumber = 'tel:019000';
  //   if (await canLaunch(phoneNumber)) {
  //     await launch(phoneNumber);
  //   } else {
  //     print('Could not launch $phoneNumber');
  //   }
  // }
}
