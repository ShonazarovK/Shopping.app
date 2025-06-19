import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/common/colors/app_colors.dart';
import '../../../../core/text_styles/app_textstyle.dart';
import '../bloc/search_product/bloc.dart';
import '../bloc/search_product/state.dart';
import '../bloc/search_product_event.dart';
import '../widgets/product_cardWg.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _recentSearches = [
    'phone',
    'CosmicChic Jacket',
    'EnchantedElegance Dress',
    'WhimsyWhirl Top',
    'Fluffernova Coat',
  ];
  String _lastQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.greyScale.grey100,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        onChanged: (query) {
                          setState(() => _lastQuery = query);
                          context.read<SearchBloc>().add(SearchQueryChanged(query));
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: AppTextStyles.urbanist.regular(
                            color: AppColors.greyScale.grey500,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (_searchController.text.isEmpty) {
                    // RECENT
                    return _buildRecentList();
                  } else if (state is SearchLoading) {
                    return const Center(child: SpinKitThreeBounce(color: AppColors.brown, size: 24));
                  } else if (state is SearchLoaded) {
                    if (state.results.isEmpty) {
                      return const Center(child: Text('No results found.'));
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Result for "$_lastQuery"',
                                style: AppTextStyles.urbanist.semiBold(
                                  color: AppColors.black,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                '${state.results.length} founds',
                                style: AppTextStyles.urbanist.medium(
                                  color: AppColors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: state.results.length,
                            itemBuilder: (context, index) {
                              return ProductCard(product: state.results[index]);
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is SearchError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent',
                style: AppTextStyles.urbanist.semiBold(
                  color: AppColors.black,
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _recentSearches.clear()),
                child: Text(
                  'Clear All',
                  style: AppTextStyles.urbanist.medium(
                    color: AppColors.brown,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: _recentSearches.length,
            separatorBuilder: (_, __) =>
                Divider(height: 0, color: AppColors.greyScale.grey300),
            itemBuilder: (context, index) {
              final item = _recentSearches[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  item,
                  style: AppTextStyles.urbanist.regular(
                    color: AppColors.black,
                    fontSize: 16,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.close_rounded, size: 18, color: AppColors.brown),
                  onPressed: () {
                    setState(() {
                      _recentSearches.removeAt(index);
                    });
                  },
                ),
                onTap: () {
                  _searchController.text = item;
                  setState(() => _lastQuery = item);
                  context.read<SearchBloc>().add(SearchQueryChanged(item));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
