import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/feature/shop/data/model/shop_model.dart';
import 'package:shatably_app/feature/shop/logic/cubit/products_cubit.dart';
import 'package:shatably_app/feature/shop/logic/cubit/products_state.dart';
import 'package:shatably_app/feature/shop/ui/screens/cart_screen.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductsCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0XFFE5F1EF),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFBEE1DB),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: ColorsManager.primaryColor,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 275.w,
                    height: 35.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 19.w,
                      // vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.backGroundFormsColor,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Color(
                            0XFFDDA853,
                          ).withAlpha((.22 * 255).toInt()),
                          blurRadius: 10.4,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 18.sp,
                          color: ColorsManager.primaryColor.withAlpha(
                            (.60 * 255).toInt(),
                          ),
                        ),
                        SizedBox(width: 1.5.w),
                        Text(
                          "Search here",
                          style: TextStyles.styleRegular(
                            context,
                            color: ColorsManager.primaryColor.withAlpha(
                              (.60 * 255).toInt(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  InkWell(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        ),
                    child: BasketIconWithBadge(itemCount: 5),
                  ),
                ],
              ),
              SizedBox(height: 17.h),

              // TabBar
              Container(
                height: 35.h,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0XFFE5F1EF),
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: ColorsManager.yellowTextColor),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: ColorsManager.primaryColor,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: Color(0xFFDDA853),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelStyle: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: [
                    Tab(text: 'Electrician'),
                    Tab(text: 'Carpentry'),
                    Tab(text: 'Painter'),
                    Tab(text: 'Plumber'),
                  ],
                ),
              ),

              SizedBox(height: 28.h),

              // TabBarView
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Electrician Tab
                    ElectricianProductsGrid(),
                    // Carpentry Tab
                    CarpentryProductsGrid(),
                    // Painter Tab
                    PainterProductsGrid(),
                    // Plumber Tab
                    PlumberProductsGrid(),
                  ],
                ),
              ),
              SizedBox(height: 110.h),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductsResponseModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Product Image Section
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
          child: CachedNetworkImage(
            imageUrl: product.imageUrl,
            fit: BoxFit.cover,
            width: 166.w,
            height: 100.h,
            placeholder:
                (context, url) => Container(
                  width: 166.w,
                  height: 100.h,
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
            errorWidget:
                (context, url, error) => Container(
                  width: 170.w,
                  height: 100.h,
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[400],
                    size: 32.sp,
                  ),
                ),
          ),
        ),

        // Product Details Section
        Container(
          width: 166.w,
          height: 92.h,
          decoration: BoxDecoration(
            color: const Color(0XFFFDFDFD),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.1 * 255).toInt()),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                product.name,
                style: TextStyles.styleMedium(
                  context,
                  fontSize: 12.sp,
                  color: ColorsManager.primaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),

              // Description
              Text(
                product.details,
                style: TextStyles.styleMedium(
                  context,
                  fontSize: 8.sp,
                  color: ColorsManager.primaryColor.withAlpha(
                    (60 * 255).toInt(),
                  ),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const Spacer(),

              // Price & Add
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${product.price} EGP",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF866734),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add to cart logic
                    },
                    child: SvgPicture.asset(AppIcons.circularCartIcon),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BasketIconWithBadge extends StatelessWidget {
  final int itemCount;

  const BasketIconWithBadge({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Badge circle
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 10.w,
            height: 10.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFDDA853).withAlpha((.37 * 255).toInt()),
            ),
            child: Center(
              child: Text(
                '$itemCount',
                style: TextStyle(
                  fontSize: 6.sp,
                  color: const Color(0xFF204B56),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SvgPicture.asset(AppIcons.cartShopIcon),
      ],
    );
  }
}

/// A placeholder widget that mimics the appearance of a product card during loading.
/// This widget provides a static gray box structure to indicate content is being loaded.
class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Shimmer placeholder for image section
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
          child: Container(
            width: 166.w,
            height: 100.h,
            color: Colors.grey[300], // Lighter grey for the image placeholder
          ),
        ),

        // Shimmer placeholder for product details section
        Container(
          width: 166.w,
          height: 92.h,
          decoration: BoxDecoration(
            color: Colors.grey[200], // Slightly darker grey for details
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.05 * 255).toInt()),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder for title
              Container(
                width: 100.w,
                height: 12.h,
                color: Colors.grey[300],
                margin: EdgeInsets.only(bottom: 4.h),
              ),
              // Placeholder for description lines
              Container(
                width: 140.w,
                height: 8.h,
                color: Colors.grey[300],
                margin: EdgeInsets.only(bottom: 4.h),
              ),
              Container(width: 120.w, height: 8.h, color: Colors.grey[300]),
              const Spacer(),
              // Placeholder for price and add button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 60.w, height: 12.h, color: Colors.grey[300]),
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//! Jops Grids

