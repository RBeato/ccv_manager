import '../models/library_models/library_user.dart';

class DummyUserData {
  static List<LibraryUser> users = [
    LibraryUser(
      id: '1',
      name: 'João Silva',
      email: "test@test.com",
      cc: "123456789",
      birthday: DateTime(1990, 1, 1),
      address: "Rua 1",
      mobile: "912345678",
      phone: "212345678",
      registrationDate: DateTime(2021, 1, 1),
    ),
    LibraryUser(
      id: '2',
      name: 'Maria Silva',
      email: "test@test.com",
      cc: "123456789",
      birthday: DateTime(1990, 1, 1),
      address: "Rua 1",
      mobile: "912345678",
      phone: "212345678",
      registrationDate: DateTime(2021, 1, 1),
    ),
  ];
}
