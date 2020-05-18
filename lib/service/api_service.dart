import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:take_home_assignment/models/models.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/photos")
  Future<List<Photo>> getTasks(@Query('albumId') int albumId);
}
