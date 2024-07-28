import 'dart:convert';

class Employee {
  final String id;
  final String name;
  final String role;
  final String salary;

  Employee(
      {required this.id,
      required this.name,
      required this.role,
      required this.salary});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'role': role, 'salary': salary};
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      salary: json['salary'],
    );
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory Employee.fromJsonString(String jsonString) {
    return Employee.fromJson(jsonDecode(jsonString));
  }
}
