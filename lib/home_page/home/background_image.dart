import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/sizes_provider.dart';

class BackgroundImage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: ref.read(drawerWidthProvider(context))),
            Row(
              children: [
                SizedBox(width: ref.read(drawerWidthProvider(context))),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Opacity(
                        opacity: 0.05,
                        child: Image.asset(
                          'assets/images/vv_no_background.png', // Image path from assets
                          // width: 200,
                          // height: MediaQuery.of(context).size.height,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // ),
          ],
        ),
      ),
    ));
  }
}
