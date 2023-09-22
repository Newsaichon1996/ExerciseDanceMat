import 'dart:convert';

class User {
  String name;
  String lastName;
  int age;
  String gender;
  // String dob;
  // String hn;
  // String password;
  // String note;
  // int maxHr;
  // int minHr;
  // int duration;
  User({
    required this.name,
    required this.lastName,
    required this.age,
    required this.gender,
    // required this.dob,
    // required this.hn,
    // required this.password,
    // required this.note,
    // required this.maxHr,
    // required this.minHr,
    // required this.duration,
  });

  User copyWith({
    String? name,
    String? lastName,
    int? age,
    String? gender,
    // String? dob,
    // String? hn,
    // String? password,
    // String? note,
    // int? maxHr,
    // int? minHr,
    // int? duration,
  }) {
    return User(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      // dob: dob ?? this.dob,
      // hn: hn ?? this.hn,
      // password: password ?? this.password,
      // note: note ?? this.note,
      // maxHr: maxHr ?? this.maxHr,
      // minHr: minHr ?? this.minHr,
      // duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      // 'dob': dob,
      // 'hn': hn,
      // 'password': password,
      // 'note': note,
      // 'maxHr': maxHr,
      // 'minHr': minHr,
      // 'duration': duration,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      lastName: map['lastName'] ?? '',
      age: map['age']?.toInt() ?? 0,
      gender: map['gender'] ?? '',
      // dob: map['dob'] ?? '',
      // hn: map['hn'] ?? '',
      // password: map['password'] ?? '',
      // note: map['note'] ?? '',
      // maxHr: map['maxHr']?.toInt() ?? 0,
      // minHr: map['minHr']?.toInt() ?? 0,
      // duration: map['duration']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, lastName: $lastName, age: $age, gender: $gender)';
    //dob: $dob, hn: $hn, password: $password, note: $note, maxHr: $maxHr, minHr: $minHr, duration: $duration
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.lastName == lastName &&
        other.age == age &&
        other.gender == gender; 
        //&&
        //other.dob == dob &&
        // other.hn == hn &&
        // other.password == password &&
        // other.note == note &&
        // other.maxHr == maxHr &&
        // other.minHr == minHr &&
        // other.duration == duration;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        lastName.hashCode ^
        age.hashCode ^
        gender.hashCode;
        //^
        // dob.hashCode ^
        // hn.hashCode ^
        // password.hashCode ^
        // note.hashCode ^
        // maxHr.hashCode ^
        // minHr.hashCode ^
        // duration.hashCode;
  }
}
