import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/colors.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/core/widgets/custom_elevated_button.dart';
import 'package:medical/features/cart/data/models/cart_model.dart';
import 'package:medical/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:medical/features/cart/presentation/view/cart.dart';
import 'package:medical/core/dependency_injection/service_locator.dart';

import 'package:medical/features/notification/presentation/view/notification_screen.dart';
import 'package:medical/features/product_details/presentation/cubit/product_cubit.dart';
import 'package:medical/features/product_details/presentation/cubit/product_state.dart';
import 'package:medical/features/product_details/presentation/view/widget/container_package_size.dart';
import 'package:medical/features/product_details/presentation/view/widget/rating_analyzing_row.dart';
import 'package:sizer/sizer.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.productId});
  final int productId;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<ProductDetailsCubit>()..fetchProductById(1),
        ),
        BlocProvider(create: (_) => sl<CartCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context); // Fixed: Added proper navigation
            },
          ),
          actions: [
            Padding(
              // Fixed: Wrapped in Padding instead of Row
              padding: EdgeInsets.only(right: 4.w),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Fixed: Added mainAxisSize
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NotificationScreen(
                            repository: sl.get(),
                            onBackPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                    child: SvgPicture.asset(AssetsData.notifications),
                  ),
                  SizedBox(width: 2.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CartView()),
                      );
                    },
                    child: SvgPicture.asset(AssetsData.shoppingBag),
                  ),
                ],
              ),
            ),
          ],
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: BlocBuilder<ProductDetailsCubit, ProductStates>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                } else if (state is ProductSucces) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.product.data?.name ?? "product name",
                          style: Styles.textStyle22,
                        ),
                        Text(
                          state.product.data?.unit?.name ?? "Unit name",
                          style: Styles.textStyle16,
                        ),
                        SizedBox(height: 2.h),
                        SizedBox(
                          height: 20.h,
                          child: Center(
                            child: Image.network(
                              state.product.data?.imageUrl ??
                                  "https://medical.digital-vision-solutions.com/storage/image.png",
                              height: 20.h,
                              width: 30.w,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 20.h,
                                  width: 30.w,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.image_not_supported),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Fixed: Added crossAxisAlignment
                          children: [
                            Expanded(
                              // Fixed: Wrapped in Expanded
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "\$${state.product.data?.oldPrice.toString() ?? "26"}",
                                        style: Styles.textStyle18.copyWith(
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      SizedBox(width: 2.w),
                                      Text(
                                        "\$${state.product.data?.newPrice.toString() ?? '0'}",
                                        style: Styles.textStyle18.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    state.product.data?.description ??
                                        "no description",
                                    style: Styles.textStyle18.copyWith(
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              // Fixed: Wrapped in Expanded
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(AssetsData.addCart),
                                      SizedBox(width: 1.w),
                                      Flexible(
                                        // Fixed: Added Flexible
                                        child: TextButton(
                                          onPressed: () async {
                                            if (state.product.data != null) {
                                              final cartItem = CartItemModel(
                                                id: state.product.data!.id
                                                    .toString(),
                                                productId: state
                                                    .product
                                                    .data!
                                                    .id
                                                    .toString(),
                                                imageUrl:
                                                    state
                                                        .product
                                                        .data!
                                                        .imageUrl ??
                                                    "https://medical.digital-vision-solutions.com/storage/image.png",
                                                price:
                                                    (state
                                                                .product
                                                                .data!
                                                                .newPrice ??
                                                            0)
                                                        .toDouble(),
                                                quantity:
                                                    1, // Start with quantity 1
                                              );

                                              // Show loading indicator or disable button
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Adding to cart...',
                                                  ),
                                                ),
                                              );

                                              await context
                                                  .read<CartCubit>()
                                                  .addItem(cartItem);

                                              // Optional: Show success message
                                              if (mounted) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Item added to cart successfully!',
                                                    ),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                          child: Text(
                                            ConstantText.addToCart,
                                            style: TextStyle(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Divider(
                          indent: 2.h,
                          endIndent: 2.h,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          ConstantText.packageSize,
                          style: Styles.textStyle18,
                        ),
                        SizedBox(height: 1.h),
                        SingleChildScrollView(
                          // Fixed: Added horizontal scroll for package sizes
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ContainerPackageSize(
                                textColor: ColorsHelper.amber,
                                borderColor: ColorsHelper.amber,
                                price: "Rs.100",
                                noPallets: "500 pellets",
                              ),
                              SizedBox(width: 2.w),
                              ContainerPackageSize(
                                price: "Rs.166",
                                noPallets: "110 pellets",
                              ),
                              SizedBox(width: 2.w),
                              ContainerPackageSize(
                                price: "Rs.252",
                                noPallets: "300 pellets",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          ConstantText.productDetails,
                          style: Styles.textStyle16,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          state.product.data?.description ?? "no description",
                          style: Styles.textStyle16.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          ConstantText.ingredients,
                          style: Styles.textStyle16,
                        ),
                        SizedBox(height: 4.h),
                        _buildDateBrandRow(
                          title: ConstantText.expiryDate,
                          value: state.product.data?.expiryDate ?? "26/6/2028",
                        ),
                        SizedBox(height: 1.h),
                        _buildDateBrandRow(
                          title: ConstantText.brandName,
                          value:
                              state.product.data?.brand?.name ?? "brand name",
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Fixed: Added crossAxisAlignment
                          children: [
                            Expanded(
                              // Fixed: Wrapped in Expanded
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${state.product.data?.averageRating ?? 0}",
                                        style: Styles.textStyle33,
                                      ),
                                      SizedBox(width: 2.w),
                                      Icon(
                                        Icons.star,
                                        color: ColorsHelper.amber,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                  Text("10 Ratings", style: Styles.textStyle14),
                                  Text(
                                    "and ${state.product.data?.reviewsCount ?? 0} Reviews",
                                    style: Styles.textStyle14,
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(width: 2.w),
                            Expanded(
                              // Fixed: Wrapped in Expanded
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 25.h, // Fixed: Reduced height
                                    child: ListView.builder(
                                      shrinkWrap:
                                          true, // Fixed: Added shrinkWrap
                                      physics:
                                          NeverScrollableScrollPhysics(), // Fixed: Added physics
                                      itemBuilder: (context, index) {
                                        return RatingAnalyzingRow(
                                          ratingNo: "${5 - index}",
                                          valueLinearProgressIndicator: 0.01,
                                          ratePrecentage:
                                              "${state.product.data?.averageRating ?? 0}%",
                                        );
                                      },
                                      itemCount: 5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(Icons.star, color: ColorsHelper.amber),
                            SizedBox(width: 1.w),
                            Text(
                              "${state.product.data?.averageRating ?? 0}",
                              style: Styles.textStyle16,
                            ),
                            Spacer(),
                            Text("05- oct 2020", style: Styles.textStyle16),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text("Erric Hoffman", style: Styles.textStyle16),
                        SizedBox(height: 1.h),
                        Text(
                          "Interdum et malesuada fames ac ante ipsum primis in faucibus. Morbi ut nisi odio. Nulla facilisi. Nunc risus massa, gravida id egestas ",
                          style: Styles.textStyle16.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        CustomElevatedButton(
                          buttonText: "GO To CART ",
                          onPressedFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartView(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 2.h), // Fixed: Added bottom spacing
                      ],
                    ),
                  );
                }
                return Center(child: Text("No product found"));
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateBrandRow({required String title, required String value}) {
    return Row(
      children: [
        Expanded(
          // Fixed: Added Expanded
          flex: 2,
          child: Text(title, style: Styles.textStyle16),
        ),
        Expanded(
          // Fixed: Added Expanded
          flex: 3,
          child: Text(
            value,
            style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
