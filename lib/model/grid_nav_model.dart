//首页网络卡片模型

import 'package:flutter_trip/model/common_model.dart';

class GirdNavModel {
  final GirdNavItem hotel;
  final GirdNavItem flight;
  final GirdNavItem travel;

  GirdNavModel({this.hotel, this.flight, this.travel});

  factory GirdNavModel.formJson(Map<String, dynamic> json) {
    return json != null
        ? GirdNavModel(
            hotel: GirdNavItem.formJson(json['hotel']),
            flight: GirdNavItem.formJson(json['flight']),
            travel: GirdNavItem.formJson(json['travel']),
          )
        : null;
  }
}

class GirdNavItem {
  final String startColor;
  final String endColor;
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

  GirdNavItem(
      {this.startColor,
      this.endColor,
      this.mainItem,
      this.item1,
      this.item2,
      this.item3,
      this.item4});

  factory GirdNavItem.formJson(Map<String, dynamic> json) {
    return GirdNavItem(
      startColor: json['startColor'],
      endColor: json['endColor'],
      mainItem: json['mainItem'],
      item1: CommonModel.formJson(json['item1']),
      item2: CommonModel.formJson(json['item2']),
      item3: CommonModel.formJson(json['item3']),
      item4: CommonModel.formJson(json['item4']),
    );
  }
}
