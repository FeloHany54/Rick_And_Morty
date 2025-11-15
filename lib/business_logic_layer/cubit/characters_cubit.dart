import 'package:bloc/bloc.dart';
import '../../data_layer/models/characters.dart';
import '../../data_layer/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Results> characters = [];
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Results> getCharacters() {
    charactersRepository.getCharacters().then((characters) {
      emit(CharactersLoaded(characters: characters));
      this.characters = characters;
    });
    return characters;
  }
}
