import 'package:equatable/equatable.dart';

class Pair<T, S> extends Equatable {
  const Pair(this.left, this.right);

  final T left;
  final S right;

  @override
  List<Object> get props => [left ?? '', right ?? ''];

  @override
  String toString() {
    return 'left ${this.left.toString()}, right ${this.right.toString()}';
  }
}
