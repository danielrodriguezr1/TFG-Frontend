class Genre {
  final String code;
  final String name;

  Genre({
    this.code,
    this.name,
  });

  @override
  String toString() {
    return '{id: $code, title: $name}';
  }
}
