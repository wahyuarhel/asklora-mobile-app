import '../bloc/order_bloc.dart';

class SymbolDetail {
  final String name;
  final String assetImage;
  final double marketPrice;
  final SymbolType symbolType;

  SymbolDetail(this.name, this.marketPrice, this.assetImage, this.symbolType);
}
