
import 'package:flutter/cupertino.dart';

class PlayingCardWidget extends StatelessWidget {
  const PlayingCardWidget({
    Key key,
    @required this.pickedCard,
  }) : super(key: key);

  final String pickedCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(
            'assets/images/' + pickedCard.toUpperCase() + '.jpg',
            height: 175,
          ),
          Text(pickedCard.toUpperCase()),
        ],
      ),
    );
  }
}