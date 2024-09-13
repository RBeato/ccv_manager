import 'package:ccv_manager/devil_costumes/providers/devil_costume_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/check_is_mobile.dart';
import '../../constants/constants.dart';
import '../../events_widget/common/row_column_mobile_conditional_builder.dart';
import '../../models/devil_costumes/devil_costume.dart';

class CostumeSize extends ConsumerStatefulWidget {
  const CostumeSize({required this.costume, this.constraints, super.key});
  final DevilCostume costume;
  final BoxConstraints? constraints;

  @override
  ConsumerState<CostumeSize> createState() => _CostumeSizeState();
}

class _CostumeSizeState extends ConsumerState<CostumeSize> {
  int _selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    DevilCostume costume = widget.costume;
    return ConditionalParentWidget(
      condition: isMobile(widget.constraints),
      children: [
        Row(
          children: [
            const Text('Tamanho: ',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                )),
            const SizedBox(width: 20.0),
            DropdownButton<int>(
              value: _selectedSize,
              items: Constants.customSizes.entries
                  .map((entry) => DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      ))
                  .toList(),
              onChanged: (int? newValue) {
                _selectedSize = newValue!;
                costume.size = Constants.customSizes[_selectedSize]!;
                ref.read(devilCostumeListProvider.notifier).update(costume);
                setState(() {});
              },
            ),
          ],
        ),
        Row(
          children: [
            const Text('Quantidade:',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                )),
            const SizedBox(width: 20.0),
            DropdownButton<int>(
              value: costume.quantity,
              items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                  .map((number) => DropdownMenuItem(
                        value: number,
                        child: Text('$number'),
                      ))
                  .toList(),
              onChanged: (int? newValue) {
                costume.quantity = newValue!;
                ref.read(devilCostumeListProvider.notifier).update(costume);
                setState(() {});
              },
            ),
          ],
        )
      ],
    );
  }
}
