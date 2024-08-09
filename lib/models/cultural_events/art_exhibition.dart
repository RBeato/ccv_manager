import '../employee.dart';
import 'form_task.dart';

class ArtExhibition {
  String eventId;
  //ExhibitionPreparation
  ArtistMeetings artistMeetings;
  RoomConditionSending roomConditionSending;
  ArtworkSelection artworkSelection;
  ExhibitionLayoutDefinition exhibitionLayoutDefinition;
  FinalArtListWithInsuranceValues finalArtListWithInsuranceValues;
  RoomConditionProduction roomConditionProduction;
// TransportAndInsurance
  TransportInsuranceBudget transportInsuranceBudget;
  ConcentrationTransportBudget concentrationTransportBudget;
  DispersionTransportBudget dispersionTransportBudget;
// PreviousExhibitionDismantling
  ArtworkConditionChecking artworkConditionChecking;
  ArtworkPackaging artworkPackaging;
  ExhibitionSpaceRepairAndPainting exhibitionSpaceRepairAndPainting;
//ArtworkTransport
  PackagingCollectionTransportAndDelivery
      packagingCollectionTransportAndDelivery;
  PreviousExhibitionArtworkReturn previousExhibitionArtworkReturn;
//MaterialProduction
  ArtStructureProduction structureProduction;
  FrameProduction frameProduction;
  OtherMaterialProduction otherMaterialProduction;
// ArtistStay;
  ArtistAccommodationAndFood accommodationAndFood;
// PromotionalMaterialProduction
  AdvertisingDisplays advertisingDisplays;
  RoomLeaflets roomLeaflets;
  WallText wallText;
//NewsletterAndPressNoteSending
  ExhibitionSetup exhibitionSetup;
  ArtworkUnpackingAndConditionChecking artworkUnpackingAndConditionChecking;
  ArtworkDistributionInExhibitionSpace artworkDistributionInExhibitionSpace;
  ExhibitionAssembly exhibitionAssembly;
  ExhibitionLighting exhibitionLighting;
  WallTextAndTableProductionAndApplication
      wallTextAndTableProductionAndApplication;
// Opening opening;
  Opening opening;
// Register and Verification
  TemperatureAndHumidityCheckingAndRecording
      temperatureAndHumidityCheckingAndRecording;
  ArtworkConservationStatusVerification artworkConservationStatusVerification;
  MonthlyVisitorMapSubmission monthlyVisitorMapSubmission;
  VisitorSatisfactionSurveyProvision visitorSatisfactionSurveyProvision;
//Catalog
  ExhibitionPhotographicRecording exhibitionPhotographicRecording;
  DesignerBudgetRequest designerBudgetRequest;
  ProductionBudgetRequest productionBudgetRequest;
  CatalogReview catalogReview;
  CatalogProductionPrinting catalogProductionPrinting;
//ExhibitionEnd
  TotalVisitorCount totalVisitorCount;
//Dismantling
  ExhibitionDismantling exhibitionDismantling;
  ArtworkConservationAndPackagingVerification
      artworkConservationAndPackagingVerification;
  ArtworkTransportAndReturn artworkTransportAndReturn;

  ArtExhibition({
    required this.eventId,
    required this.artistMeetings,
    required this.roomConditionSending,
    required this.artworkSelection,
    required this.exhibitionLayoutDefinition,
    required this.finalArtListWithInsuranceValues,
    required this.roomConditionProduction,
    required this.transportInsuranceBudget,
    required this.concentrationTransportBudget,
    required this.dispersionTransportBudget,
    required this.artworkConditionChecking,
    required this.artworkPackaging,
    required this.exhibitionSpaceRepairAndPainting,
    required this.packagingCollectionTransportAndDelivery,
    required this.previousExhibitionArtworkReturn,
    required this.structureProduction,
    required this.frameProduction,
    required this.otherMaterialProduction,
    required this.accommodationAndFood,
    required this.advertisingDisplays,
    required this.roomLeaflets,
    required this.wallText,
    required this.exhibitionSetup,
    required this.artworkUnpackingAndConditionChecking,
    required this.artworkDistributionInExhibitionSpace,
    required this.exhibitionAssembly,
    required this.exhibitionLighting,
    required this.wallTextAndTableProductionAndApplication,
    required this.opening,
    required this.temperatureAndHumidityCheckingAndRecording,
    required this.artworkConservationStatusVerification,
    required this.monthlyVisitorMapSubmission,
    required this.visitorSatisfactionSurveyProvision,
    required this.exhibitionPhotographicRecording,
    required this.designerBudgetRequest,
    required this.productionBudgetRequest,
    required this.catalogReview,
    required this.catalogProductionPrinting,
    required this.totalVisitorCount,
    required this.exhibitionDismantling,
    required this.artworkConservationAndPackagingVerification,
    required this.artworkTransportAndReturn,
  });
}

