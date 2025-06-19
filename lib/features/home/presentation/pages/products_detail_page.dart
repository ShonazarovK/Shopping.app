import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconly/iconly.dart';
import '../../../../core/common/colors/app_colors.dart';
import '../../../../core/text_styles/app_textstyle.dart';
import '../../../../core/text_styles/urbanist_textstyle.dart';
import '../../../../core/common/responsivenes/app_responsicenes.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_details/bloc.dart';
import '../bloc/product_details/state.dart';
import '../bloc/product_details_event.dart';


class ProductDetailsPage extends StatefulWidget {
  final int id;

  const ProductDetailsPage({super.key, required this.id});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int? _selectedSizeIndex;

  @override
  void initState() {
    super.initState();
    context.read<SingleProductBloc>().add(FetchSingleProduct(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'];
    final List<Color> colors = [Colors.brown, Colors.black, Colors.grey, Colors.orange, Colors.white];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocBuilder<SingleProductBloc, SingleProductState>(
          builder: (context, state) {
            if (state is SingleProductLoading) {
              return const Center(child: SpinKitThreeBounce(color: AppColors.brown, size: 24));
            } else if (state is SingleProductLoaded) {
              final product = state.product;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          product.image,
                          height: appH(300),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: appH(16),
                          left: appW(16),
                          child: CircleAvatar(
                            backgroundColor: AppColors.white,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back, color: AppColors.black),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                        Positioned(
                          top: appH(16),
                          right: appW(16),
                          child: CircleAvatar(
                            backgroundColor: AppColors.white,
                            child: Icon(Icons.favorite_border, color: AppColors.black),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appW(16), vertical: appH(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category: ${product.title}",
                            style: AppTextStyles.urbanist.regular(
                              color: AppColors.grey,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              SizedBox(width: appW(4)),
                              Text("4.5", style: AppTextStyles.urbanist.medium(
                                color: AppColors.black,
                                fontSize: 16,
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appW(16)),
                      child: Text(
                        product.title,
                        style: AppTextStyles.urbanist.bold(
                          color: AppColors.black,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(appW(16)),
                      child: Text(
                        product.description,
                        style: AppTextStyles.urbanist.regular(
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appW(16)),
                      child: Text('Select Size',
                        style: AppTextStyles.urbanist.semiBold(
                          color: AppColors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appW(16), vertical: appH(8)),
                      child: Wrap(
                        spacing: 8,
                        children: List.generate(sizes.length, (index) {
                          final selected = _selectedSizeIndex == index;
                          return ChoiceChip(
                            label: Text(
                              sizes[index],
                              style: AppTextStyles.urbanist.medium(
                                color: selected ? AppColors.white : AppColors.black,
                                fontSize: 14,
                              ),
                            ),
                            selected: selected,
                            selectedColor: AppColors.brown,
                            backgroundColor: AppColors.greyScale.grey100,
                            onSelected: (_) {
                              setState(() {
                                _selectedSizeIndex = index;
                              });
                            },
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appW(16)),
                      child: Text('Select Color : Brown',
                        style: AppTextStyles.urbanist.semiBold(
                          color: AppColors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: appW(16), vertical: appH(8)),
                      child: Row(
                        children: colors
                            .map((color) => Container(
                          margin: EdgeInsets.only(right: appW(8)),
                          width: appW(28),
                          height: appW(28),
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.brown),
                          ),
                        ))
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(appW(16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product.price}',
                            style: AppTextStyles.urbanist.bold(
                              color: AppColors.black,
                              fontSize: 22,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.shopping_cart),
                            label: Text('Add to Cart',
                              style: AppTextStyles.urbanist.semiBold(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.brown,
                              padding:
                              EdgeInsets.symmetric(horizontal: appW(24), vertical: appH(12)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (state is SingleProductError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
