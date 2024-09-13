import 'package:ccv_manager/models/employee.dart';
import 'package:ccv_manager/models/cultural_events/form_task.dart';

class GeneralEvent {
  //CONCERT AND DANCE
  String eventId;
  ShowProposalRequest showProposalRequest;
  ProposalAnalysis proposalAnalysis;
  ProposalAuthorization proposalAuthorization;
  Scheduling scheduling;
  AuditoriumTechnicalRider auditoriumTechnicalRider;
  StructureProduction structureProduction;
  OtherMaterialsProduction otherMaterialsProduction;
  LicenseVerification licenseVerification;
  AccommodationAndFood accommodationAndFood;
  PromotionalMaterials promotionalMaterials;
  PressRelease pressRelease;
  PublicityPoster publicityPoster;
  OnlineEventCreation onlineEventCreation;
  PublicityOnSocialMedia publicityOnSocialMedia;
  SendingPostersToParishCouncils sendingPostersToParishCouncils;
  FlyerDistribution flyerDistribution;
  //ART EXHIIBITION

  GeneralEvent({
    required this.eventId,
    //CONCERT AND DANCE
    required this.showProposalRequest,
    required this.proposalAnalysis,
    required this.proposalAuthorization,
    required this.scheduling,
    required this.auditoriumTechnicalRider,
    required this.structureProduction,
    required this.otherMaterialsProduction,
    required this.licenseVerification,
    required this.accommodationAndFood,
    required this.promotionalMaterials,
    required this.pressRelease,
    required this.publicityPoster,
    required this.onlineEventCreation,
    required this.publicityOnSocialMedia,
    required this.sendingPostersToParishCouncils,
    required this.flyerDistribution,
  });
}

class ShowProposalRequest extends FormTask {
  ShowProposalRequest({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Envio/pedido de proposta para espetáculo",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ProposalAnalysis extends FormTask {
  ProposalAnalysis({
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    Employee? assignedEmployee,
    String translation = "Análise de proposta",
  }) : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class ProposalAuthorization extends FormTask {
  ProposalAuthorization(
      {String? description,
      DateTime? startDate,
      DateTime? endDate,
      Employee? assignedEmployee,
      String translation = "Pedido de autorização e cabimentação de despesas"})
      : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class Scheduling extends FormTask {
  Scheduling(
      {String? description,
      DateTime? startDate,
      DateTime? endDate,
      Employee? assignedEmployee,
      String translation = "Calendarização"})
      : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class AuditoriumTechnicalRider extends FormTask {
  AuditoriumTechnicalRider(
      {String? description,
      DateTime? startDate,
      DateTime? endDate,
      Employee? assignedEmployee,
      String translation = "Envio  do rider técnico do auditório"})
      : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class StructureProduction extends FormTask {
  StructureProduction(
      {String? description,
      DateTime? startDate,
      DateTime? endDate,
      Employee? assignedEmployee,
      String translation = "Produção de estruturas"})
      : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class OtherMaterialsProduction extends FormTask {
  OtherMaterialsProduction(
      {String? description,
      DateTime? startDate,
      DateTime? endDate,
      Employee? assignedEmployee,
      String translation = "Produção de outros materiais"})
      : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class LicenseVerification extends FormTask {
  LicenseVerification(
      {String? description,
      DateTime? startDate,
      DateTime? endDate,
      Employee? assignedEmployee,
      String translation = "Verificação de licenças (SPA, IGAC)"})
      : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class AccommodationAndFood extends FormTask {
  AccommodationAndFood(
      {String? description,
      DateTime? startDate,
      DateTime? endDate,
      Employee? assignedEmployee,
      String translation = "Alojamento/Alimentação"})
      : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class PromotionalMaterials extends FormTask {
  PromotionalMaterials(
      {String? description,
      DateTime? startDate,
      DateTime? endDate,
      Employee? assignedEmployee,
      String translation = " Mupis, Tarjas, Folhas de Sala, flyers"})
      : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class PressRelease extends FormTask {
  PressRelease(
      {String? description,
      DateTime? startDate,
      DateTime? endDate,
      Employee? assignedEmployee,
      String translation = "Envio de Newsletter e Nota de Imprensa"})
      : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class PublicityPoster extends FormTask {
  PublicityPoster(
      {String? description,
      DateTime? startDate,
      DateTime? endDate,
      Employee? assignedEmployee,
      String translation = "Cartaz de divulgação"})
      : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class OnlineEventCreation extends FormTask {
  OnlineEventCreation(
      {String? description,
      DateTime? startDate,
      DateTime? endDate,
      Employee? assignedEmployee,
      String translation = "Criação do evento on-line"})
      : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class PublicityOnSocialMedia extends FormTask {
  PublicityOnSocialMedia(
      {String? description,
      DateTime? startDate,
      DateTime? endDate,
      Employee? assignedEmployee,
      String translation = "Divulgação nas redes sociais"})
      : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class SendingPostersToParishCouncils extends FormTask {
  SendingPostersToParishCouncils(
      {String? description,
      DateTime? startDate,
      DateTime? endDate,
      Employee? assignedEmployee,
      String translation = "Envio de cartazes para juntas de freguesia"})
      : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}

class FlyerDistribution extends FormTask {
  FlyerDistribution(
      {String? description,
      DateTime? startDate,
      DateTime? endDate,
      Employee? assignedEmployee,
      String translation = "Colocação de cartazes/distribuição de flyer's"})
      : super(
          description: description,
          startDate: startDate,
          endDate: endDate,
          assignedEmployee: assignedEmployee,
          titleTranslation: translation,
        );
}
