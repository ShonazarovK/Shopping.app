import 'package:assigment_4/core/common/colors/app_colors.dart';
import 'package:assigment_4/features/home/presentation/pages/products_detail_page.dart';
import 'package:assigment_4/features/home/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/text_styles/app_textstyle.dart';
import '../../../../core/widgets/CustomNavbarWg.dart';
import '../../domain/entities/product.dart';
import '../bloc/all_category_event.dart';
import '../bloc/category/bloc.dart';
import '../bloc/category/single_category_bloc.dart';
import '../bloc/category/single_category_state.dart';
import '../bloc/category/state.dart';
import '../bloc/category_event.dart';
import '../widgets/choosewg.dart';
import '../widgets/product_cardWg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedSortIndex = 0;
  final List<String> _sortOptions = [
    'All',
    'Clothes',
    'Electronics',
    'Furniture',
    'Shoes',
  ];

  @override
  void initState() {
    super.initState();
    context.read<AllProductBloc>().add(FetchAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildCategoryChips(),
            const SizedBox(height: 16),
            Expanded(
              child:
              _selectedSortIndex == 0
                  ? BlocBuilder<AllProductBloc, AllProductState>(
                builder: (context, state) {
                  if (state is AllProductLoading)
                    return const Center(
                      child: SpinKitThreeBounce(
                          color: AppColors.brown, size: 24),
                    );
                  if (state is AllProductLoaded)
                    return _buildGrid(state.products);
                  if (state is AllProductError)
                    return Center(child: Text(state.message));
                  return const SizedBox();
                },
              )
                  : BlocBuilder<CategoryProductBloc, CategoryProductState>(
                builder: (context, state) {
                  if (state is CategoryLoading)
                    return const Center(
                      child: SpinKitThreeBounce(
                          color: AppColors.brown, size: 24),
                    );
                  if (state is CategoryLoaded)
                    return _buildGrid(state.products);
                  if (state is CategoryError)
                    return Center(child: Text(state.message));
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: AppTextStyles.urbanist.regular(
                      color: AppColors.grey,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'New York, USA',
                    style: AppTextStyles.urbanist.semiBold(
                      color: AppColors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              IconButton(icon: const Icon(Icons.notification_add), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            readOnly: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchPage()),
              );
            },
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search, color: AppColors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.brown,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Collection',
                      style: AppTextStyles.urbanist.bold(
                        color: AppColors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Discount 50% for the first transaction',
                      style: AppTextStyles.urbanist.regular(
                        color: AppColors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Shop Now',
                    style: AppTextStyles.urbanist.semiBold(
                      color: AppColors.brown,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Category',
                style: AppTextStyles.urbanist.semiBold(
                  color: AppColors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                'Closing in: 02 : 12 : 56',
                style: AppTextStyles.urbanist.regular(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                _sortOptions.length,
                    (index) =>
                    ChooseWg(
                      index: index,
                      selectedIndex: _selectedSortIndex,
                      label: _sortOptions[index],
                      onSelected: (selected) {
                        setState(() {
                          _selectedSortIndex = selected ? index : 0;
                        });

                        final selectedSlug = _sortOptions[index].toLowerCase();
                        if (selectedSlug == 'all') {
                          context.read<AllProductBloc>().add(
                              FetchAllProducts());
                        } else {
                          context.read<CategoryProductBloc>().add(
                            FetchCategoryProducts(selectedSlug),
                          );
                        }
                      },
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(List<Product> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final p = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsPage(id: p.id),
              ),
            );
          },
          child: ProductCard(product: p),
        );
      },

    );
  }
}
