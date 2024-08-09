import 'package:ccv_manager/events_widget/task_item.dart';
import 'package:ccv_manager/models/cultural_events/form_task.dart';

import 'package:flutter/material.dart';

import '../common/appbar_editing_save_button.dart';
import '../common/check_is_mobile.dart';
import '../constants/constants.dart';
import '../models/cultural_events/art_exhibition.dart';
import '../models/cultural_events/cultural_event.dart';
import '../models/cultural_events/general_event.dart';
import '../models/employee.dart';

class EventAdditionalFormPage extends StatefulWidget {
  const EventAdditionalFormPage(
      {required this.constraints,
      required this.event,
      required this.availableEmployees,
      required this.onFormTasksChanged,
      super.key});
  final BoxConstraints constraints;
  final List<Employee> availableEmployees;
  final CulturalEvent event;
  final Function(List<FormTask>)? onFormTasksChanged;

  @override
  State<EventAdditionalFormPage> createState() =>
      _EventAdditionalFormPageState();
}

class _EventAdditionalFormPageState extends State<EventAdditionalFormPage>
    with WidgetsBindingObserver {
  List<FormTask> formTasks = [];
  bool isMobileLayout = false;
  late Future<List<Map<String, dynamic>>> formTasksFuture; //
  final String _isComplete = "Concluída";
  final String _isInProgress = "A ser tratada";

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    isMobileLayout = isMobile(widget.constraints);
    _initFormTasks();
  }

  void _initFormTasks() async {
    _selectTasks(widget.event.eventType);
  }

  _selectTasks(EventType? eventType) {
    if ([EventType.concert, EventType.dance].contains(widget.event.eventType)) {
      formTasks = [
        ShowProposalRequest(),
        ProposalAnalysis(),
        Scheduling(),
        AuditoriumTechnicalRider(),
        StructureProduction(),
        OtherMaterialsProduction(),
        LicenseVerification(),
        AccommodationAndFood(),
        PromotionalMaterials(),
        PressRelease(),
        PublicityPoster(),
        OnlineEventCreation(),
        PublicityOnSocialMedia(),
        SendingPostersToParishCouncils(),
        FlyerDistribution(),
      ];
    }
    if ([EventType.artExhibition].contains(widget.event.eventType)) {
      formTasks = [
        ArtistMeetings(),
        RoomConditionSending(),
        ArtworkSelection(),
        ExhibitionLayoutDefinition(),
        FinalArtListWithInsuranceValues(),
        RoomConditionProduction(),
        TransportInsuranceBudget(),
        ConcentrationTransportBudget(),
        DispersionTransportBudget(),
        ArtworkConditionChecking(),
        ArtworkPackaging(),
        ExhibitionSpaceRepairAndPainting(),
        PackagingCollectionTransportAndDelivery(),
        PreviousExhibitionArtworkReturn(),
        ArtStructureProduction(),
        FrameProduction(),
        OtherMaterialProduction(),
        ArtistAccommodationAndFood(),
        AdvertisingDisplays(),
        RoomLeaflets(),
        WallText(),
        ExhibitionSetup(),
        ArtworkUnpackingAndConditionChecking(),
        ArtworkDistributionInExhibitionSpace(),
        ExhibitionAssembly(),
        ExhibitionLighting(),
        WallTextAndTableProductionAndApplication(),
        Opening(),
        TemperatureAndHumidityCheckingAndRecording(),
        ArtworkConservationStatusVerification(),
        MonthlyVisitorMapSubmission(),
        VisitorSatisfactionSurveyProvision(),
        ExhibitionPhotographicRecording(),
        DesignerBudgetRequest(),
        ProductionBudgetRequest(),
        CatalogReview(),
        CatalogProductionPrinting(),
        TotalVisitorCount(),
        ExhibitionDismantling(),
        ArtworkConservationAndPackagingVerification(),
        ArtworkTransportAndReturn(),
      ];
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _handleTaskUpdate(FormTask updatedTask) {
    setState(() {
      // Find the index of the task to be updated
      int index = formTasks.indexWhere((task) => task.id == updatedTask.id);
      // Update the task at the found index
      if (index != -1) {
        formTasks[index] = updatedTask;
      }
    });
    // Call the widget.onFormTasksChanged if needed
    widget.onFormTasksChanged?.call(formTasks);
  }

  @override
  void didChangeMetrics() {
    final newIsMobileLayout = isMobile(BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height));
    if (newIsMobileLayout != isMobileLayout) {
      setState(() {
        isMobileLayout = newIsMobileLayout;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Tarefas associadas ao Evento"),
        leading: const CloseButton(),
        actions: buildEditingActions(() => Navigator.pop(context)),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: formTasks.length, // Number of tasks
        itemBuilder: (BuildContext context, int index) {
          var task = formTasks[index];
          // Pass callbacks for required and completion toggles
          return TaskItem(
            task: task,
            index: index,
            availableEmployees: widget.availableEmployees,
            onTaskUpdate: _handleTaskUpdate,
          );
        },
      ),
    );
  }
}
