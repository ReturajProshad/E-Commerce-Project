import 'package:crafty_bay_app/data/models/cart_list_model.dart';
import 'package:crafty_bay_app/data/models/network_response.dart';
import 'package:crafty_bay_app/data/models/wishListModel.dart';
import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/data/utility/urls.dart';
import 'package:get/get.dart';

class wishListController extends GetxController {
  bool _getWishListInProgress = false;
  wishListModel _wishlistModel = wishListModel();
  String _message = '';

  wishListModel get wishlistModel => _wishlistModel;
  bool get getWishListInProgress => _getWishListInProgress;

  String get message => _message;

  Future<bool> getWishList() async {
    _getWishListInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getWishList);
    _getWishListInProgress = false;
    if (response.isSuccess) {
      _wishlistModel = wishListModel.fromJson(response.responseJson ?? {});
      update();
      return true;
    } else {
      _message = 'wish list data fetch failed!';
      update();
      return false;
    }
  }
}
