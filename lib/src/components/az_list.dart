import 'package:flutter/material.dart';

import 'package:sticky_az_list/src/typedef.dart';

import '../../sticky_az_list.dart';
import '../grouped_item.dart';

class AZList extends StatelessWidget {
  final ListOptions options;
  final ScrollPhysics? physics;
  final ScrollController controller;
  final List<GroupedItem> data;
  final GlobalKey? viewKey;
  final SymbolNullableStateBuilder? defaultSpecialSymbolBuilder;

  const AZList({
    Key? key,
    required this.options,
    this.physics,
    required this.controller,
    required this.data,
    this.viewKey,
    this.defaultSpecialSymbolBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: options.backgroundColor,
      padding: options.padding,
      child: CustomScrollView(
        key: viewKey,
        controller: controller,
        physics: physics,
        slivers: [
          SliverToBoxAdapter(child: options.beforeList),
          ...data
              .map((item) => SliverOffstage(
                    offstage: !item.children.isNotEmpty &&
                        !options.showSectionHeaderForEmptySections,
                    sliver: SliverList(
                      delegate:
                      SliverChildListDelegate(item.children.toList()),
                    )
                  ))
              .toList(),
          SliverToBoxAdapter(child: options.afterList),
        ],
      ),
    );
  }
}
