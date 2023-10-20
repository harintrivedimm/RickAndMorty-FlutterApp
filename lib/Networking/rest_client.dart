import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rick_and_morty/Networking/data.dart';
part 'rest_client.g.dart';

class Apis {
  static const String users = '/users';
}

@RestApi(baseUrl: 'https://rickandmortyapi.com/api')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/character')
  Future<Result> getCharacters();
}
