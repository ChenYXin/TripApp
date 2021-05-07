import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer(
      {Key key,
      @required this.child,
      @required this.isLoading,
      this.cover = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !cover
        ? !isLoading
            ? child
            : _loadView
        : Stack(
            children: [
              child,
              isLoading ? _loadView : null,
            ],
          );
  }

  Widget get _loadView {
    return Container(
      child: CircularProgressIndicator(),
    );
  }
}
