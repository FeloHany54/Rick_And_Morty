// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/business_logic_layer/cubit/characters_cubit.dart';
import 'package:learning_bloc/constants/strings.dart';
import 'package:learning_bloc/data_layer/models/characters.dart';
import 'package:learning_bloc/data_layer/repository/characters_repository.dart';
import 'package:learning_bloc/data_layer/web_services/character_web_services.dart';
import 'package:learning_bloc/presentation_layer/screens/character_details_screen.dart';
import 'package:learning_bloc/presentation_layer/screens/character_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(
      charactersWebServices: CharactersWebServices(),
    );
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: CharacterScreen(),
          ),
        );
      case characterScreenDetails:
        final character = settings.arguments as Results;
        return MaterialPageRoute(
          builder: (_) => CharacterDetailsScreen(character: character),
        );
      default:
        return MaterialPageRoute(builder: (_) => CharacterScreen());
    }
  }
}