class ArtistMeetings extends FormTask {
  ArtistMeetings({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Reuniões com o Artista",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class RoomConditionSending extends FormTask {
  RoomConditionSending({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Envio das condições da sala",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ArtworkSelection extends FormTask {
  ArtworkSelection({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Seleção de Obras",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ExhibitionLayoutDefinition extends FormTask {
  ExhibitionLayoutDefinition({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Definição do Layout Exposição",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class FinalArtListWithInsuranceValues extends FormTask {
  FinalArtListWithInsuranceValues({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Lista final de Obras c/ valores de seguro",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class RoomConditionProduction extends FormTask {
  RoomConditionProduction({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Produção dos Condições da sala",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class TransportInsuranceBudget extends FormTask {
  TransportInsuranceBudget({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Orçamento de Seguros de transporte e permanência",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ConcentrationTransportBudget extends FormTask {
  ConcentrationTransportBudget({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Orçamento - transporte de concentração",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class DispersionTransportBudget extends FormTask {
  DispersionTransportBudget({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Orçamento - transporte de dispersão",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ArtworkConditionChecking extends FormTask {
  ArtworkConditionChecking({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Verificação do estado das obras",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ArtworkPackaging extends FormTask {
  ArtworkPackaging({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Embalagem das obras",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ExhibitionSpaceRepairAndPainting extends FormTask {
  ExhibitionSpaceRepairAndPainting({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Reparação e pintura dos espaços expositivos",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class PackagingCollectionTransportAndDelivery extends FormTask {
  PackagingCollectionTransportAndDelivery({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Embalagem, recolha, transporte e entrega",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class PreviousExhibitionArtworkReturn extends FormTask {
  PreviousExhibitionArtworkReturn({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Devolução das obras da exposição anterior",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ArtStructureProduction extends FormTask {
  ArtStructureProduction({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Produção de estruturas",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class FrameProduction extends FormTask {
  FrameProduction({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Produção de molduras",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class OtherMaterialProduction extends FormTask {
  OtherMaterialProduction({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Produção de outros materiais",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ExhibitionAssembly extends FormTask {
  ExhibitionAssembly({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Montagem de exposição",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ExhibitionLighting extends FormTask {
  ExhibitionLighting({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Iluminação da exposição",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class WallTextAndTableProductionAndApplication extends FormTask {
  WallTextAndTableProductionAndApplication({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Produção e aplicação de textos de parede e tabelas",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class Opening extends FormTask {
  Opening({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Inauguração",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class TemperatureAndHumidityCheckingAndRecording extends FormTask {
  TemperatureAndHumidityCheckingAndRecording({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Verificação e registo de temperaturas e humidades",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ArtworkConservationStatusVerification extends FormTask {
  ArtworkConservationStatusVerification({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Verificação do estado de conservação das obras",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class MonthlyVisitorMapSubmission extends FormTask {
  MonthlyVisitorMapSubmission({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Envio do mapa mensal de visitantes",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class VisitorSatisfactionSurveyProvision extends FormTask {
  VisitorSatisfactionSurveyProvision({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation =
        "Disponibilização de inquéritos de satisfação de Visitantes",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ExhibitionPhotographicRecording extends FormTask {
  ExhibitionPhotographicRecording({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Registo fotografico da exposição",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class DesignerBudgetRequest extends FormTask {
  DesignerBudgetRequest({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Pedido de orçamento designer",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ProductionBudgetRequest extends FormTask {
  ProductionBudgetRequest({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Pedido de orçamento produção",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class CatalogReview extends FormTask {
  CatalogReview({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Revisão do Catalogo",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class CatalogProductionPrinting extends FormTask {
  CatalogProductionPrinting({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Produção/Impressão Catalogo",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class TotalVisitorCount extends FormTask {
  TotalVisitorCount({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Contagem do número total de visitantes",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ExhibitionDismantling extends FormTask {
  ExhibitionDismantling({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Desmontagem da exposição",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ArtworkConservationAndPackagingVerification extends FormTask {
  ArtworkConservationAndPackagingVerification({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation =
        "Verificação do estado de conservação e emblagem das obras",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ArtworkTransportAndReturn extends FormTask {
  ArtworkTransportAndReturn({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Transporte e devolução das obras",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ArtistAccommodationAndFood extends FormTask {
  ArtistAccommodationAndFood({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Alojamento/Alimentação",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class AdvertisingDisplays extends FormTask {
  AdvertisingDisplays({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Mupis, Tarjas",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class RoomLeaflets extends FormTask {
  RoomLeaflets({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Folhas de Sala",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class WallText extends FormTask {
  WallText({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Texto de Parede",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ExhibitionSetup extends FormTask {
  ExhibitionSetup({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Montagem de exposição",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ArtworkUnpackingAndConditionChecking extends FormTask {
  ArtworkUnpackingAndConditionChecking({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Desembalagem e verificação do estado das obras",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ArtworkDistributionInExhibitionSpace extends FormTask {
  ArtworkDistributionInExhibitionSpace({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Distribuição das obras no espaço expositivo",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}
