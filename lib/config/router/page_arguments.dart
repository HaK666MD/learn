class PageArguments {
  PageArguments(this.id);
  final int id;

  factory PageArguments.fromMap(Map<String, dynamic> map) {
    return PageArguments(map['id']);
  }
}
