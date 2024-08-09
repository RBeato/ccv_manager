import 'package:ccv_manager/services/firebase_storing.dart';
import 'package:flutter/material.dart';

import '../models/cultural_events/auditorium.dart';

enum ThemeType {
  light,
  dark,
}

enum DevilCustomUsage { used, newlyBought, rental }

enum NotificationType {
  shift,
  todo,
  event,
  book,
  devilCostume,
  hostel,
  visitor,
  offDay
}

enum ShiftType {
  morning,
  afternoon,
  night,
}

enum EventType {
  meeting,
  activity,
  concert,
  theater,
  dance,
  guidedVisit,
  roomReservation,
  shift,
  offDay,
  task,
  bookRequest,
  devilCostume,
  hostelReservation,
  artExhibition
}

enum TodoStatus {
  completed,
  pending,
}

enum RoomType {
  dinningRoom,
  clockRoom,
  paintedRoom,
  mainAuditorium,
  barFoyer,
  upperFoyer,
}

enum PageSelection {
  events,
  visitorsRegister,
  devilCostumes,
  library,
  shiftsAndOffDays,
  ticketOffice,
  suggestions,
  todo,
  notifications,
  requisition,
  settings,
  hostel,
}

class Constants {
  static const String day = "Dia";
  static const String week = "Semana";
  static const String month = "Mês";
  static const String workDay = "Dia de trabalho";
  static const String vista = "Vista";
  static const String hostelReservation = "Reserva de Albergue";
  static const String users = "users";
  static const String libraryUser = "libraryUser";
  static const String shifts = "shifts";
  static const String offDays = "offDays";
  static const String hostelReservations = 'hostelReservations';

  static const String meeting = 'Reunião';
  static const String activity = 'Atividade';
  static const String concert = 'Concerto';
  static const String theater = 'Teatro';
  static const String dance = 'Dança';
  static const String guidedVisit = 'Visita Guiada';
  static const String roomReservation = 'Reserva de Sala';
  static const String dinningRoom = 'Sala de Jantar';
  static const String clockRoom = 'Sala do Relógio';
  static const String paintedRoom = 'Sala Pintada';
  static const String mainAuditorium = 'Auditório Principal';
  static const String barFoyer = 'Foyer do Bar';
  static const String upperFoyer = 'Foyer Superior';
  static const String task = 'Task';
  static const String todo = 'Tarefa';
  static const String devilCostume = 'Fato do Diabo';
  static const String bookRequest = 'Requisição de Livro';
  //*
  static const String regular = 'Regular';
  static const String senior = 'Senior';
  static const String junior = 'Junior';

  static const Map<Attendant, String> auditoriumAttendantToString = {
    Attendant.junior: Constants.junior,
    Attendant.regular: Constants.regular,
    Attendant.senior: Constants.senior,
  };

  //*
  static const String fourYearsOld = '4 anos';
  static const String sevenYearsOld = '7 anos';
  static const String tenYearsOld = '10 anos';
  static const String sizeXs = 'XS';
  static const String sizeS = 'S';
  static const String sizeM = 'M';
  static const String sizeL = 'L';
  static const String sizeXl = 'XL';
  static const String sizeXxl = 'XXL';
  //*
  static const String rental = 'Aluguer';
  static const String buyUsed = 'Comprar Usado';
  static const String buyNew = 'Comprar Novo';
  //*
  static const String weekend = "Fim de semana";
  static const String holiday = "Feriado";
  static const String hours = "Horas";
  static const String medicalCertificate = "Atestado Médico";
  static const String medicalAppointment = "Consulta Médica";
  static const String vacation = "Férias";
  static const String absence = "Ausência";
  static const String offDay = "Folga";
  static const String shift = "Turno";

  static const Map<PageSelection, FirestoreCollection>
      pageSelectionToFirestoreCollection = {
    PageSelection.events: FirestoreCollection.events,
    PageSelection.visitorsRegister: FirestoreCollection.visitors,
    PageSelection.devilCostumes: FirestoreCollection.devilCostumes,
    PageSelection.library: FirestoreCollection.library,
    PageSelection.shiftsAndOffDays: FirestoreCollection.shifts,
    PageSelection.suggestions: FirestoreCollection.suggestions,
    PageSelection.todo: FirestoreCollection.todo,
    PageSelection.notifications: FirestoreCollection.notifications,
  };

  static const Map<String, FirestoreCollection> sectionToFirestoreCollection = {
    Constants.events: FirestoreCollection.events,
    Constants.hostel: FirestoreCollection.hostelReservations,
    Constants.visitorsRegister: FirestoreCollection.visitors,
    Constants.devilCostumes: FirestoreCollection.devilCostumes,
    Constants.library: FirestoreCollection.library,
    Constants.shiftsSlashOffDays: FirestoreCollection.shifts,
    Constants.suggestions: FirestoreCollection.suggestions,
    Constants.todo: FirestoreCollection.todo,
    Constants.notifications: FirestoreCollection.notifications,
  };

