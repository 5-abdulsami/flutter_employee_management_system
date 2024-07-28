import 'package:flutter/material.dart';
import 'package:tiers_practice_app/model/employee.dart';
import 'package:tiers_practice_app/view_model/employee_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Employee> employeeList = [];
  var nameController = TextEditingController();
  var roleController = TextEditingController();
  var salaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    List<Employee> employees = await EmployeeHelper.getEmployees();
    setState(() {
      employeeList = employees;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Employee List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              addEmployeeDialog();
            },
            icon: const Icon(
              Icons.add_circle,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: employeeList.isEmpty
          ? const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Icon(
                    Icons.list_alt,
                    size: 200,
                    color: Colors.grey,
                  ),
                  Text(
                    'The List is Empty',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 126, 126, 126),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: employeeList.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 13, vertical: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'All Employees',
                            style: TextStyle(
                                fontSize: 27, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            leading: const Icon(Icons.person),
                            title: Text(
                              "${employeeList[index].name} - ${employeeList[index].role}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("\$${employeeList[index].salary}"),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      editEmployeeDialog(employeeList[index]);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deleteEmployeeAlert(
                                          employeeList[index].id);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      leading: const Icon(Icons.person),
                      title: Text(
                        "${employeeList[index].name} - ${employeeList[index].role}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("\$${employeeList[index].salary}"),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                editEmployeeDialog(employeeList[index]);
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.purple,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteEmployeeAlert(employeeList[index].id);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> addEmployeeDialog() async {
    nameController.clear();
    roleController.clear();
    salaryController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text('Add Employee')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: roleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Role',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: salaryController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Salary',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color.fromARGB(255, 109, 109, 109)),
              ),
            ),
            TextButton(
              onPressed: () {
                Employee employee = Employee(
                  id: DateTime.now().toString(),
                  name: nameController.text,
                  role: roleController.text,
                  salary: salaryController.text,
                );
                EmployeeHelper.addEmployee(employee).then((_) {
                  setState(() {
                    employeeList.add(employee);
                  });
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Add',
                style: TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> editEmployeeDialog(Employee employee) async {
    nameController.text = employee.name;
    roleController.text = employee.role;
    salaryController.text = employee.salary;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text('Edit Employee')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: roleController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Role',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: salaryController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Salary',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color.fromARGB(255, 99, 99, 99)),
              ),
            ),
            TextButton(
              onPressed: () {
                Employee updatedEmployee = Employee(
                  id: employee.id,
                  name: nameController.text,
                  role: roleController.text,
                  salary: salaryController.text,
                );
                EmployeeHelper.updateEmployee(updatedEmployee).then((_) {
                  setState(() {
                    int index =
                        employeeList.indexWhere((e) => e.id == employee.id);
                    if (index != -1) {
                      employeeList[index] = updatedEmployee;
                    }
                  });
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Update',
                style: TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteEmployeeAlert(String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Delete Employee')),
            content: const Text(
              'Are you sure you want to delete this employee?',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Color.fromARGB(255, 97, 97, 97)),
                  )),
              TextButton(
                  onPressed: () {
                    EmployeeHelper.removeEmployee(id);
                    setState(() {
                      employeeList.removeWhere((employee) => employee.id == id);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )),
            ],
          );
        });
  }
}
