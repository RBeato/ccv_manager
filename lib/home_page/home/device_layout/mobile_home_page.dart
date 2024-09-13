import 'package:ccv_manager/home_page/drawer/custom_drawer.dart';
import 'package:ccv_manager/home_page/home/data_widget_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../top_bar_functionality/top_bar_functionality.dart';
import '../page_title.dart';

class MobileVersion extends ConsumerStatefulWidget {
  const MobileVersion({super.key});

  @override
  ConsumerState<MobileVersion> createState() => _MobileVersionState();
}

class _MobileVersionState extends ConsumerState<MobileVersion> {
  final bool _showFilter = false;

  @override
  Widget build(BuildContext context) {
    // _showFilter = ref.watch(showMobileBottomSheet);
    return SafeArea(
        child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) =>
          Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: FittedBox(child: PageTitle(constraints: constraints)),
              actions: [
                IconButton(
                  onPressed: () {
                    _showBottomSheet();
                  },
                  icon: Icon(Icons.filter_list,
                      color: _showFilter ? Colors.grey : Colors.teal),
                )
              ],
              iconTheme: const IconThemeData(
                color: Colors.teal,
              ),
            ),
            body: Column(children: const [
              Expanded(child: HomeDataWidgetSelector()),
              // Container(
              //     color: Colors.teal.shade400, child: const FunctionalityBar()),
            ]),
            drawer: const Drawer(child: CustomDrawer(isMobile: true))),
      ),
    ));
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double height = constraints.maxHeight;
              double maxHeight = 170.0;
              double minHeight = 100.0;
              height = height.clamp(minHeight, maxHeight);

              return SizedBox(
                height: height,
                child: const FunctionalityBar(),
              );
            },
          ),
        );
      },
    );
  }
}
