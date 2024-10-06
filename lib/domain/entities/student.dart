

import 'package:csv/csv.dart';

class Student {

  late String id;
  late String userId;
  late String controlNo;
  late String name;

  Student({ 
    required this.controlNo, 
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'controlNo' : controlNo,
      'name'      : name,
    };
  }

  Student.fromMap(Map<String, dynamic> map) {
      id        = map['id'];
      userId    = map['userId'];
      controlNo = map['controlNo'];
      name      = map['name'];
  }

  factory Student.fromCsvRow(List<dynamic> csvRow) 
    => Student(
      controlNo: csvRow[0].toString(), 
      name: csvRow[1].toString(),
    );
  
  static List<Student> fromCsvTable(List<List<dynamic>> csvTable) {
    return csvTable.skip(1).map((csvRow) 
      => Student.fromCsvRow(csvRow)).toList();
  }

  static List<Student> fromCsvString(String csvString) =>
      Student.fromCsvTable(const CsvToListConverter().convert(csvString));
}