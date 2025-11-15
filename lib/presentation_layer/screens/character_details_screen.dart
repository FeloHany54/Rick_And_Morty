import 'package:flutter/material.dart';
import '../../constants/my_colors.dart';
import '../../data_layer/models/characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Results character;
  const CharacterDetailsScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            expandedHeight: 600,
            stretch: true,
            backgroundColor: MyColors.grey,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                character.name!,
                style: TextStyle(
                  color: MyColors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Hero(
                tag: character.id!,
                child: Image.network(character.image!, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo("Species : ", character.species!),
                    buildDivider(250),
                    characterInfo("Gender : ", character.gender!),
                    buildDivider(250),
                    characterInfo("Status : ", character.status!),
                    buildDivider(250),
                  ],
                ),
              ),
              SizedBox(height: 100),
            ]),
          ),
        ],
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(color: MyColors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.yellow,
      endIndent: endIndent,
      thickness: 2,
      height: 30,
    );
  }
}
