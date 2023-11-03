import 'package:crafty_bay_app/data/models/network_response.dart';
import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/data/utility/urls.dart';

Future<NetworkResponse> createReview(
    String description, int productId, int rating) async {
  final Map<String, dynamic> body = {
    'description': description,
    'product_id': productId,
    'rating': rating,
  };

  return NetworkCaller.postRequest(Urls.CreateReview, body);
}
