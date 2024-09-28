

import 'package:csv/csv.dart';

class StudentEntity {

  late String id;
  late String controlNo;
  late String name;
  late String plan;

  StudentEntity({ 
    required this.controlNo, 
    required this.name,
    required this.plan,
  });

  Map<String, dynamic> toMap() {
    return {
      'controlNo' : controlNo,
      'name'      : name,
      'plan'      : plan,
    };
  }

  factory StudentEntity.fromMap(Map<String, dynamic> map) 
    => StudentEntity(
      controlNo: map['controlNo'],
      name: map['name'],
      plan: map['votes'],
    );

  factory StudentEntity.fromCsvRow(List<dynamic> csvRow) 
    => StudentEntity(
      controlNo: csvRow[0].toString(), 
      name: csvRow[1].toString(),
      plan: csvRow[2].toString(),
    );
  
  static List<StudentEntity> fromCsvTable(List<List<dynamic>> csvTable) {
    return csvTable.skip(1).map((csvRow) 
      => StudentEntity.fromCsvRow(csvRow)).toList();
  }

  static List<StudentEntity> fromCsvString(String csvString) =>
      StudentEntity.fromCsvTable(const CsvToListConverter().convert(csvString));
}