  static const Map<FirestoreCollection, String> firestoreToString = {
    FirestoreCollection.users: Constants.users,
    FirestoreCollection.events: Constants.events,
    FirestoreCollection.visitors: Constants.visitorsRegister,
    FirestoreCollection.devilCostumes: Constants.devilCostumes,
    FirestoreCollection.library: Constants.library,
    FirestoreCollection.libraryUser: Constants.libraryUser,
    FirestoreCollection.shifts: Constants.shifts,
    FirestoreCollection.offDays: Constants.offDays,
    FirestoreCollection.suggestions: Constants.suggestions,
    FirestoreCollection.todo: Constants.todo,
    FirestoreCollection.notifications: Constants.notifications,
    FirestoreCollection.hostelReservations: Constants.hostelReservations,
  };

  static const Map<int, String> typeOfCustomRequest = {
    1: rental,
    2: buyUsed,
    3: buyNew,
  };

  static const List<String> shiftTypes = [
    weekend,
    holiday,
    hours,
  ];

  static const List<String> offDayTypes = [
    offDay,
    vacation,
    hours,
    medicalAppointment,
    medicalCertificate,
  ];

  static const Map<int, String> customSizes = {
    0: fourYearsOld,
    1: sevenYearsOld,
    2: tenYearsOld,
    3: sizeXs,
    4: sizeS,
    5: sizeM,
    6: sizeL,
    7: sizeXl,
    8: sizeXxl
  };

  static const String employeeActivityOptions = "Opções";
  static const String eventType = "Tipo de evento";
  static const String eventView = "Tipo de vista";
  static const String employee = "Funcionários";
  // static const String visitorsRegister = "Registo de Visitantes";
  static const String libraryRequests = "Requisições";
  // static const String ticketOffice = "Bilheteira";
  static const String employeeTodo = "Tarefas";
  static const String employeeSuggestion = "Sugestões";
  static const String devilCostumes = "Fatos de Diabo";
  static const String notifications = "Notificações";
  static const String requisition = "Requisição";
  static const String settings = "Definições";
  static const String hostel = "Albergue";
  static const String events = "Eventos";
  static const String artExhibition = "Exposição de Arte";
  static const String shiftsAndOffDays = "Turnos e Ausências";
  static const String shiftsSlashOffDays = "Turnos/Ausências";
  static const String suggestions = "Sugestões";
  static const String todos = "Tarefas";
  static const String library = "Biblioteca";
  static const String visitorsRegister = "Registo de Visitantes";

  static const List<String> filterTypes = [
    eventType,
    eventView,
    employee,
    // visitorsRegister,
    libraryRequests,
    // ticketOffice,
    employeeTodo,
    employeeSuggestion,
    devilCostumes,
    // notifications,
    // requisition,
    // settings,
  ];

  static const List<String> calendarViews = <String>[
    day,
    week,
    month,
    workDay,
  ];

  //*CALENDAR PAGE VIEW *********************
  static const String eventTiles = "Lista";
  static const String eventCalendar = "Calendário";
  static const List<String> calendarPageViews = <String>[
    eventCalendar,
    eventTiles,
  ];

  static List<String> eventList = [
    "Todos",
    ...Constants.eventTypeToString.values.toList().sublist(0, 6)
  ];

  static List<String> employeeActivityOptionsList = [
    "Todas",
    "Turnos",
    "Folgas"
  ];

  static const Map<PageSelection, String> pageSelectionToString = {
    PageSelection.events: events,
    PageSelection.visitorsRegister: visitorsRegister,
    PageSelection.devilCostumes: devilCostumes,
    PageSelection.library: library,
    PageSelection.shiftsAndOffDays: shiftsAndOffDays,
    PageSelection.todo: todos,
  };

  static const Map<EventType, String> eventTypeToString = {
    EventType.meeting: meeting,
    EventType.activity: activity,
    EventType.concert: concert,
    EventType.theater: theater,
    EventType.dance: dance,
    EventType.guidedVisit: guidedVisit,
    EventType.roomReservation: roomReservation,
    EventType.artExhibition: artExhibition,
  };

  static const Map<EventType, String> eventCategoryToString = {
    EventType.meeting: meeting,
    EventType.activity: activity,
    EventType.concert: concert,
    EventType.theater: theater,
    EventType.dance: dance,
    EventType.guidedVisit: guidedVisit,
    EventType.roomReservation: roomReservation,
    EventType.offDay: offDay,
    EventType.shift: shift,
    EventType.task: task,
    EventType.devilCostume: devilCostume,
    EventType.bookRequest: bookRequest,
    EventType.hostelReservation: hostelReservation,
    EventType.artExhibition: artExhibition,
  };

