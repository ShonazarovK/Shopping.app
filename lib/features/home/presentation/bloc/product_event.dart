import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {
  final int limit;

  const LoadProducts({required this.limit});

  @override
  List<Object> get props => [limit];
}