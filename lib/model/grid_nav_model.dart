//首页网络卡片模型

import 'package:flutter_trip/model/common_model.dart';

class GirdNavModel {
  final GirdNavItem hotel;
  final GirdNavItem flight;
  final GirdNavItem travel;

  GirdNavModel({this.hotel, this.flight, this.travel});

  factory GirdNavModel.fromJson(Map<String, dynamic> json) {
    return json != null
        ? GirdNavModel(
            hotel: GirdNavItem.fromJson(json['hotel']),
            flight: GirdNavItem.fromJson(json['flight']),
            travel: GirdNavItem.fromJson(json['travel']),
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

  factory GirdNavItem.fromJson(Map<String, dynamic> json) {
    return GirdNavItem(
      startColor: json['startColor'],
      endColor: json['endColor'],
      // mainItem: json['mainItem'],
      mainItem: CommonModel.fromJson(json['mainItem']),
      item1: CommonModel.fromJson(json['item1']),
      item2: CommonModel.fromJson(json['item2']),
      item3: CommonModel.fromJson(json['item3']),
      item4: CommonModel.fromJson(json['item4']),
    );
  }
}
