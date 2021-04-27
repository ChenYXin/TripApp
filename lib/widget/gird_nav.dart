import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widget/webview.dart';

//网格卡片
class GirdNav extends StatelessWidget {
  final GirdNavModel girdNavModel;

  //@required 必填参数
  GirdNav({Key key, @required this.girdNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _girdNavItems(context),
      ),);
  }

  _girdNavItems(BuildContext context) {
    List<Widget> items = [];
    if (girdNavModel == null) return items;
    if (girdNavModel.hotel != null) {
      items.add(_girdNavItem(context, girdNavModel.hotel, true));
    }
    if (girdNavModel.flight != null) {
      items.add(_girdNavItem(context, girdNavModel.flight, false));
    }
    if (girdNavModel.travel != null) {
      items.add(_girdNavItem(context, girdNavModel.travel, false));
    }

    return items;
  }

  _girdNavItem(BuildContext context, GirdNavItem girdNavItem, bool isFirst) {
    List<Widget> items = [];
    items.add(_mainItem(context, girdNavItem.mainItem));
    items.add(_doubleItem(context, girdNavItem.item1, girdNavItem.item2));
    items.add(_doubleItem(context, girdNavItem.item3, girdNavItem.item4));
    List<Widget> expandItems = [];
    items.forEach((item) {
      expandItems.add(Expanded(
        child: item,
        flex: 1,
      ));
    });
    Color startColor = Color(int.parse('0xff' + girdNavItem.startColor));
    Color endColor = Color(int.parse('0xff' + girdNavItem.endColor));
    return Container(
      height: 88,
      margin: isFirst ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        //现行渐变
        gradient: LinearGradient(colors: [startColor, endColor]),
      ),
      child: Row(
        children: expandItems,
      ),
    );
  }

  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Image.network(
              model.icon,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
                margin: EdgeInsets.only(top: 11),
                child: Text(
                  model.title,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ), ,
            ),
          ],
        ),
        model);
  }

  _doubleItem(BuildContext context, CommonModel topItem,
      CommonModel bottomItem) {
    return Column(
      children: [
        Expanded(
          child: _item(context, topItem, true),
        ),
        Expanded(
          child: _item(context, bottomItem, false),
        ),
      ],
    );
  }

  _item(BuildContext context, CommonModel item, bool isFirst) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            bottom: isFirst ? borderSide : BorderSide.none,
          ),
        ),
        child: _wrapGesture(
            context,
            Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            item),
      ),
    );
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                WebView(
                  url: model.url,
                  statusBarColor: model.statusBarColor,
                  title: model.title,
                  hideAppBar: model.hideAppBar,
                ),
          ),
        );
      },
      child: widget,
    );
  }
}
