import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterclass_bloc/app/bloc/anime_event.dart';
import 'package:masterclass_bloc/app/bloc/anime_state.dart';
import 'package:masterclass_bloc/app/models/anime_dto.dart';
import 'package:masterclass_bloc/app/repository/anime_repository.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState>{
  AnimeRepository repository = AnimeRepository();

  AnimeBloc():super( AnimeInitialState()){
    on<GetAnimeEvent>((event, emit) async{
      try {
            emit(AnimeLoadingState());
            List<AnimeDto> animes = await repository.getAnimes();
            emit(AnimeSuccessState(animes: animes));
      } catch(error, stacktrace){
        emit(AnimeErrorState(mensagem:"Erro na requisição da API" ));
        // ignore: avoid_print
        print(stacktrace);
      }



    });
  }
}