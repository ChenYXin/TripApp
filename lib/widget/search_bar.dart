import 'package:flutter/material.dart';

enum   SearchBarType{theme,normal,homeLight}
class SearchBar extends StatefulWidget {
  final bool enabled;
  final bool hideLeft;
  final SearchBarType searchBarType;
  final String hint;
  final String defaultText;
  // final void Funtion() leftButtonClick;
  // final void Funtion() rightButtonClick;
  // final void Funtion() speakClick;
  // final void Funtion() inputBoxClick;
  final ValueChanged<String> onChanged;


 const SearchBar({Key key,this.enabled, this.hideLeft, this.searchBarType, this.hint,
      this.defaultText,
   // this.leftButtonClick,this.rightButtonClick,
   // this.speakClick,
   // this.inputBoxClick,
   this.onChanged}):super(key:key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
leftButtonClick(){}

