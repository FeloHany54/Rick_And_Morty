// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:learning_bloc/data_layer/models/characters.dart';
import 'package:learning_bloc/data_layer/web_services/character_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;
  CharactersRepository({required this.charactersWebServices});

  Future<List<Results>> getCharacters() async {
    final characters = await charactersWebServices.getCharacters();
    return characters.map((character) => Results.fromJson(character)).toList();
  }
}
