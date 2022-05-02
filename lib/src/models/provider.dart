class Provider {
  final String code;
  final String name;

  Provider({
    this.code,
    this.name,
  });

  @override
  String toString() {
    return '{id: $code, title: $name}';
  }
}
