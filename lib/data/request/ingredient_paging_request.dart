class PagingRequest {
  final int pageIndex;
  final int pageSize;

  PagingRequest({this.pageIndex = 1, this.pageSize = 10});

  Map<String, dynamic> toJson() => {
        "pageIndex": pageIndex.toString(),
        "pageSize": pageSize.toString(),
      };
}

class IngredientPagingRequest extends PagingRequest {
  final int? categoryId;

  IngredientPagingRequest({super.pageIndex, super.pageSize, this.categoryId});

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = super.toJson();
    if (categoryId != null) {
      result["categoryId"] = categoryId.toString();
    }
    return result;
  }
}
