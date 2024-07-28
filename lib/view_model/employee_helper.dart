import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiers_practice_app/model/employee.dart';

class EmployeeHelper {
  static Future<List<Employee>> getEmployees() async {
    var prefs = await SharedPreferences.getInstance();
    List<Employee> employeeList = [];
    var keys = prefs.getKeys();

    for (var key in keys) {
      var employeeData = prefs.getString(key) ?? "";
      if (employeeData.isNotEmpty) {
        Employee employee = Employee.fromJsonString(employeeData);
        employeeList.add(employee);
      }
    }
    return employeeList;
  }

  static Future<void> addEmployee(Employee employee) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(employee.id, employee.toJsonString());
  }

  static Future<void> removeEmployee(String id) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(id);
  }

  static Future<void> updateEmployee(Employee employee) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(employee.id, employee.toJsonString());
  }
}
