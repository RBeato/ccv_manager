import 'package:ccv_manager/constants/constants.dart';

import '../models/library_models/book_request.dart';
import '../models/devil_costumes/devil_costume.dart';
import '../models/devil_costumes/devil_costume_request.dart';

class DummyDevilCostumeData {
  static List<DevilCostumeRequest> reqCostumes = [
    DevilCostumeRequest(
      name: "José Manuel",
      address: "Rua das Freiras",
      phoneNumber: 999999999,
      status: RequisitionStatus.toBeDelivered,
      costumes: [DevilCostume(size: Constants.sizeM, quantity: 1, id: 1)],
      devilCostumeRequestType: DevilCustomUsage.used,
      requestDate: DateTime.now(),
      deliveryDateLimit: DateTime.now().add(const Duration(days: 15)),
      deliveryDate: null,
    ),
    DevilCostumeRequest(
      name: "Francisco",
      address: "Rua do Calvário",
      phoneNumber: 999999999,
      status: RequisitionStatus.delivered,
      costumes: [DevilCostume(size: Constants.sizeXxl, quantity: 1, id: 1)],
      devilCostumeRequestType: DevilCustomUsage.used,
      requestDate: DateTime.now().subtract(const Duration(days: 5)),
      deliveryDateLimit: DateTime.now().add(const Duration(days: 10)),
      deliveryDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    DevilCostumeRequest(
      name: "Pedro",
      address: "Rua do Carvalhal",
      phoneNumber: 999999999,
      status: RequisitionStatus.delivered,
      costumes: [
        DevilCostume(size: Constants.sizeM, quantity: 1, id: 1),
        DevilCostume(size: Constants.sizeXxl, quantity: 1, id: 2)
      ],
      devilCostumeRequestType: DevilCustomUsage.used,
      requestDate: DateTime.now().subtract(const Duration(days: 5)),
      deliveryDateLimit: DateTime.now().add(const Duration(days: 10)),
      deliveryDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];
}
