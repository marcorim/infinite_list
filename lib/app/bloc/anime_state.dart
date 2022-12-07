import '../models/anime_dto.dart';

abstract class AnimeState{}

class AnimeInitialState extends AnimeState{}
class AnimeLoadingState extends AnimeState{}
class AnimeSuccessState extends AnimeState{
  final List<AnimeDto> animes;

  AnimeSuccessState({required this.animes});

}
class AnimeErrorState extends AnimeState{
 final String mensagem;
  AnimeErrorState({required this.mensagem});

}
