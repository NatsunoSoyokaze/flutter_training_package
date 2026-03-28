import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../model/post.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/posts")
  Future<List<Post>> getPosts();

  @GET("/posts/{id}")
  Future<Post> getPost(@Path("id") int id);

  @POST("/posts")
  Future<Post> createPost(@Body() Map<String, Post> body);

  @PUT("/posts/{id}")
  Future<Post> updatePost(
      @Path("id") int id,
      @Body() Map<String, Post> body,
      );

  @DELETE("/posts/{id}")
  Future<void> deletePost(@Path("id") int id);
}