import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../models/personal_work_register/mini_event.dart';

class SelectedDatesContainer extends StatelessWidget {
  final List<MiniEvent> dates;
  final String option;

  const SelectedDatesContainer(this.dates, this.option);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Text(
              getTextMessage(),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  getTextMessage() {
    var toHour = dates.first.to?.hour.toString().padLeft(2, '0');
    var toMinute = dates.first.to?.minute.toString().padLeft(2, '0');
    var fromHour = dates.first.from?.hour.toString().padLeft(2, '0');
    var fromMinute = dates.first.from?.minute.toString().padLeft(2, '0');
    var fromDay = dates.first.from?.day;
    var fromMonth = dates.first.from?.month;
    var fromYear = dates.first.from?.year;

    if (option == Constants.weekend) {
      return 'Selecionou o fim de semana com o sábado $fromDay/$fromMonth/$fromYear e domingo ${dates.last.from?.day}/${dates.last.from?.month}/${dates.last.from?.year}\n Horário: $fromHour:$fromMinute até $toHour:$toMinute';
    }
    if (option == Constants.holiday) {
      return 'Selecionou o feriado dia ${dates.first.from?.day}/${dates.first.from?.month}/$fromYear\n Horário: $fromHour:$fromMinute até $toHour:$toMinute';
    }
    if (option == Constants.hours) {
      return 'Selecionou o dia ${dates.first.from?.day}/${dates.first.from?.month}/$fromYear\n Horário: $fromHour:$fromMinute até $toHour:$toMinute';
    } else {
      return "Não selecionou nenhuma opção válida";
    }
  }
}
