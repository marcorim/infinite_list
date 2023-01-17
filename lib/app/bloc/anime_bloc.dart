import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterclass_bloc/app/bloc/anime_event.dart';
import 'package:masterclass_bloc/app/bloc/anime_state.dart';
import 'package:masterclass_bloc/app/models/anime_dto.dart';
import 'package:masterclass_bloc/app/repository/anime_repository.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState>{
  AnimeRepository repository = AnimeRepository();
  List<AnimeDto> animes = [];
  AnimeLoaded animeLoaded = AnimeLoaded(animes: []);

  AnimeBloc():super( AnimeInitialState()){
    on<GetAnimeEvent>((event, emit) async{
      try {
          if (state is AnimeInitialState) {
            emit(AnimeFirstLoadingState());
            animes = await repository.getAnimes(1, 10);
            return emit(animeLoaded.copyWith(animes: animes));
          }
           
          if (state is AnimeLoaded) {
            animeLoaded = state as AnimeLoaded;
            animes = await repository.getAnimes(animeLoaded.animes.length, 10);
            return emit(animeLoaded.copyWith(animes: List.of(animeLoaded.animes)..addAll(animes)));
          }
      } catch(error){
        emit(AnimeErrorState(mensagem:"Erro na requisição da API" ));
      }
    });
  }
}

// class AnimeBloc extends Bloc<AnimeEvent, AnimeState>{
//   AnimeRepository repository = AnimeRepository();
//   // ignore: unused_field
//   int _page = 1;
//   // ignore: unused_field
//   int _limitPage = 10;

//   AnimeBloc():super( AnimeInitialState()){
//     on<GetAnimeEvent>((event, emit) async{
//       try {
//             _page == 1 ? emit(AnimeFirstLoadingState()) : AnimeLoadingState();
//             List<AnimeDto> animes = await repository.getAnimes(_page,_limitPage);
//             emit(AnimeSuccessState(animes: animes));
//             _page += 10;
//       } catch(error, stacktrace){
//         emit(AnimeErrorState(mensagem:"Erro na requisição da API" ));
//         // ignore: avoid_print
//         print(stacktrace);
//       }



//     });
//   }
// }