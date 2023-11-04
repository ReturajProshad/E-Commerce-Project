import 'package:crafty_bay_app/data/models/product_model.dart';
import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/data/utility/urls.dart';
import 'package:get/get.dart';
import 'package:crafty_bay_app/data/utility/all_apps.dart';
import '../../data/models/network_response.dart';

class SpecialProductController extends GetxController {
  bool _getSpecialProductsInProgress = false;
  ProductModel _specialProductModel = ProductModel();
  String _errorMessage = '';

  bool get getSpecialProductsInProgress => _getSpecialProductsInProgress;

  ProductModel get specialProductModel => _specialProductModel;

  String get errorMessage => _errorMessage;

  Future<bool> getSpecialProducts() async {
    _getSpecialProductsInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getProductsByRemarks('special'));
    _getSpecialProductsInProgress = false;
    if (response.isSuccess) {
      _specialProductModel = ProductModel.fromJson(response.responseJson ?? {});
      _specialProductModel.data!.forEach((element) {
        appListClass.appLists[element.id ?? 0] = element.title ?? '';
      });
      update();
      return true;
    } else {
      _errorMessage = 'Special product fetch failed! Try again.';
      update();
      return false;
    }
  }
}
