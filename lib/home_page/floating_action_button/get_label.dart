import '../../constants/constants.dart';

String getLabel(selectedTile) {
  if (selectedTile == PageSelection.events) {
    return "Novo evento";
  }
  if (selectedTile == PageSelection.library) {
    return "Nova requisição";
  }
  if (selectedTile == PageSelection.devilCostumes) {
    return "Nova requisição";
  }

  if (selectedTile == PageSelection.requisition) {
    return "Novo utilizador";
  }
  if (selectedTile == PageSelection.hostel) {
    return 'Registar entrada';
  }
  if (selectedTile == PageSelection.suggestions) {
    return 'Sugestão';
  }
  if (selectedTile == PageSelection.todo) {
    return 'Nova tarefa';
  }
  if (selectedTile == PageSelection.ticketOffice) {
    return 'Registar Lugares';
  }
  if (selectedTile == PageSelection.visitorsRegister) {
    return "Novo registo";
  }
  if (selectedTile == PageSelection.shiftsAndOffDays) {
    return "Adicionar turno/ausência";
  }
  return 'sem label';
}
