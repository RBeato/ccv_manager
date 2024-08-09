import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ratioProvider = Provider((ref) => 0.75);

final generalHeightProvider = Provider.family(
    (ref, BuildContext context) => MediaQuery.of(context).size.height * 0.9);

var calendarWidthProvider = Provider.family((ref, BuildContext context) {
  var rat = ref.watch(ratioProvider);
  return MediaQuery.of(context).size.width * rat;
});

var drawerWidthProvider = Provider.family((ref, BuildContext context) {
  var rat = ref.watch(ratioProvider);
  return MediaQuery.of(context).size.width * (1 - rat);
});
