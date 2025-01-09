import 'dart:developer';

import 'package:fridge_mobile/data/clients/api_path.dart';
import 'package:fridge_mobile/data/clients/app_client.dart';
import 'package:fridge_mobile/data/paging_result.dart';
import 'package:fridge_mobile/data/response/ingredient_response.dart';
import 'package:http/http.dart';
import 'i_ingredient_repository.dart';

class IngredientRepository implements IIngredientRepository {
  final AppClient _client;

  IngredientRepository(this._client);

  @override
  Future<PagingResult<IngredientResponse>?> getIngredients() async {
    try {
      final Response response = await _client.getAsync(ApiPath.ingredients);
      if (response.statusCode != 200) {
        return null;
      }

      Map<String, dynamic>? body = _client.parseToMap(response);
      if (body == null) {
        return null;
      }

      return PagingResult.fromJson(body, IngredientResponse.fromJson);
    } catch (e) {
      log(e.toString());
      return Future.error(e);
    }
  }
}
