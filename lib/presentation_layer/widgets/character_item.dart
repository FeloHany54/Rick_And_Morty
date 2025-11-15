import 'package:flutter/material.dart';
import '../../constants/my_colors.dart';
import '../../constants/strings.dart';
import '../../data_layer/models/characters.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});
  final Results character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          characterScreenDetails,
          arguments: character,
        ),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              "${character.name}",
              style: TextStyle(
                height: 1.3,
                fontSize: 16,
                color: MyColors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: Hero(
            tag: character.id!,
            child: Container(
              color: MyColors.grey,
              child: character.image!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      placeholder: "assets/images/blocLoading.gif",
                      image: "${character.image}",
                    )
                  : Image.asset("assets/images/Actor.jpg"),
            ),
          ),
        ),
      ),
    );
  }
}
