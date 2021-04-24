import 'package:flutter/material.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';

class GirdNav extends StatelessWidget {
  final GirdNavModel girdNavModel;
  final String name;

  //@required 必填参数
  GirdNav({Key key, @required this.girdNavModel, this.name = 'Donkor'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}
