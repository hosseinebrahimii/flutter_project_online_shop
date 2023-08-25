import 'package:flutter/material.dart';
import 'package:flutter_project_online_shop/constants/colors.dart';

class CategoryHorizontalList extends StatelessWidget {
  const CategoryHorizontalList({Key? key, required this.itemCount, required this.itemBuilder}) : super(key: key);
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _listTitle(),
        _list(
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        ),
      ],
    );
  }
}

Padding _listTitle() {
  return const Padding(
    padding: EdgeInsets.only(
      right: 40,
    ),
    child: Text(
      'دسته بندی',
      style: TextStyle(
        fontFamily: 'SB',
        fontSize: 12,
        color: CustomColors.grey,
      ),
    ),
  );
}

SizedBox _list({
  required int itemCount,
  required Widget Function(BuildContext context, int index) itemBuilder,
}) {
  return SizedBox(
    height: 117,
    child: Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        reverse: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 34),
        itemBuilder: itemBuilder,
      ),
    ),
  );
}
