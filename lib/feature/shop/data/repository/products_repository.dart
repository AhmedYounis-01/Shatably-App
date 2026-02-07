import 'package:shatably_app/core/services/api/api_consumer.dart';
import 'package:shatably_app/core/services/api/end_points.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/shop/data/model/shop_model.dart';

class ProductsRepository {
  final ApiConsumer _apiConsumer;

  ProductsRepository(this._apiConsumer);

  Future<List<ProductsResponseModel>> getProducts(String category) async {
    try {
      final response = await _apiConsumer.get(
        '${EndPoints.getProducts}/$category',
      );

      if (response.data is List) {
        return (response.data as List)
            .map((json) => ProductsResponseModel.fromJson(json))
            .toList();
      } else if (response.data['products'] != null) {
        return (response.data['products'] as List)
            .map((json) => ProductsResponseModel.fromJson(json))
            .toList();
      } else {
        return [ProductsResponseModel.fromJson(response.data)];
      }
    } on ServerFailure catch (err) {
      throw Exception(
        'Error fetching products: ${err.message} (${err.statusCode})',
      );
    }
  }
}
