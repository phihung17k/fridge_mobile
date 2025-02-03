typedef JsonModelFactory<T> = T Function(Map<String, dynamic> json);

class PagingResult<T> {
  final int totalItemsCount;
  final int pageCount;
  final int pageSize;
  final int pageIndex;
  final bool hasNext;
  final bool hasPrevious;
  final List<T> items;

  PagingResult({
    required this.totalItemsCount,
    required this.pageCount,
    required this.pageSize,
    required this.pageIndex,
    required this.hasNext,
    required this.hasPrevious,
    required this.items,
  });

  factory PagingResult.fromJson(Map<String, dynamic>? json, JsonModelFactory fromJsonModel) {
    if (json == null || json.isEmpty) throw Exception("Json paging model cannot null");
    // final itemsMap = json['items'].cast<Map<String, dynamic>>();
    final rawItems = json['items'] as List<dynamic>;
    List<T> items =
        List<T>.from(rawItems.map((item) => fromJsonModel(item as Map<String, dynamic>)));
    return PagingResult(
        totalItemsCount: json['totalItemsCount'],
        pageCount: json['pageCount'],
        pageSize: json['pageSize'],
        pageIndex: json['pageIndex'],
        hasNext: json['hasNext'],
        hasPrevious: json['hasPrevious'],
        items: items);
  }
}
