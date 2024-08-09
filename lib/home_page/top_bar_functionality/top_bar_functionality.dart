import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../common/check_is_mobile.dart';
import '../../common/custom_dropdown_with_title.dart';
import '../../models/layout_helper_models/filter.dart';
import '../home/page_title.dart';
import '../provider/filters_provider.dart';
import '../provider/tile_selection_provider.dart';

class FunctionalityBar extends ConsumerStatefulWidget {
  const FunctionalityBar({Key? key}) : super(key: key);

  @override
  ConsumerState<FunctionalityBar> createState() => _FunctionalityBarState();
}

class _FunctionalityBarState extends ConsumerState<FunctionalityBar> {
  late List widgetList;

  @override
  Widget build(BuildContext context) {
    ref.watch(filtersProvider);
    ref.watch(pageSelectionProvider);
    final filters = ref.watch(filtersProvider.notifier);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: isMobile(constraints)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        List<Widget>.from(filters.listOfFilter.map((filter) {
                      return DropdownMenuWithTitle(
                        title: filter.title,
                        items: filter.items,
                        selectedValue: filter.selectedItem,
                        addTitle: true,
                        onPressed: getFunc(filter),
                      );
                    }).toList()),
                  )
                : Container(
                    // constraints: const BoxConstraints(maxHeight: 300),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const PageTitle(),
                          Flexible(
                              fit: FlexFit.loose,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  children: List<Widget>.from(
                                      filters.listOfFilter.map((filter) {
                                    return DropdownMenuWithTitle(
                                      title: filter.title,
                                      items: filter.items,
                                      selectedValue: filter.selectedItem,
                                      addTitle: true,
                                      onPressed: getFunc(filter),
                                    );
                                  }).toList()),
                                ),
                              ))
                        ]),
                  )),
      );
    });
  }

  getFunc(Filter filter) {
    return (value) {
      filter.selectedItem = value;
      ref.read(filtersProvider.notifier).updateFilter(filter);
    };
  }

  List<Widget> content(filters) => [
        const PageTitle(),
        Flexible(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            children: List<Widget>.from(filters.listOfFilter.map((filter) {
              return DropdownMenuWithTitle(
                title: filter.title,
                items: filter.items,
                selectedValue: filter.selectedItem,
                addTitle: true,
                onPressed: getFunc(filter),
              );
            }).toList()),
          ),
        ))
      ];
}
