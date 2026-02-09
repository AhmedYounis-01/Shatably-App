import 'package:bloc/bloc.dart';
import 'package:shatably_app/core/services/api/server_failure.dart';
import 'package:shatably_app/feature/shop/data/model/shop_model.dart';
import 'package:shatably_app/feature/shop/data/repository/products_repository.dart';
import 'package:shatably_app/feature/shop/logic/cubit/products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productsRepository)
    : super(const ProductsState(status: ProductsStatus.initial));

  final ProductsRepository _productsRepository;

  // Memory cache للمنتجات
  final Map<String, List<ProductsResponseModel>> _cachedProducts = {};

  Future<void> getProducts(String category) async {
    // تحقق من الـ cache الأول
    if (_cachedProducts.containsKey(category)) {
      // لو موجود، اعرضه فوراً بدون loading
      emit(
        state.copyWith(
          status: ProductsStatus.success,
          productsResponseModel: _cachedProducts[category],
        ),
      );
      return; // خلاص، مفيش داعي للـ API call
    }

    // لو مش موجود في الـ cache، اعمل API call
    emit(state.copyWith(status: ProductsStatus.loading));
    try {
      final productsResponseModel = await _productsRepository.getProducts(
        category,
      );

      // احفظ في الـ cache عشان المرات الجاية
      _cachedProducts[category] = productsResponseModel;

      emit(
        state.copyWith(
          status: ProductsStatus.success,
          productsResponseModel: productsResponseModel,
        ),
      );
    } on ServerFailure catch (err) {
      emit(
        state.copyWith(status: ProductsStatus.error, errorMessage: err.message),
      );
    } catch (err) {
      emit(
        state.copyWith(
          status: ProductsStatus.error,
          errorMessage: err.toString(),
        ),
      );
    }
  }

  // optional: لو عايز تحديث البيانات من الـ server
  // Future<void> refreshProducts(String category) async {
  // امسح من الـ cache وحمل من جديد
  //   _cachedProducts.remove(category);
  //   await getProducts(category);
  // }

  // optional: لو عايز تمسح كل الـ cache
  // void clearAllCache() {
  //   _cachedProducts.clear();
  // }
}
