abstract class SingleProductEvent {}

class FetchSingleProduct extends SingleProductEvent {
  final int id;

  FetchSingleProduct(this.id);
}
