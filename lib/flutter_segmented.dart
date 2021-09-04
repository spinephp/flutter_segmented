library flutter_segmented;

/// A Calculator.
import 'package:flutter/material.dart';

class SegmentBar extends StatefulWidget {
  //按钮名字集合
  final List<String> titleNames;
  //默认颜色
  final Color defaultColor;
  //选中时的颜色
  final Color selectedColor;
  //字体大小
  final double textSize;
  //初始时选中的item ，默认第一个
  final int selectItem;
  //点击回调
  final Function(int) onSelectChanged;
  //按钮高度
  final double itemHeight;
  //按钮宽度
  final double itemWidth;
  //按钮边框宽度
  final double borderWidth;
  //按钮圆角角度大小
  final double radius;

  SegmentBar(
      {@required this.titleNames,
      @required this.onSelectChanged,
      this.defaultColor = Colors.white,
      this.selectedColor = Colors.blue,
      this.textSize = 13,
      this.itemHeight = 30,
      this.itemWidth = 110,
      this.borderWidth = 1,
      this.radius = 5,
      this.selectItem = 0});

  @override
  _SegmentBarState createState() => _SegmentBarState();
}

class _SegmentBarState extends State<SegmentBar> {
  int selectItem = 0;
  @override
  void initState() {
    super.initState();
    selectItem = widget.selectItem;
  }

  _buildSegmentItems(List list) {
    if (list.isEmpty) {
      return Container();
    }
    List<Widget> items = [];
    for (var i = 0; i < list.length; i++) {
      Widget item = Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: _bulidSegemtItem(list[i], i),
      );
      items.add(item);
    }

    return items;
  }

  ///创建item position 是item的位置，根据位置 设置不同 的属性
  _bulidSegemtItem(String name, int position) {
    final _width = widget.itemWidth;

    //有边框时按钮高度减去边框宽度 保持按钮高度选中不选中一样
    final _height = selectItem == position
        ? widget.itemHeight
        : widget.itemHeight - widget.borderWidth;

    // 背景颜色
    final Color _backColor =
        selectItem == position ? widget.selectedColor : widget.defaultColor;

    // 文字颜色
    final Color _clText =
        selectItem == position ? widget.defaultColor : widget.selectedColor;

    // 按钮圆角样式，最左边的左边有上下圆角，最右边的有右边上下圆角，当中的无圆角
    final _roundBorder = position == 0
        ? RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.radius),
                bottomLeft: Radius.circular(widget.radius)))
        : position == widget.titleNames.length - 1
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(widget.radius),
                    bottomRight: Radius.circular(widget.radius)))
            : RoundedRectangleBorder();

    // 按钮文字
    final _text = Text(name,
        style: TextStyle(
          fontSize: widget.textSize,
          color: _clText,
        ));

    return Container(
        height: _height,
        width: _width,
        // 选中的创建 TextButton, 否则创建 outlinedButton
        child: selectItem == position
            ? TextButton(
                onPressed: () {
                  _updateItem(position);
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      _roundBorder,
                    ),
                    backgroundColor: MaterialStateProperty.all(_backColor)),
                child: _text)
            : OutlinedButton(
                onPressed: () {
                  _updateItem(position);
                },
                child: _text,
                style: OutlinedButton.styleFrom(
                  primary: _backColor,
                  shape: _roundBorder,
                  side: BorderSide(
                      color: widget.selectedColor, width: widget.borderWidth),
                ),
              ));
  }

  //点击修改视图样式，回调点击的方法
  _updateItem(int selectedPosition) {
    if (selectedPosition == selectItem) {
      return;
    } else {
      selectItem = selectedPosition;
      widget.onSelectChanged(selectedPosition);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildSegmentItems(widget.titleNames),
    );
  }
}
