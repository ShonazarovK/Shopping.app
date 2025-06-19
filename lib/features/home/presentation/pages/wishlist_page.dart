import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:assigment_4/core/common/colors/app_colors.dart';
import 'package:assigment_4/core/text_styles/app_textstyle.dart';
import 'package:assigment_4/features/home/domain/entities/product.dart';
import 'package:assigment_4/features/home/presentation/widgets/product_cardWg.dart';
import '../../../../core/common/widgets/app_bar.dart';
import '../../../../core/route/route_generator.dart';
import '../bloc/all_category_event.dart';
import '../bloc/category/bloc.dart';
import '../bloc/category/single_category_bloc.dart';
import '../bloc/category/single_category_state.dart';
import '../bloc/category/state.dart';
import '../bloc/category_event.dart';
import '../widgets/choosewg.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final List<String> _sortOptions = ['All', 'Clothes', 'Electronics', 'Furniture', 'Shoes'];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<AllProductBloc>().add(FetchAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ActionAppBarWg(
        titleText: "Wishlist",
        onBackPressed: AppRoute.close,
          centerTitle:true
      ),
      body: SafeArea(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryChips(),
            const SizedBox(height: 16),
            _buildProductGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            _sortOptions.length,
                (index) => ChooseWg(
              index: index,
              selectedIndex: _selectedIndex,
              label: _sortOptions[index],
              onSelected: (selected) {
                setState(() => _selectedIndex = selected ? index : 0);

                final selectedSlug = _sortOptions[index].toLowerCase();
                if (selectedSlug == 'all') {
                  context.read<AllProductBloc>().add(FetchAllProducts());
                } else {
                  context.read<CategoryProductBloc>().add(FetchCategoryProducts(selectedSlug));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    if (_selectedIndex == 0) {
      return Expanded(
        child: BlocBuilder<AllProductBloc, AllProductState>(
          builder: (context, state) {
            if (state is AllProductLoading) {
              return const Center(child: SpinKitThreeBounce(color: AppColors.brown, size: 24));
            } else if (state is AllProductLoaded) {
              return _buildGrid(state.products);
            } else if (state is AllProductError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      );
    } else {
      return Expanded(
        child: BlocBuilder<CategoryProductBloc, CategoryProductState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: SpinKitThreeBounce(color: AppColors.brown, size: 24));
            } else if (state is CategoryLoaded) {
              return _buildGrid(state.products);
            } else if (state is CategoryError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      );
    }
  }

  Widget _buildGrid(List<Product> products) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return Stack(
          children: [
            ProductCard(product: product),
            const Positioned(
              top: 8,
              right: 8,
              child: Icon(Icons.favorite, color: AppColors.brown, size: 20),
            ),
          ],
        );
      },
    );
  }
}
