import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import '../provider/tile_selection_provider.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({required this.isMobile, super.key});
  final bool isMobile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(pageSelectionProvider);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 254, 254, 254),
            Color.fromARGB(255, 142, 215, 203),
            // Color.fromARGB(255, 104, 199, 183),
            Color.fromARGB(255, 18, 99, 85),
          ],
        ),
      ),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.center, // This will center the image
                child: Image.asset(
                  'assets/images/CCV.png', // Image path from assets
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300, minWidth: 200),
              child: ListView(
                  children: List<Widget>.from(Constants.drawerTileData
                      .map((tile) => ListTile(
                            title: Text(tile[Constants.title],
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: selected ==
                                            tile[Constants.tileSelection]
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    color: selected ==
                                            tile[Constants.tileSelection]
                                        ? Colors.black54
                                        : Colors.black54)),
                            leading: Icon(tile[Constants.icon]),
                            onTap: () async {
                              ref.read(pageSelectionProvider.notifier).update(
                                    (state) => tile[Constants.tileSelection],
                                  );

                              if (isMobile) {
                                Future.delayed(
                                    const Duration(milliseconds: 400), () {
                                  Navigator.pop(context);
                                });
                              }
                            },
                          ))
                      .toList())),
            ),
          ),
        ],
      ),
    );
  }
}
