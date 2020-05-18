import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final int index;
  final bool selected;

  const ChoiceButton({
    Key key,
    this.index,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: selected
          ? BoxDecoration(
              border: Border.all(color: Colors.lightBlueAccent),
              color: Colors.lightBlueAccent.withOpacity(.2),
            )
          : null,
      child: Container(
        height: 20,
        width: 20,
        color: Colors.black,
        child: Text(
          '$index',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
