import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import '../../models/devil_costumes/devil_costume.dart';
import '../providers/devil_costume_provider.dart';
import 'costume_size.dart';

class BuyCostume extends ConsumerStatefulWidget {
  const BuyCostume({super.key, required this.reqType, this.constraints});

  final String reqType;
  final BoxConstraints? constraints;

  @override
  ConsumerState<BuyCostume> createState() => _BuyCostumeState();
}

class _BuyCostumeState extends ConsumerState<BuyCostume> {
  int numLines = 1;

  @override
  void initState() {
    super.initState();
    ref.read(devilCostumeListProvider).add(DevilCostume(
        id: numLines,
        size: Constants.customSizes.entries.first.value,
        quantity: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(getText(),
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 18,
            )),
        const SizedBox(width: 16),
        ...getCostumeSizeFormulary(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [addButton(), const SizedBox(height: 16), removeButton()],
        )
      ],
    );
  }

  getText() {
    if (widget.reqType == Constants.typeOfCustomRequest.values.toList()[0]) {
      return "Aluguer de fato (2€ de aluguer + 3€ de caução) no valor de 5€.";
    }
    if (widget.reqType == Constants.typeOfCustomRequest.values.toList()[1]) {
      return "Compra de fato USADO, no valor de 10€.";
    }
    if (widget.reqType == Constants.typeOfCustomRequest.values.toList()[2]) {
      return "Compra de fato NOVO, no valor de 23€.";
    }
  }

  Align addButton() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            onPressed: () {
              if (ref.read(devilCostumeListProvider).length < 8) {
                numLines++;
                ref.read(devilCostumeListProvider).add(DevilCostume(
                    id: numLines,
                    size: Constants.customSizes.entries.first.value,
                    quantity: 1));
                setState(() {});
              }
            },
            icon: const Icon(
              Icons.add_circle_outline,
              size: 40,
              color: Colors.teal,
            )),
      ),
    );
  }

  Align removeButton() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            onPressed: () {
              if (ref.read(devilCostumeListProvider).length > 1) {
                ref.read(devilCostumeListProvider).remove(DevilCostume(
                    id: numLines,
                    size: Constants.customSizes.entries.first.value,
                    quantity: 1));
                setState(() {
                  numLines--;
                });
              }
            },
            icon: const Icon(
              Icons.remove_circle_outline,
              size: 40,
              color: Colors.teal,
            )),
      ),
    );
  }

  List<Widget> getCostumeSizeFormulary() {
    List<Widget> temp = [];
    for (var i = 0; i < numLines; i++) {
      temp.add(CostumeSize(
          constraints: widget.constraints,
          costume: ref.read(devilCostumeListProvider)[i]));
    }
    return [...temp];
  }
}
