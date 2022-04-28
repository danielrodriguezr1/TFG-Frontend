class Country {
  final String code;
  final String name;

  Country({
    this.code,
    this.name,
  });

  @override
  String toString() {
    return '{id: $code, title: $name}';
  }
}
