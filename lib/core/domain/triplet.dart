class Triplet<T, S, U> {
  Triplet(this.left, this.middle, this.right);

  final T left;
  final S middle;
  final U right;

  @override
  String toString() {
    return '{left: $left, middle: $middle, right: $right}';
  }
}
