import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../business_logic_layer/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data_layer/models/characters.dart';

import '../widgets/character_item.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late List<Results> allCharacters;
  late List<Results> searchedCharactersList;
  bool _isSearching = false;
  final searchController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      cursorColor: MyColors.grey,
      decoration: InputDecoration(
        hintText: "Find a Character",
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.grey, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.grey, fontSize: 18),
      onChanged: (searchedCharacters) {
        addSearchedCharactersForSearchedList(searchedCharacters);
      },
    );
  }

  void addSearchedCharactersForSearchedList(String searchedCharacters) {
    searchedCharactersList = allCharacters
        .where(
          (character) =>
              character.name!.toLowerCase().startsWith(searchedCharacters),
        )
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching == true) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
          },
          icon: Icon(Icons.clear, color: MyColors.grey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(Icons.search, color: MyColors.grey),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(
      // كأنه بيوديني على صفحة تانية
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    _clearSearch;
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidget();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return Center(child: CircularProgressIndicator(color: MyColors.yellow));
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Column(children: [buildCharacterList()]),
    );
  }

  Widget buildCharacterList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: searchController.text.isEmpty
              ? allCharacters[index]
              : searchedCharactersList[index],
        );
      },
      itemCount: searchController.text.isEmpty
          ? allCharacters.length
          : searchedCharactersList.length,
    );
  }

  Widget _appBarTitle() {
    return Text("Characters", style: TextStyle(color: MyColors.grey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      appBar: AppBar(
        backgroundColor: MyColors.yellow,
        title: _isSearching == true ? _buildSearchField() : _appBarTitle(),
        actions: _buildAppBarActions(),
        leading: _isSearching == true
            ? BackButton(color: MyColors.grey)
            : Text(""),
      ),
      body: OfflineBuilder(
        connectivityBuilder:
            (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected = !connectivity.contains(
                ConnectivityResult.none,
              );
              if (connected) {
                return buildBlocWidget();
              } else {
                return Container(
                  color: MyColors.grey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/no-internet.png",
                          fit: BoxFit.fill,
                          height: 300,
                          width: 300,
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
        child: Center(child: showLoadingIndicator()),
      ),
    );
  }
}
