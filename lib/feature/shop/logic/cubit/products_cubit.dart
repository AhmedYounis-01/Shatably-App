import 'package:bloc/bloc.dart';
import 'package:shatably_app/feature/shop/data/repository/products_repository.dart';
import 'package:shatably_app/feature/shop/logic/cubit/products_state.dart';

// class ProductsCubit extends Cubit<ProductsState> {
//   ProductsCubit(this._productsRepository)
//     : super(const ProductsState(status: ProductsStatus.initial));

//   final ProductsRepository _productsRepository;
//   Future<void> getProducts(String category) async {
//     emit(state.copyWith(status: ProductsStatus.loading));
//     try {
//       final productsResponseModel =
//           await _productsRepository.getProducts(category);
//       emit(state.copyWith(
//         status: ProductsStatus.success,
//         productsResponseModel: productsResponseModel,
//       ));
//     } catch (err) {
//       emit(state.copyWith(
//         status: ProductsStatus.error,
//         errorMessage: err.toString(),
//       ));
//     }
//   }
// }
class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productsRepository)
      : super(const ProductsState(status: ProductsStatus.initial));

  final ProductsRepository _productsRepository;
  
  Future<void> getProducts(String category) async {
    emit(state.copyWith(status: ProductsStatus.loading));
    try {
      final productsResponseModel = await _productsRepository.getProducts(category);
      emit(state.copyWith(
        status: ProductsStatus.success,
        productsResponseModel: productsResponseModel,
      ));
    } catch (err) {
      emit(state.copyWith(
        status: ProductsStatus.error,
        errorMessage: err.toString(),
      ));
    }
  }
}
