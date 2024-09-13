class Filter {
  String title;
  List<String> items;
  String selectedItem;
  Filter({
    required this.title,
    required this.items,
    required this.selectedItem,
  });

  Filter copyWith({
    String? title,
    List<String>? items,
    String? selectedItem,
  }) {
    return Filter(
      title: title ?? this.title,
      items: items ?? this.items,
      selectedItem: selectedItem ?? this.selectedItem,
    );
  }

  @override
  String toString() =>
      'Filter(title: $title, items: $items, selectedItem: $selectedItem)';
}
