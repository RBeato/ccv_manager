import 'package:ccv_manager/common/custom_dropdown_with_title.dart';
import 'package:ccv_manager/constants/constants.dart';
import 'package:ccv_manager/home_page/home/home_page.dart';
import 'package:ccv_manager/home_page/provider/employees_provider.dart';
import 'package:ccv_manager/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/form_fields/date_field_from_to_double.dart';
import '../common/provider/date_time_field_from_to_provider.dart';
import '../common/show_dialog_box.dart';
import '../home_page/top_bar_functionality/provider/export_data_provider.dart';
import '../models/layout_helper_models/filter.dart';

class DataExportPage extends ConsumerStatefulWidget {
  const DataExportPage({Key? key}) : super(key: key);

  @override
  EventEditingPageState createState() => EventEditingPageState();
}

class EventEditingPageState extends ConsumerState<DataExportPage> {
  final _formKey = GlobalKey<FormState>();
  EventType? eventType;
  String? employeeValue;
  String? _section;
  Filter? filter;
  String? filterValue;

  @override
  void initState() {
    super.initState();
    _section = 'Eventos';
    filter = getFilters(_section);
    employeeValue = 'Todos';
    filterValue = filter?.items.first;
  }

  @override
  Widget build(BuildContext context) {
    var employees = ref.watch(employeesNamesProvider);

    double space = 30;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exportar dados'),
        leading: const CloseButton(),
        actions: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            icon: const Icon(Icons.download),
            label: const Text('EXPORTAR'),
            onPressed: () async {
              // await exportData();
              await _showDialog(_section);
            },
          ),
        ],
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Selecione o período pretendido. ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54),
                            ),
                            const DateFieldsFromTo(),
                            SizedBox(height: space * 2),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      DropdownMenuWithTitle(
                                        title: 'Seleção de secção',
                                        items: const [
                                          'Eventos',
                                          'Turnos/Ausências',
                                          'Registo de Visitantes',
                                          'Albergue',
                                          'Biblioteca',
                                          'Fatos de Diabo',
                                          'Tarefas',
                                        ],
                                        onPressed: (value) {
                                          setState(() {
                                            _section = value;
                                            filter = getFilters(
                                                _section); // Update the filter object here

                                            if (filter != null) {
                                              filterValue =
                                                  filter!.selectedItem;
                                            }
                                          });
                                        },
                                        selectedValue: _section,
                                        addTitle: true,
                                      ),
                                      Container(),
                                    ],
                                  ),
                                ),
                                filter != null
                                    ? Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: DropdownMenuWithTitle(
                                                title: filter!.title,
                                                items: filter!.items,
                                                selectedValue: filterValue,
                                                addTitle: true,
                                                onPressed: (value) {
                                                  setState(
                                                    () {
                                                      filterValue = value;
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ])),
                ),
                ['Eventos', 'Turnos/Ausências', 'Tarefas'].contains(_section)
                    ? Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: employees.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RadioListTile<String>(
                                  title: Text(employees[index]),
                                  value: employees[index],
                                  groupValue: employeeValue,
                                  onChanged: (value) {
                                    setState(() {
                                      employeeValue = value;
                                    });
                                  });
                            },
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          )),
    );
  }

  _showDialog(page) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          var timeFrame = ref.read(dateTimeFromToProvider);

          return AlertDialog(
            title: Text('Exportar dados referentes a "$_section"'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.2, // 50% of screen height
              width: MediaQuery.of(context).size.width *
                  0.3, // 80% of screen width
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    timeFrame != null
                        ? Text(
                            "Dados entre o período compreendido entre: ${DateTimeUtils.toDateString(ref.read(dateTimeFromToProvider)!.from!)} e ${DateTimeUtils.toDateString(ref.read(dateTimeFromToProvider)!.to!)}")
                        : const Text('Selectione o período compreendido.'),
                    [
                      Constants.visitorsRegister,
                      Constants.hostel,
                      Constants.todo,
                    ].contains(_section)
                        ? Container()
                        : filterValue != null
                            ? Text("Opção selecionada: $filterValue")
                            : Container(),
                    [
                      Constants.library,
                      Constants.visitorsRegister,
                      Constants.devilCostumes,
                      Constants.hostel
                    ].contains(_section)
                        ? Container()
                        : employeeValue != null
                            ? employeeValue == 'Todos'
                                ? const Text(
                                    "Dados para todos os funcionários.")
                                : Text(
                                    "Dados para o funcionário(a) $employeeValue")
                            : Container(),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("CANCELAR"),
              ),
              TextButton(
                onPressed: () => exportData(),
                child: const Text("EXPORTAR"),
              ),
            ],
          );
        });
  }

  getFilters(section) {
    if (section == 'Eventos') {
      return Filter(
        title: Constants.eventType,
        items: Constants.eventList,
        selectedItem: Constants.eventList.first,
      );
    }
    if (section == 'Turnos/Ausências') {
      return Filter(
        title: Constants.employeeActivityOptions,
        items: Constants.employeeActivityOptionsList,
        selectedItem: Constants.employeeActivityOptionsList.first,
      );
    }

    // if (section == 'Registo de Visitantes') {}
    // if (section == 'Albergue') {}
    if (section == 'Biblioteca') {
      return Filter(
        title: Constants.libraryRequests,
        items: Constants.requestOptions,
        selectedItem: Constants.requestOptions.first,
      );
    }
    if (section == 'Fatos de Diabo') {
      return Filter(
          title: Constants.devilCostumes,
          items: Constants.requestOptions,
          selectedItem: Constants.requestOptions.first);
    }
    if (section == 'Tarefas') {}
  }

  // getFunc(Filter filter) {
  //   return (value) {
  //     filter.selectedItem = value;
  //     ref.read(filtersProvider.notifier).updateFilter(filter);
  //   };
  // }

  Future exportData() async {
    try {
      await ref.read(exportDataProvider.notifier).getData(
            section: _section,
            filterValue: filterValue,
            employee: employeeValue,
          );
      if (ref.read(exportDataProvider).isEmpty) {
        Navigator.of(context).pop();
        showError();
      }
      Navigator.of(context).pop();
    } catch (e) {
      print("Error: $e");
      Navigator.of(context).pop();
      showError();
    }
  }

  showError() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Erro ao exportar dados!"),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  "Não é possível exportar dados referente ao período selecionado. Veja se os filtros estão corretos",
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      });

  handleValidation() {
    if (eventType == null) {
      // Remove the check for empty string
      callDialogBox('o tipo evento');
      return;
    }

    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
  }

  callDialogBox(text) {
    return showDialogBox(
      context: context,
      title: 'Formulário Incompleto',
      content: 'Por favor selecione $text',
      confirmText: 'OK',
      OnPressedConfirm: () => Navigator.of(context).pop(),
    );
  }

  goHome() => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
}
