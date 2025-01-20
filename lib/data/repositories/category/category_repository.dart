import 'dart:developer';

import 'package:fridge_mobile/data/clients/api_path.dart';
import 'package:fridge_mobile/data/repositories/category/i_category_repository.dart';
import 'package:fridge_mobile/data/response/category_response.dart';
import 'package:http/http.dart';

import '../../clients/app_client.dart';

class CategoryRepository implements ICategoryRepository {
  final AppClient _client;

  CategoryRepository(this._client);

  @override
  Future<List<CategoryResponse>?> getAllCategory() async {
    try {
      final Uri uri = ApiPath.getUri(path: ApiPath.categories);
      final Response response = await _client.getAsync(uri);
      if (response.statusCode != 200) {
        return null;
      }

      List<dynamic>? body = _client.parseToList(response);
      if (body == null) {
        return null;
      }

      return body.map<CategoryResponse>((e) => CategoryResponse.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      return Future.error(e);
    }
  }
}
