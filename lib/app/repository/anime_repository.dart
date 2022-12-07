import 'package:dio/dio.dart';
import 'package:masterclass_bloc/app/models/anime_dto.dart';

class AnimeRepository {

  final Dio _dio = Dio();

  Future<List<AnimeDto>> getAnimes() async{
    
   final response = await _dio.get("https://www.intoxianime.com/?rest_route=/wp/v2/posts&page=1&per_page=10");
   List result = response.data as List;
   List<AnimeDto> animes = result.isNotEmpty? result.map((e) => AnimeDto.fromJson(e)).toList():[];
    return animes;
  }

}