class ElectricianProductsGrid extends StatelessWidget {
  String get category => 'Electrician';
  const ElectricianProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure the cubit fetches products when this widget is built/rebuilt
    // if the category changes or it's the initial load.
    // This is typically called once in initState or on the first build based on dependencies.
    // For simplicity, calling it here for each category grid.
    context.read<ProductsCubit>().getProducts(category);

    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state.isLoading) {
          // Display shimmer effect when loading
          return GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.85,
            ),
            itemCount: 6, // Show 6 shimmer placeholders
            itemBuilder: (context, index) {
              return const ProductCardShimmer();
            },
          );
        }

        if (state.isError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.errorMessage}'),
                ElevatedButton(
                  onPressed:
                      () => context.read<ProductsCubit>().getProducts(category),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.productsResponseModel == null ||
            state.productsResponseModel!.isEmpty) {
          return const Center(child: Text('No products found'));
        }

        return GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 6.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.85,
          ),
          itemCount: state.productsResponseModel!.length,
          itemBuilder: (context, index) {
            return ProductCard(product: state.productsResponseModel![index]);
          },
        );
      },
    );
  }
}

class CarpentryProductsGrid extends StatelessWidget {
  String get category => 'Carpentry';
  const CarpentryProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductsCubit>().getProducts(category);

    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state.isLoading) {
          // Display shimmer effect when loading
          return GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.85,
            ),
            itemCount: 6, // Show 6 shimmer placeholders
            itemBuilder: (context, index) {
              return const ProductCardShimmer();
            },
          );
        }

        if (state.isError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.errorMessage}'),
                ElevatedButton(
                  onPressed:
                      () => context.read<ProductsCubit>().getProducts(category),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.productsResponseModel == null ||
            state.productsResponseModel!.isEmpty) {
          return const Center(child: Text('No products found'));
        }

        return GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 6.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.85,
          ),
          itemCount: state.productsResponseModel!.length,
          itemBuilder: (context, index) {
            return ProductCard(product: state.productsResponseModel![index]);
          },
        );
      },
    );
  }
}

class PainterProductsGrid extends StatelessWidget {
  String get category => 'Painter';
  const PainterProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductsCubit>().getProducts(category);

    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state.isLoading) {
          // Display shimmer effect when loading
          return GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.85,
            ),
            itemCount: 6, // Show 6 shimmer placeholders
            itemBuilder: (context, index) {
              return const ProductCardShimmer();
            },
          );
        }

        if (state.isError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.errorMessage}'),
                ElevatedButton(
                  onPressed:
                      () => context.read<ProductsCubit>().getProducts(category),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.productsResponseModel == null ||
            state.productsResponseModel!.isEmpty) {
          return const Center(child: Text('No products found'));
        }

        return GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 6.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.85,
          ),
          itemCount: state.productsResponseModel!.length,
          itemBuilder: (context, index) {
            return ProductCard(product: state.productsResponseModel![index]);
          },
        );
      },
    );
  }
}

class PlumberProductsGrid extends StatelessWidget {
  String get category => 'Plumber';
  const PlumberProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductsCubit>().getProducts(category);

    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state.isLoading) {
          // Display shimmer effect when loading
          return GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.85,
            ),
            itemCount: 6, // Show 6 shimmer placeholders
            itemBuilder: (context, index) {
              return const ProductCardShimmer();
            },
          );
        }

        if (state.isError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.errorMessage}'),
                ElevatedButton(
                  onPressed:
                      () => context.read<ProductsCubit>().getProducts(category),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.productsResponseModel == null ||
            state.productsResponseModel!.isEmpty) {
          return const Center(child: Text('No products found'));
        }

        return GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 6.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.85,
          ),
          itemCount: state.productsResponseModel!.length,
          itemBuilder: (context, index) {
            return ProductCard(product: state.productsResponseModel![index]);
          },
        );
      },
    );
  }
}
