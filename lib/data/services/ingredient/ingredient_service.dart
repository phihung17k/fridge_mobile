import 'package:fridge_mobile/data/repositories/ingredient/i_ingredient_repository.dart';
import 'package:fridge_mobile/data/request/ingredient_paging_request.dart';
import 'package:fridge_mobile/data/response/ingredient_response.dart';
import 'package:fridge_mobile/data/services/ingredient/i_ingredient_service.dart';
import 'package:fridge_mobile/data/models/ingredient_model.dart';

import '../../models/selected_ingredient_model.dart';
import '../../paging_result.dart';

class IngredientService implements IIngredientService {
  final IIngredientRepository repository;

  IngredientService(this.repository);

  // @override
  // Future<PagingResult<IngredientModel>?> getIngredients(int? pageIndex) async {
  //   PagingResult<IngredientResponse>? response = await repository.getIngredients(pageIndex ?? 1);
  //   if (response == null) {
  //     return null;
  //   }

  //   return PagingResult<IngredientModel>(
  //     totalItemsCount: response.totalItemsCount,
  //     pageCount: response.pageCount,
  //     pageSize: response.pageSize,
  //     pageIndex: response.pageIndex,
  //     hasNext: response.hasNext,
  //     hasPrevious: response.hasPrevious,
  //     items: response.items
  //         .map((item) => IngredientModel(
  //               id: item.id,
  //               name: item.name,
  //               localName: item.localName,
  //               description: item.description,
  //               imageUrl: item.imageUrl,
  //             ))
  //         .toList(),
  //   );
  // }

  @override
  Future<PagingResult<SelectableIngredientModel>?> getSelectableIngredients(
      IngredientPagingRequest request) async {
    PagingResult<IngredientResponse>? response = await repository.getIngredients(request);
    if (response == null) {
      return null;
    }

    return PagingResult<SelectableIngredientModel>(
      totalItemsCount: response.totalItemsCount,
      pageCount: response.pageCount,
      pageSize: response.pageSize,
      pageIndex: response.pageIndex,
      hasNext: response.hasNext,
      hasPrevious: response.hasPrevious,
      items: response.items
          .map((item) => SelectableIngredientModel(
                id: item.id,
                name: item.name,
                localName: item.localName,
                description: item.description,
                imageUrl: item.imageUrl,
              ))
          .toList(),
    );
  }

  // @override
  // Future<PagingResult<SelectableIngredientModel>?> getSelectableIngredientsByCategoryId(
  //     {int categoryId = 0, int? pageIndex}) async {
  //   PagingResult<IngredientResponse>? response =
  //       await repository.getIngredientsByCategoryId(categoryId, pageIndex ?? 1);
  //   if (response == null) {
  //     return null;
  //   }

  //   return PagingResult<SelectableIngredientModel>(
  //     totalItemsCount: response.totalItemsCount,
  //     pageCount: response.pageCount,
  //     pageSize: response.pageSize,
  //     pageIndex: response.pageIndex,
  //     hasNext: response.hasNext,
  //     hasPrevious: response.hasPrevious,
  //     items: response.items
  //         .map((item) => SelectableIngredientModel(
  //               id: item.id,
  //               name: item.name,
  //               localName: item.localName,
  //               description: item.description,
  //               imageUrl: item.imageUrl,
  //             ))
  //         .toList(),
  //   );
  // }

  // @override
  // Future<Ingredient> getIngredientById(String id) async {
  //   // Implement your logic to fetch a single ingredient by id here
  //   return Ingredient(id: id, name: 'Sample Ingredient');
  // }

  // @override
  // Future<void> addIngredient(Ingredient ingredient) async {
  //   // Implement your logic to add a new ingredient here
  // }

  // @override
  // Future<void> updateIngredient(Ingredient ingredient) async {
  //   // Implement your logic to update an existing ingredient here
  // }

  // @override
  // Future<void> deleteIngredient(String id) async {
  //   // Implement your logic to delete an ingredient here
  // }
}
