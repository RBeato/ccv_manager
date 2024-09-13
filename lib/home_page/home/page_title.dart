import 'package:ccv_manager/common/check_is_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/constants.dart';
import '../provider/tile_selection_provider.dart';

class PageTitle extends ConsumerWidget {
  const PageTitle({this.constraints, super.key});
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data = getData(ref.watch(pageSelectionProvider));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(data['title'],
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: isMobile(constraints) ? 20 : 34,
              fontWeight: FontWeight.w700,
              color: Colors.teal.withOpacity(0.55),
            )),
        IconButton(
          onPressed: () {
            _showLogoutDialog(context, data);
          },
          icon: Icon(Icons.help_outline_outlined,
              color: Colors.teal.withOpacity(0.55)),
        )
      ],
    );
  }

  _showLogoutDialog(BuildContext context, Map data) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              data["title"],
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.15, // 50% of screen height
              width: MediaQuery.of(context).size.width *
                  0.3, // 80% of screen width
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Text(
                    data["description"],
                    textAlign: TextAlign.justify,
                  ),
                ],
              )),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }

  Map getData(selectedTile) {
    String title = "";
    String description = "";

    if (selectedTile == PageSelection.events) {
      title = "Eventos";
      description =
          "Aqui pode ver os eventos que estão agendados. O filtro 'Tipo de evento' permite selecionar apenas as datas relativas a um determinado tipo de evento. O filtro 'Tipo de Vista' permite alternar entre o calendário e a lista de eventos. O botão 'Novo evento' direciona o utilizador para uma página de registo de eventos.";
    }
    if (selectedTile == PageSelection.visitorsRegister) {
      title = "Registo de visitantes";
      description =
          "Aqui pode ver o número de pessoas que visitaram o Centro Cultural de Vinhais em cada dia do mês. Quando se faz a exportação dos dados relativamente aos visitantes nas 'Definições' é possível verificar a hora a que foi registada a visita. O filtro 'Tipo de Vista' permite alternar entre o calendário e a lista de visitas. Os novos registos são feitos pressionando o botão 'Novo registo'";
    }
    if (selectedTile == PageSelection.hostel) {
      title = "Albergue";
      description =
          "Aqui pode ver quando é que os peregrinos fazem check in para o albergue. O filtro 'Tipo de Vista' permite alternar entre o calendário e a lista de pessoas alojadas. O botão 'Registar Entrada' permite inserir o nome, data de entrada e observações.";
    }
    if (selectedTile == PageSelection.library) {
      title = "Biblioteca";
      description =
          "Aqui pode ver a lista de requisições de livros, bem como as devoluções pendentes. Ao pressionar o botão 'Nova Requisição' é possível fazer o registo de uma nova requisição de até 3 livros. Dentro desta página é também possível fazer o registo de um novo usuário, para evitar ter de inserir os dados pessoais a cada nova requisição.";
    }
    if (selectedTile == PageSelection.notifications) {
      title = 'Notificações';
      description =
          "Aqui pode ver a lista de notificações referentes a eventos, alterações nos turnos/ausências, tarefas e situações relacionadas com devoluções de livros e fatos de diabo. As notificações referem-se normalmente a cinco dias úteis a partir da data atual.";
    }
    if (selectedTile == PageSelection.todo) {
      title = "Tarefas";
      description =
          "Aqui pode ver a lista de novas tarefas atríbuidas ao utilizador. No caso de ter permissões ao nível de administrador será possível ver as tarefas atribuídas a todos os funcionários. O botão 'Nova tarefa' permite fazer uma nova atribuição.";
    }
    if (selectedTile == PageSelection.shiftsAndOffDays) {
      title = "Turnos/Ausências";
      description =
          "Aqui pode ver os turnos e ausências dos funcionários. O filtro 'Opções' permite selecionar os turnos, as folgas, ou ambos, enquanto que o filtro 'Funcionários' permite ver a informação relativa a todos os funcionários, ou um em particular. O botão 'Adicionar turno/ausência direciona o utilizador para uma página para um novo registo.";
    }
    if (selectedTile == PageSelection.settings) {
      title = "Definições";
      description =
          """Aqui pode:\n\n- Alternar entre dark/light mode, no botão 'Modo';
          \n- Fazer logout no botão 'Sair';
          \n- Exportar dados relativos aos variados tipos de eventos, no botão 'Exportar'.
          """;
    }
    if (selectedTile == PageSelection.devilCostumes) {
      title = "Fatos de Diabo";
      description =
          "Aqui pode ver a lista de requisições de fatos de diabo, bem como as devoluções pendentes. Ao pressionar o botão 'Nova Requisição' é possível fazer o registo de uma nova requisição. Dentro desta página é também possível fazer o registo de um novo usuário, para evitar ter de inserir os dados pessoais a cada nova requisição.";
    }

    return {'title': title, 'description': description};
  }
}
