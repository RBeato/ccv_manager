import 'dart:convert';

class Auditorium {
  List<AuditoriumSeat>? register;
  Auditorium({
    required this.register,
  });

  Map<String, dynamic> toMap() {
    return {
      'register': register?.map((x) => x.toMap()).toList() ?? [],
    };
  }

  factory Auditorium.fromMap(Map<String, dynamic> map) {
    return Auditorium(
      register: List<AuditoriumSeat>.from(
          map['register'].map((x) => AuditoriumSeat.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Auditorium.fromJson(String source) =>
      Auditorium.fromMap(json.decode(source));

  @override
  String toString() => 'Auditorium(register: $register)';
}

class AuditoriumSeat {
  String seat;
  Attendant attendant;

  AuditoriumSeat({
    required this.seat,
    required this.attendant,
  });

  Map<String, dynamic> toMap() {
    return {
      'seat': seat,
      'attendant': attendant.toString(),
    };
  }

  factory AuditoriumSeat.fromMap(Map<String, dynamic> map) {
    return AuditoriumSeat(
        seat: map['seat'] ?? '',
        attendant: Attendant.values
            .firstWhere((v) => v.toString() == map['attendant']));
  }

  String toJson() => json.encode(toMap());

  factory AuditoriumSeat.fromJson(String source) =>
      AuditoriumSeat.fromMap(json.decode(source));

  @override
  String toString() => 'AuditoriumSeat(seat: $seat, attendant: $attendant)';
}

enum Attendant { regular, junior, senior }
