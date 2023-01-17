import 'package:dio/dio.dart';
import 'package:masterclass_bloc/app/models/anime_dto.dart';

class AnimeRepository {

  final Dio _dio = Dio();

  Future<List<AnimeDto>> getAnimes(int page, int limit) async{
    
   final response = await _dio.get("https://www.intoxianime.com/?rest_route=/wp/v2/posts&page=${page}&per_page=${limit}");
   List result = response.data as List;
   List<AnimeDto> animes = result.isNotEmpty? result.map((e) => AnimeDto.fromJson(e)).toList():[];
   print(animes.toList());
    return animes;
  }

}
