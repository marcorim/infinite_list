import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterclass_bloc/app/bloc/anime_bloc.dart';
import 'package:masterclass_bloc/app/bloc/anime_state.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../bloc/anime_event.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AnimeBloc bloc = AnimeBloc();
  final _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masterclass 5'),
      ),
      body: BlocBuilder<AnimeBloc, AnimeState>(
        bloc: bloc,
 
        builder: (context, state) {
          if(state is AnimeInitialState) return Center(child: ElevatedButton(onPressed: () => bloc.add(GetAnimeEvent()), child: const Text("Get")),);
          if(state is AnimeErrorState) return Container();
          //if(state is AnimeSuccessState){
            if(state is AnimeLoaded){
           final animes = state.animes;
            return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: animes.length + 1,
            itemBuilder: (context, index) {
              if  (index >= state.animes.length) {
                bloc.add(GetAnimeEvent());
                return const Center(child: CircularProgressIndicator());
              }else {
                  final anime = animes.elementAt(index);
                  final title = '$index - ${anime.title}';
                  final description = anime.description;
                  final link = anime.link;
                  final textdate = anime.date;
                  final date = DateTime.parse(textdate);

               return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: theme.primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Text(
                              '${date.day}/${date.month}/${date.year}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () => launchUrlString(link),
                            child: const Text(
                              'Acessar matéria',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        );
          
          }
          
         if(state is AnimeFirstLoadingState) return const Center(child: CircularProgressIndicator());
         if (state is AnimeLoadingState) return const Center(child: CircularProgressIndicator());
         return Container();
        },
       
      ),
    );
  }
}
