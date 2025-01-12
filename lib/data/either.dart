sealed class Either<L, R> {
  const Either();
  factory Either.left(L value) => Left(value);
  factory Either.right(R value) => Right(value);

  bool get isRight => this is Right<L, R>;

  // Método when para programación funcional
  T when<T>({
    required T Function(L left) left,
    required T Function(R right) right,
  }) {
    return switch (this) {
      Left(value: final v) => left(v),
      Right(value: final v) => right(v),
    };
  }
}

class Left<L, R> extends Either<L, R> {
  const Left(this.value);
  final L value;
}

class Right<L, R> extends Either<L, R> {
  const Right(this.value);
  final R value;
}
