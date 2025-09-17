import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
    return Scaffold(
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
                SizedBox(width: 15.w),
                Expanded(
                  child: Container(
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
                ),
                SizedBox(width: 15.w),
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

            SizedBox(height: 17.h),

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
    );
  }
}

//!_________________________________________________________________________________________________________________________
class ProductCard extends StatelessWidget {
  final ProductsResponseModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Product Image Section with shadow
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 120,
                placeholder:
                    (context, url) => Container(
                      width: double.infinity,
                      height: 120.h,
                      color: Colors.grey[200],
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      width: double.infinity,
                      height: 120.h,
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[400],
                        size: 30.sp,
                      ),
                    ),
              ),
            ),
          ),
        ),

        // Product Details Section - separate container with its own shadow
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0XFFFDFDFD),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.05 * 255).toInt()),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                product.name,
                style: TextStyles.styleMedium(
                  context,
                  fontSize: 13.sp,
                  color: ColorsManager.primaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 6.h),

              // Description - يظهر فقط إذا كان موجود
              if (product.details.isNotEmpty) ...[
                Text(
                  product.details,
                  style: TextStyles.styleMedium(
                    context,
                    fontSize: 9.sp,
                    color: ColorsManager.primaryColor.withAlpha(
                      (60 * 255).toInt(),
                    ),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
              ],

              // Price & Add cart
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "${product.price} EGP",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF866734),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(width: 8.w),

                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      AppIcons.circularCartIcon,
                      height: 24,
                      width: 24,
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

//!_________________________________________________________________________________________________________________________
// class SAD extends StatelessWidget {
//   final ProductsResponseModel product;

//   const SAD({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final imageHeight = screenWidth * 0.3;
//     final padding = screenWidth * 0.03;
//     final iconSize = screenWidth * 0.06;
//     final titleFontSize = screenWidth * 0.035;
//     final descFontSize = screenWidth * 0.025;
//     final priceFontSize = screenWidth * 0.032;

//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withAlpha((0.08 * 255).toInt()),
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Product Image Section
//           ClipRRect(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//             child: CachedNetworkImage(
//               imageUrl: product.imageUrl,
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: imageHeight,
//               placeholder:
//                   (context, url) => Container(
//                     width: double.infinity,
//                     height: imageHeight,
//                     color: Colors.grey[200],
//                   ),
//               errorWidget:
//                   (context, url, error) => Container(
//                     width: double.infinity,
//                     height: imageHeight,
//                     color: Colors.grey[200],
//                     child: Icon(
//                       Icons.image_not_supported,
//                       color: Colors.grey[400],
//                       size: iconSize * 1.5,
//                     ),
//                   ),
//             ),
//           ),

//           // Product Details Section
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.all(padding),
//             decoration: BoxDecoration(
//               color: const Color(0XFFFDFDFD),
//               borderRadius: BorderRadius.vertical(
//                 bottom: Radius.circular(20.r),
//               ),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Title
//                 Text(
//                   product.name,
//                   style: TextStyles.styleMedium(
//                     context,
//                     fontSize: titleFontSize,
//                     color: ColorsManager.primaryColor,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),

//                 SizedBox(height: padding / 2),

//                 // Description
//                 Text(
//                   product.details,
//                   style: TextStyles.styleMedium(
//                     context,
//                     fontSize: descFontSize,
//                     color: ColorsManager.primaryColor.withAlpha(
//                       (60 * 255).toInt(),
//                     ),
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),

//                 SizedBox(height: padding * 0.7),

//                 // Price & Add cart
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         "${product.price} EGP",
//                         style: TextStyle(
//                           fontSize: priceFontSize,
//                           fontWeight: FontWeight.w700,
//                           color: const Color(0xFF866734),
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     SizedBox(width: padding),
//                     GestureDetector(
//                       onTap: () {
//                         // Add to cart logic
//                       },
//                       child: SvgPicture.asset(
//                         AppIcons.circularCartIcon,
//                         width: iconSize,
//                         height: iconSize,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardHeight = constraints.maxHeight;

        // Calculate responsive dimensions
        final imageHeight = cardHeight * 0.45; // 45% of card height

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.05 * 255).toInt()),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Shimmer placeholder for image section
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                child: Container(
                  width: double.infinity,
                  height: imageHeight,
                  color: Colors.grey[300],
                ),
              ),

              // Shimmer placeholder for product details section
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Placeholder for title
                      Container(
                        width: 120.w,
                        height: isSmallScreen ? 11.h : 13.h,
                        color: Colors.grey[300],
                        margin: EdgeInsets.only(
                          bottom: isSmallScreen ? 4.h : 6.h,
                        ),
                      ),
                      // Placeholder for description lines
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 140.w,
                              height: isSmallScreen ? 8.h : 9.h,
                              color: Colors.grey[300],
                              margin: EdgeInsets.only(bottom: 4.h),
                            ),
                            Container(
                              width: 100.w,
                              height: isSmallScreen ? 8.h : 9.h,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 6.h : 8.h),
                      // Placeholder for price and add button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 70.w,
                            height: isSmallScreen ? 10.h : 12.h,
                            color: Colors.grey[300],
                          ),
                          Container(
                            width: isSmallScreen ? 20.w : 24.w,
                            height: isSmallScreen ? 20.h : 24.h,
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
              ),
            ],
          ),
        );
      },
    );
  }
}

//! Jops Grids

class ElectricianProductsGrid extends StatelessWidget {
  String get category => 'Electrician';
  const ElectricianProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductsCubit>().getProducts(category);

    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.8,
            ),
            itemCount: 6,
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
                Icon(Icons.error_outline, size: 45.sp, color: Colors.grey[400]),
                SizedBox(height: 12.h),
                Text(
                  'Error: ${state.errorMessage}',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed:
                      () => context.read<ProductsCubit>().getProducts(category),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state.productsResponseModel == null ||
            state.productsResponseModel!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 45.sp,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 12.h),
                Text(
                  'No products found',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.8,
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
          return GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.8,
            ),
            itemCount: 6,
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
                Icon(Icons.error_outline, size: 45.sp, color: Colors.grey[400]),
                SizedBox(height: 12.h),
                Text(
                  'Error: ${state.errorMessage}',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed:
                      () => context.read<ProductsCubit>().getProducts(category),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state.productsResponseModel == null ||
            state.productsResponseModel!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 45.sp,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 12.h),
                Text(
                  'No products found',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.8,
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
          return GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.8,
            ),
            itemCount: 6,
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
                Icon(Icons.error_outline, size: 45.sp, color: Colors.grey[400]),
                SizedBox(height: 12.h),
                Text(
                  'Error: ${state.errorMessage}',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed:
                      () => context.read<ProductsCubit>().getProducts(category),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state.productsResponseModel == null ||
            state.productsResponseModel!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 45.sp,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 12.h),
                Text(
                  'No products found',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.8,
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
          return GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.8,
            ),
            itemCount: 6,
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
                Icon(Icons.error_outline, size: 45.sp, color: Colors.grey[400]),
                SizedBox(height: 12.h),
                Text(
                  'Error: ${state.errorMessage}',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed:
                      () => context.read<ProductsCubit>().getProducts(category),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state.productsResponseModel == null ||
            state.productsResponseModel!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 45.sp,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 12.h),
                Text(
                  'No products found',
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.8,
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
