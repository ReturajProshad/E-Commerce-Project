import 'package:crafty_bay_app/data/models/network_response.dart';
import 'package:crafty_bay_app/data/models/product_model.dart';
import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/data/utility/all_apps.dart';
import 'package:crafty_bay_app/data/utility/urls.dart';
import 'package:get/get.dart';

// Number of lines : 35
// SRP - Single Responsibility Principle

class PopularProductController extends GetxController {
  bool _getPopularProductsInProgress = false;
  ProductModel _popularProductModel = ProductModel();
  String _errorMessage = '';

  bool get getPopularProductsInProgress => _getPopularProductsInProgress;

  ProductModel get popularProductModel => _popularProductModel;

  String get errorMessage => _errorMessage;

  Future<bool> getPopularProducts() async {
    _getPopularProductsInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getProductsByRemarks('popular'));
    _getPopularProductsInProgress = false;
    if (response.isSuccess) {
      _popularProductModel = ProductModel.fromJson(response.responseJson ?? {});
      _popularProductModel.data!.forEach((element) {
        appListClass.appLists[element.id ?? 0] = element.title ?? '';
      });
      // print("popular");
      // print(appListClass.appLists);
      update();
      return true;
    } else {
      _errorMessage = 'Popular product fetch failed! Try again.';
      update();
      return false;
    }
  }
}
