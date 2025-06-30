import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/dependency_injection/service_locator.dart';

import 'package:medical/core/utils/assets.dart';
import 'package:medical/core/utils/colors.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/cart/presentation/view/cart.dart';
import 'package:medical/features/category_listing/data/repository/all_product_repository.dart';
import 'package:medical/features/category_listing/presentation/cubit/all_product_cubit.dart';
import 'package:medical/features/category_listing/presentation/cubit/all_product_states.dart';
import 'package:medical/features/category_listing/presentation/view/category_listing.dart';
import 'package:medical/features/category_listing/presentation/view/widgets/product_item.dart';
import 'package:medical/features/home/presentation/cubit/search_cubit.dart';
import 'package:medical/features/home/presentation/view/widget/category_item.dart';

import 'package:medical/features/notification/presentation/view/notification_screen.dart';
import 'package:medical/features/product_details/presentation/view/product_details.dart';

import 'package:sizer/sizer.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({super.key});

  @override
  State<HomeDetails> createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AllProductCubit(sl<AllProductRepository>())..getProducts(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: ColorsHelper.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/150?img=3',
                              ),
                            ),
                            const Spacer(),

                            InkWell(
                              onTap: () {
                                // Navigate to product details page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationScreen(),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                AssetsData.notifications,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 12),
                            InkWell(
                              onTap: () {
                                // Navigate to product details page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartView(),
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                AssetsData.shopping,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Hi, ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Welcome to Nilkanth Medical Store',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: BlocProvider(
                        create: (_) => sl<SearchCubit>(),
                        child: Builder(
                          builder: (context) {
                            final cubit = context.read<SearchCubit>();
                            return Column(
                              children: [
                                TextField(
                                  onChanged: (value) {
                                    if (value.length >= 2) {
                                      cubit.search(value);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Search products',
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                                BlocBuilder<SearchCubit, SearchState>(
                                  builder: (context, state) {
                                    if (state is SearchLoading) {
                                      return const LinearProgressIndicator();
                                    } else if (state is SearchSuccess &&
                                        state.results.isNotEmpty) {
                                      return Container(
                                        height: 100,
                                        color: Colors.white,
                                        child: ListView.builder(
                                          itemCount: state.results.length,
                                          itemBuilder: (context, index) {
                                            final product =
                                                state.results[index];
                                            return ListTile(
                                              title: Text(product.name),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        ProductDetails(
                                                          productId: product.id,
                                                        ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Top Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        CategoryItem(title: 'Dental', color: Colors.pinkAccent),
                        CategoryItem(
                          title: 'Medication',
                          color: Colors.greenAccent,
                        ),
                        CategoryItem(
                          title: 'Homeo',
                          color: Colors.orangeAccent,
                        ),
                        CategoryItem(
                          title: 'Eye care',
                          color: Colors.blueAccent,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Stack(
                      children: [
                        Image.asset(AssetsData.saveHome),
                        Positioned(
                          left: 4.h,
                          bottom: 0,
                          top: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Save extra on\n every order',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Etiam mollis metus\n non faucibus.',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ConstantText.dealsOfDay,
                          style: Styles.textStyle16,
                        ),
                        TextButton(
                          child: Text(
                            ConstantText.more,
                            style: Styles.textStyle14,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryListing(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    // SizedBox(height: 5.h),
                    BlocBuilder<AllProductCubit, AllProductState>(
                      builder: (context, state) {
                        if (state is AllProductLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is AllProductError) {
                          return Center(child: Text(state.message));
                        } else if (state is AllProductLoaded) {
                          final categories = state.products;
                          if (categories.isEmpty) {
                            return Center(child: Text("No data available"));
                          }
                          return SizedBox(
                            height: 70.h,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: 0.87,
                                  ),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                return ProductItem(
                                  onTap: () {
                                    // Navigate to product details page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CategoryListing(),
                                      ),
                                    );
                                  },
                                  productId: categories[index].id,
                                  badge: "",
                                  imageUrl:
                                      categories[index].imageUrl ??
                                      AssetsData.productImage1,
                                  title: categories[index].name,
                                  price: "RS. ${categories[index].newPrice}",
                                  rating: categories[index].rating.toString(),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(child: Text("No data available"));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
