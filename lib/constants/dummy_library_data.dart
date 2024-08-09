import '../models/library_models/book.dart';
import '../models/library_models/book_request.dart';

class DummyLibraryData {
  static List<BookRequest> reqBooks = [
    BookRequest(
      id: '1',
      userId: '1',
      userName: 'João Silva',
      books: [
        Book(
          title: 'Harry Potter e a Pedra Filosofal',
          author: 'JK Rowling',
          edition: '1',
        )
      ],
      status: RequisitionStatus.delivered,
      requestDate: DateTime.now(),
      deliveryDateLimit: DateTime.now().add(const Duration(days: 15)),
      deliveryDate: null,
      renewed: null,
      observations: "Livro em bom estado",
    ),
    BookRequest(
      id: '2',
      userId: '1',
      userName: 'Manuel António',
      books: [
        Book(
          title: 'Harry Potter e a Câmara Secreta',
          author: 'JK Rowling',
          edition: '1',
        ),
        Book(
          title: 'Harry Potter e o Prisioneiro de Azkaban',
          author: 'JK Rowling',
          edition: '2',
        )
      ],
      status: RequisitionStatus.toBeDelivered,
      requestDate: DateTime.now().subtract(const Duration(days: 5)),
      deliveryDateLimit: DateTime.now().add(const Duration(days: 10)),
      deliveryDate: DateTime.now().subtract(const Duration(days: 1)),
      renewed: null,
      observations: "Livro em mau estado",
    ),
    BookRequest(
      id: '3',
      userId: '1',
      userName: 'Joana Silva',
      books: [
        Book(
          title: 'Terra dos Diabos',
          author: 'CMV',
          edition: '1',
        )
      ],
      status: RequisitionStatus.toBeDelivered,
      requestDate: DateTime.now().subtract(const Duration(days: 5)),
      deliveryDateLimit: DateTime.now().add(const Duration(days: 10)),
      deliveryDate: DateTime.now().subtract(const Duration(days: 1)),
      renewed: true,
      observations: "Livro em mau estado",
    ),
  ];
}
