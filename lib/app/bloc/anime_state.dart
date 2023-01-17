import '../models/anime_dto.dart';

abstract class AnimeState{}

class AnimeInitialState extends AnimeState{}
class AnimeLoadingState extends AnimeState{}
class AnimeFirstLoadingState extends AnimeState{}

class AnimeLoaded extends AnimeState{
  final List<AnimeDto> animes;
  final bool hasReachedMax;

  AnimeLoaded({
    this.animes = const <AnimeDto>[],
    this.hasReachedMax = false,
  });

  AnimeLoaded copyWith({
    List<AnimeDto>? animes,
    bool? hasReachedMax
  }) {
    return AnimeLoaded(
      animes: animes ?? this.animes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class AnimeSuccessState extends AnimeState{
  final List<AnimeDto> animes;

  AnimeSuccessState({required this.animes});

}
class AnimeErrorState extends AnimeState{
 final String mensagem;
  AnimeErrorState({required this.mensagem});

}
