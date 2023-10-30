import 'package:crafty_bay_app/data/models/network_response.dart';
import 'package:crafty_bay_app/data/models/product_model.dart';
import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/data/utility/urls.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  static List<int> wishlistProductIds = [];

  bool _getProductsInProgress = false;
  ProductModel _productModel = ProductModel();
  String _message = '';
  bool _getWishListInProgress = false;
  ProductModel _wishlistModel = ProductModel();

  ProductModel get wishlistModel => _wishlistModel;

  bool get getWishListInProgress => _getWishListInProgress;

  ProductModel get productModel => _productModel;

  bool get getProductsInProgress => _getProductsInProgress;

  String get message => _message;

  Future<bool> getProductsByCategory(int categoryId) async {
    _getProductsInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getProductByCategory(categoryId));
    _getProductsInProgress = false;
    if (response.isSuccess) {
      _productModel = ProductModel.fromJson(response.responseJson ?? {});
      update();
      return true;
    } else {
      _message = 'Product list data fetch failed!';
      update();
      return false;
    }
  }

  Future<bool> getWishList() async {
    _getWishListInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getWishListofProduct);
    _getWishListInProgress = false;
    if (response.isSuccess) {
      _wishlistModel = ProductModel.fromJson(response.responseJson ?? {});

      wishlistProductIds =
          _wishlistModel.data?.map((product) => product.id ?? 0).toList() ?? [];
      //print(wishlistProductIds);
      update();
      return true;
    } else {
      _message = 'wish list data fetch failed!';
      update();
      return false;
    }
  }

  void setProducts(ProductModel productModel) {
    _productModel = productModel;
    update();
  }
}