  static const Map<String, String> signInMessageTranslator = {
    "AuthException: INVALID_PASSWORD": "Palavra passe inválida!",
    "AuthException: TOO_MANY_ATTEMPTS_TRY_LATER":
        "Demasiadas tentativas, tente mais tarde!",
    "EMAIL_NOT_REGISTERED": "Email não registado"
  };

  static const Map<String, EventType> stringToEventType = {
    meeting: EventType.meeting,
    activity: EventType.activity,
    concert: EventType.concert,
    theater: EventType.theater,
    dance: EventType.dance,
    guidedVisit: EventType.guidedVisit,
    roomReservation: EventType.roomReservation,
    offDay: EventType.offDay,
    shift: EventType.shift,
    task: EventType.task,
    artExhibition: EventType.artExhibition,
  };

  static List<String> requestOptions = [
    "Todos",
    "Por devolver",
  ];

  //*********************

  static const List<String> roomsList = [
    dinningRoom,
    clockRoom,
    paintedRoom,
    mainAuditorium,
  ];

  static const String title = "title";
  static const String icon = "icon";
  static const String tileSelection = "tileSelection";

  static const List<Map> drawerTileData = [
    {
      Constants.title: 'Notificações',
      Constants.icon: Icons.notification_add,
      Constants.tileSelection: PageSelection.notifications
    },
    {
      Constants.title: 'Eventos',
      Constants.icon: Icons.calendar_today,
      Constants.tileSelection: PageSelection.events
    },
    {
      Constants.title: 'Turnos/Ausências',
      Constants.icon: Icons.access_time,
      Constants.tileSelection: PageSelection.shiftsAndOffDays
    },
    {
      Constants.title: 'Registo de visitantes',
      Constants.icon: Icons.people,
      Constants.tileSelection: PageSelection.visitorsRegister
    },
    {
      Constants.title: 'Albergue',
      Constants.icon: Icons.night_shelter,
      Constants.tileSelection: PageSelection.hostel
    },
    {
      Constants.title: 'Biblioteca',
      Constants.icon: Icons.library_books,
      Constants.tileSelection: PageSelection.library
    },
    // {
    //   Constants.title: 'Bilheteira',
    //   Constants.icon: Icons.airplane_ticket,
    //   Constants.tileSelection: PageSelection.ticketOffice
    // },
    // {
    //   Constants.title: 'Sugestões',
    //   Constants.icon: Icons.newspaper,
    //   Constants.tileSelection: PageSelection.suggestions
    // },
    {
      Constants.title: 'Fatos de Diabo',
      Constants.icon: Icons.shopping_bag,
      Constants.tileSelection: PageSelection.devilCostumes
    },
    {
      Constants.title: 'Tarefas',
      Constants.icon: Icons.task,
      Constants.tileSelection: PageSelection.todo
    },
    {
      Constants.title: 'Definições',
      Constants.icon: Icons.settings,
      Constants.tileSelection: PageSelection.settings
    },
  ];

  static const Map<String, List<String>> headers = {
    Constants.events: [
      'eventName',
      'from',
      'to',
      'eventType',
      'assignedEmployee',
      // 'auditorium',
      'employees',
      'equipment',
      'eventCreationDate',
      'eventCreator',
      // 'id',
      'isCompleted',
      'requester',
      'spaceRoom',
      'requester'
    ],
    Constants.devilCostumes: [
      'name',
      'phoneNumber',
      'address',
      'costumes',
      'requestDate',
      'deliveryDate',
      'deliveryDateLimit',
      'devilCostumeRequestType',
      'eventType',
      'status',
    ],
    Constants.hostel: ['eventName', 'from', 'to', 'observations'],
    Constants.library: [
      'userName',
      'userId',
      'books',
      'requestDate',
      'deliveryDateLimit',
      'deliveryDate',
      'status',
      'observations',
      'renewed'
    ],
    Constants.shiftsSlashOffDays: [
      'assignedEmployee',
      'type',
      'from',
      'to',
      'eventCreationDate',
      'eventType',
      'lastEditedBy',
      'lastEditedOn'
    ],
    Constants.shift: [
      'assignedEmployee',
      'type',
      'from',
      'to',
      'eventCreationDate',
      'eventType',
      'lastEditedBy',
      'lastEditedOn'
    ],
    Constants.offDay: [
      'assignedEmployee',
      'type',
      'from',
      'to',
      'eventCreationDate',
      'eventType',
      'lastEditedBy',
      'lastEditedOn'
    ],
    Constants.todo: [
      'assignedEmployee',
      'eventName',
      'eventType',
      'from',
      'to',
      'eventCreationDate',
      'eventType',
      'lastEditedBy',
      'lastEditedOn',
      'observations',
      'requester',
      'spaceRoom',
    ],
    Constants.visitorsRegister: [
      'visitorCounter',
      'from',
      'to',
    ]
  };
}
