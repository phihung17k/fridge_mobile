import 'dart:developer';

import 'package:fridge_mobile/data/clients/api_path.dart';
import 'package:fridge_mobile/data/clients/app_client.dart';
import 'package:fridge_mobile/data/paging_result.dart';
import 'package:fridge_mobile/data/request/ingredient_paging_request.dart';
import 'package:fridge_mobile/data/response/ingredient_response.dart';
import 'package:http/http.dart';
import 'i_ingredient_repository.dart';

class IngredientRepository implements IIngredientRepository {
  final AppClient _client;

  IngredientRepository(this._client);

  @override
  Future<PagingResult<IngredientResponse>?> getIngredients(IngredientPagingRequest request) async {
    try {
      Map<String, dynamic> queryParameters = request.toJson();
      log("REQUEST: ${request.toJson().toString()}");

      Uri uri = ApiPath.getUri(path: ApiPath.ingredients, queryParameters: queryParameters);
      final Response response = await _client.getAsync(uri);
      if (response.statusCode != 200) {
        return null;
      }

      Map<String, dynamic>? body = _client.parseToMap(response);
      if (body == null) {
        return null;
      }

      return PagingResult.fromJson(body, (json) => IngredientResponse.fromJson(json));
    } catch (e) {
      log(e.toString());
      return Future.error(e);
    }
  }

  // @override
  // Future<PagingResult<IngredientResponse>?> getIngredientsByCategoryId(
  //     int categoryId, int pageIndex) async {
  //   try {
  //     Map<String, dynamic> queryParameters = {
  //       "categoryId": "$categoryId",
  //       "pageIndex": "$pageIndex",
  //       "pageSize": "10",
  //     };
  //     Uri uri = ApiPath.getUri(path: ApiPath.ingredients, queryParameters: queryParameters);
  //     final Response response = await _client.getAsync(uri);
  //     if (response.statusCode != 200) {
  //       return null;
  //     }

  //     Map<String, dynamic>? body = _client.parseToMap(response);
  //     if (body == null) {
  //       return null;
  //     }

  //     return PagingResult.fromJson(body, IngredientResponse.fromJson);
  //   } catch (e) {
  //     log(e.toString());
  //     return Future.error(e);
  //   }
  // }
}
