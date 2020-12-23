import 'package:dio/dio.dart';
import 'package:directus/src/data_classes/query.dart';
import 'package:directus/src/data_classes/response.dart';
import 'package:directus/src/handlers/items_handler.dart';

class ActivityHandler {
  Dio client;
  ItemsHandler handler;

  ActivityHandler({required this.client})
      : handler = ItemsHandler('directus_activity', client: client);

  Future<DirectusResponse<Map>> readOne(String key) async {
    return handler.readOne(key);
  }

  Future<DirectusResponse<List<Map>>> readMany({Query? query}) async {
    return handler.readMany(query: query);
  }

  /// Create comment
  Future<DirectusResponse<Map>> createComment({
    required String collection,
    required String item,
    required String comment,
  }) async {
    final response = await client.post(
      '/activity/comments',
      data: {'collection': collection, 'item': item, 'comment': comment},
    );
    return DirectusResponse(response);
  }

  /// Update existing comment
  Future<DirectusResponse<Map>> updateComment(String key, Map data) async {
    final response = await client.patch('/activity/comments/$key', data: data);
    return DirectusResponse(response);
  }

  /// Delete comment
  Future<void> deleteComment(String key) async {
    await client.delete('/activity/comments/$key');
  }
}
