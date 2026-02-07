import 'package:flutter/material.dart';
import 'package:shatably_app/feature/shop/data/model/shop_model.dart';

enum ProductsStatus { initial, loading, success, error }

extension ProductsStatesX on ProductsState {
  bool get isInitial => status == ProductsStatus.initial;
  bool get isLoading => status == ProductsStatus.loading;
  bool get isSuccess => status == ProductsStatus.success;
  bool get isError => status == ProductsStatus.error;
}

@immutable
class ProductsState {
  final ProductsStatus status;
  final String? errorMessage;
  final List<ProductsResponseModel>? productsResponseModel; // غيرناها لـ List

  const ProductsState({
    required this.status,
    this.errorMessage,
    this.productsResponseModel,
  });

  ProductsState copyWith({
    ProductsStatus? status,
    String? errorMessage,
    List<ProductsResponseModel>? productsResponseModel, // List
  }) {
    return ProductsState(
      productsResponseModel:
          productsResponseModel ?? this.productsResponseModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductsState &&
        other.status == status &&
        other.errorMessage == errorMessage &&
        other.productsResponseModel == productsResponseModel;
  }

  @override
  int get hashCode =>
      status.hashCode ^ errorMessage.hashCode ^ productsResponseModel.hashCode;
}
