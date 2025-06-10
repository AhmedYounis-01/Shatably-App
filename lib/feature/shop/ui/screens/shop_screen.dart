import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/core/utils/app_images.dart';

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
                  onTap: () => Navigator.of(context).pop(),
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
                        color: Color(0XFFDDA853).withAlpha((.22 * 255).toInt()),
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
                Row(children: [BasketIconWithBadge(itemCount: 2)]),
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
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Product Image Section
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
          child: Image.asset(
            product.image,
            fit: BoxFit.cover,
            width: 166.w,
            height: 100.h,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 170.w,
                height: 100.h,
                color: Colors.grey[200],
                child: Icon(
                  Icons.image_not_supported,
                  color: Colors.grey[400],
                  size: 32.sp,
                ),
              );
            },
          ),
        ),

        // Product Details Section
        Container(
          width: 166.w,
          height: 92.h,
          decoration: BoxDecoration(
            color: Color(0XFFFDFDFD),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.1 * 255).toInt()),
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                product.title,
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
                product.description,
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

              Spacer(),

              // Price & Add
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.price,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF866734),
                    ),
                  ),
                  SvgPicture.asset(AppIcons.circularCartIcon),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductModel {
  final String title;
  final String description;
  final String price;
  final String image;

  ProductModel({
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });
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
              color: Color(0xFFDDA853).withAlpha((.37 * 255).toInt()),
            ),
            child: Center(
              child: Text(
                '$itemCount',
                style: TextStyle(
                  fontSize: 6.sp,
                  color: Color(0xFF204B56),
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

//! Jops Grids
class ElectricianProductsGrid extends StatelessWidget {
  const ElectricianProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      ProductModel(
        title: 'Pliers packages',
        description: 'different pliers for electrician work',
        price: '150 EGP',
        image: AppImages.shopElecImage1,
      ),
      ProductModel(
        title: 'Screw package',
        description: 'Screw and screw driver for electrician work',
        price: '150 EGP',
        image: AppImages.shopElecImage2,
      ),
      ProductModel(
        title: 'Electrical package',
        description: 'different electrical tools for electrician work',
        price: '300 EGP',
        image: AppImages.shopElecImage3,
      ),
      ProductModel(
        title: 'Tool Box',
        description: 'different electrical tools for electrician work',
        price: '350EGP',
        image: AppImages.shopElecImage4,
      ),
      ProductModel(
        title: 'Electrical package',
        description: 'Steel hammer with other construction elements tools',
        price: '250 EGP',
        image: AppImages.shopElecImage5,
      ),
      ProductModel(
        title: 'Circuit Repairing',
        description: 'Close up circuit repairing for electrician work',
        price: '100 EGP',
        image: AppImages.shopElecImage6,
      ),
    ];

    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6.w,
        mainAxisSpacing: 12.h,
        // childAspectRatio: 0.9, // Adjust aspect ratio for better fit
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

class CarpentryProductsGrid extends StatelessWidget {
  const CarpentryProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      ProductModel(
        title: 'Hammer',
        description: 'Hammer with relaxed hand hold for carpentry work',
        price: '150 EGP',
        image: AppImages.shopCarpImage1,
      ),
      ProductModel(
        title: 'lumberjack',
        description: 'lumberjack cutting wood with chainsaw',
        price: '800 EGP',
        image: AppImages.shopCarpImage2,
      ),
      ProductModel(
        title: 'Hacksaw',
        description:
            'Hacksaw for cutting metal and plastic, often in the form of strips, rods, dowels, and brackets',
        price: '100 EGP',
        image: AppImages.shopCarpImage3,
      ),
      ProductModel(
        title: 'Hand Saw',
        description:
            'Handle at the back, traditionally made of wood and a long protruding blade.',
        price: '150 EGP',
        image: AppImages.shopCarpImage4,
      ),
      ProductModel(
        title: 'Full package',
        description: 'Different carpentry tools for electrician work',
        price: '1000 EGP',
        image: AppImages.shopCarpImage5,
      ),
      ProductModel(
        title: 'Drill',
        description: 'Electric hammer drill with glasses for protection',
        price: '500 EGP',
        image: AppImages.shopCarpImage6,
      ),
    ];

    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6.w,
        mainAxisSpacing: 12.h,
        // childAspectRatio: 0.9, // Adjust aspect ratio for better fit
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

class PainterProductsGrid extends StatelessWidget {
  const PainterProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      ProductModel(
        title: 'Brushes',
        description: 'Brushes painting for painting work',
        price: '150 EGP',
        image: AppImages.shopPaintImage1,
      ),
      ProductModel(
        title: 'Paint cans',
        description: 'Paint cans for painting work',
        price: '200 EGP',
        image: AppImages.shopPaintImage2,
      ),
      ProductModel(
        title: 'Roller brushes',
        description: 'Roller brushes applying a smooth, even coat of paint',
        price: '150 EGP',
        image: AppImages.shopPaintImage3,
      ),
      ProductModel(
        title: 'Ladder',
        description: 'Ladder help you reach the higher parts of the wall',
        price: '350 EGP',
        image: AppImages.shopPaintImage4,
      ),
      ProductModel(
        title: 'paint pens',
        description:
            'Touch-up paint pens can save you time and effort as you paint and later on',
        price: '80 EGP',
        image: AppImages.shopPaintImage5,
      ),
    ];

    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6.w,
        mainAxisSpacing: 12.h,
        // childAspectRatio: 0.9, // Adjust aspect ratio for better fit
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

class PlumberProductsGrid extends StatelessWidget {
  const PlumberProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      ProductModel(
        title: 'Pipe Wrench',
        description: 'plumbing repairs that involve fixing pipes',
        price: '150 EGP',
        image: AppImages.shopPlumbImage1,
      ),
      ProductModel(
        title: 'Faucet Valves',
        description: 'control the flow of water in your plumbing system',
        price: '800 EGP',
        image: AppImages.shopPlumbImage2,
      ),
      ProductModel(
        title: 'Teflon Tape',
        description:
            'handy for sealing threaded connections such as pipe thread and preventing leaks',
        price: '10 EGP',
        image: AppImages.shopPlumbImage3,
      ),
      ProductModel(
        title: 'Tubing Cutter',
        description:
            'precisely cuts through copper, brass, or plastic pipes without leaving rough edges',
        price: '150 EGP',
        image: AppImages.shopPlumbImage4,
      ),
    ];

    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6.w,
        mainAxisSpacing: 12.h,
        // childAspectRatio: 0.9, // Adjust aspect ratio for better fit
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
