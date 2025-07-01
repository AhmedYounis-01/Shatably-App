import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shatably_app/core/themes/colors_manager.dart';
import 'package:shatably_app/core/themes/text_styles.dart';
import 'package:shatably_app/core/utils/app_images.dart';
import 'package:shatably_app/core/widgets/custom_app_button1.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [
    CartItem(
      name: "Paint cans",
      description: "Paint tools for painting work",
      price: 200,
      image: AppImages.shopElecImage1,
      quantity: 1,
    ),
    CartItem(
      name: "Tubing Cutter",
      description:
          "precisely cuts through copper, brass, or plastic pipes without leaving rough edges",
      price: 150,
      image: AppImages.shopCarpImage2,
      quantity: 1,
    ),
    CartItem(
      name: "Tool Box",
      description: "compact electrical tools for electrician",
      price: 350,
      image: AppImages.shopElecImage5,
      quantity: 1,
    ),
    CartItem(
      name: "Tool Box",
      description: "compact electrical tools for electrician",
      price: 450,
      image: AppImages.shopPaintImage3,
      quantity: 1,
    ),
    CartItem(
      name: "Tool Box",
      description: "compact electrical tools for electrician",
      price: 350,
      image: AppImages.shopElecImage3,
      quantity: 1,
    ),
  ];

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  double get deliveryFee => 50;
  double get total => subtotal + deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFE5F1EF),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
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
                  Expanded(
                    child: Center(
                      child: Text(
                        "My Cart",
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 14.sp,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 32.w),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            // Cart Items
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 24.h, left: 16, right: 16),
                    child: Row(
                      children: [
                        // Product Image
                        Container(
                          width: 133.w,
                          height: 118.h,
                          decoration: BoxDecoration(
                            color: Color(
                              0XFFC6C6C6,
                            ).withAlpha((.67 * 255).toInt()),
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: Image.asset(
                                item.image,
                                fit: BoxFit.cover,
                                width: 110.w,
                                height: 75.h,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 7.w),

                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextStyles.styleMedium(
                                      context,
                                      fontSize: 12.sp,
                                      color: ColorsManager.primaryColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        cartItems.removeAt(index);
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 16.sp,
                                      color: ColorsManager.primaryColor
                                          .withAlpha((.70 * 255).toInt()),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 2.h),

                              Text(
                                item.description,
                                style: TextStyles.styleRegular(
                                  context,
                                  fontSize: 8.sp,
                                  color: ColorsManager.primaryColor.withAlpha(
                                    (.60 * 255).toInt(),
                                  ),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              SizedBox(height: 25.h),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${item.price} EGP",
                                        style: TextStyles.styleBold(
                                          context,
                                          fontSize: 10.sp,
                                          color: Color(0XFF866734),
                                        ),
                                      ),
                                      Text(
                                        "200 EGP",
                                        style: TextStyles.styleRegular(
                                          context,
                                          fontSize: 8.sp,
                                          color: Color(
                                            0XFF866734,
                                          ).withAlpha((.68 * 255).toInt()),
                                        ).copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Quantity Controls
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (item.quantity > 1) {
                                              setState(() {
                                                item.quantity--;
                                              });
                                            }
                                          },
                                          child: Container(
                                            width: 24.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              border: Border.all(
                                                color: Color(0XFFDDA853),
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              size: 10.sp,
                                              color: ColorsManager.primaryColor,
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.w,
                                          ),
                                          child: Text(
                                            "${item.quantity}",
                                            style: TextStyles.styleMedium(
                                              context,
                                              fontSize: 14.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              item.quantity++;
                                            });
                                          },
                                          child: Container(
                                            width: 24.w,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              border: Border.all(
                                                color: Color(0XFFDDA853),
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              size: 10.sp,
                                              color: ColorsManager.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Summary Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 25.h),
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor.withAlpha(
                  (.67 * 255).toInt(),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal:",
                        style: TextStyles.styleSemiBold(
                          context,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${subtotal.toInt()} EGP",
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 14.sp,
                          color: Color(
                            0XFFD8D8D8,
                          ).withAlpha((.76 * 255).toInt()),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Fee:",
                        style: TextStyles.styleSemiBold(
                          context,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${deliveryFee.toInt()} EGP",
                        style: TextStyles.styleMedium(
                          context,
                          fontSize: 14.sp,
                          color: Color(
                            0XFFD8D8D8,
                          ).withAlpha((.76 * 255).toInt()),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: TextStyles.styleBold(
                          context,
                          fontSize: 18.sp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${total.toInt()}EGP",
                        style: TextStyles.styleSemiBold(
                          context,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 27.h),

                  // Continue Button
                  CustomAppButton1(
                    width: 145.w,
                    height: 50.h,
                    borderRadius: 25.r,
                    hasShadow: true,
                    onPressed: () {},
                    child: Text(
                      "Continue",
                      style: TextStyles.styleSemiBold(
                        context,
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final String name;
  final String description;
  final int price;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.quantity,
  });
}
