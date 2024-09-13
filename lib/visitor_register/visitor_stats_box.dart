import 'package:ccv_manager/visitor_register/provider/visitor_all_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VisitorsStatsBox extends ConsumerWidget {
  const VisitorsStatsBox({super.key});

  final TextStyle _style = const TextStyle(
    color: Colors.black54,
    fontSize: 18,
  );

  final TextStyle _dataStyle = const TextStyle(
    color: Colors.black87,
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visitorDataProvider = ref.watch(visitorsDataProvider);
    return visitorDataProvider.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
      data: (data) => Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("Hoje: ", style: _style),
                  Text(data["todayVisits"].toString(), style: _dataStyle),
                ],
              ),
              Row(
                children: [
                  Text("Últimos 7 dias: ", style: _style),
                  Text(data["weeklyVisits"].toString(), style: _dataStyle),
                ],
              ),
              Row(
                children: [
                  Text("Últimos 30 dias: ", style: _style),
                  Text(data["monthlyVisits"].toString(), style: _dataStyle),
                ],
              ),
              Row(
                children: [
                  Text("Últimos 365 dias: ", style: _style),
                  Text(data["yearlyVisits"].toString(), style: _dataStyle),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
