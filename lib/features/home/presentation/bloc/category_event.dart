abstract class CategoryProductEvent {}

class FetchCategoryProducts extends CategoryProductEvent {
  final String slug;
  FetchCategoryProducts(this.slug);
}
