

import 'package:csv/csv.dart';

class StudentEntity {

  late String id;
  late String userId;
  late String controlNo;
  late String name;

  StudentEntity({ 
    required this.controlNo, 
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'controlNo' : controlNo,
      'name'      : name,
    };
  }

  StudentEntity.fromMap(Map<String, dynamic> map) {
      id        = map['id'];
      userId    = map['userId'];
      controlNo = map['controlNo'];
      name      = map['name'];
  }

  factory StudentEntity.fromCsvRow(List<dynamic> csvRow) 
    => StudentEntity(
      controlNo: csvRow[0].toString(), 
      name: csvRow[1].toString(),
    );
  
  static List<StudentEntity> fromCsvTable(List<List<dynamic>> csvTable) {
    return csvTable.skip(1).map((csvRow) 
      => StudentEntity.fromCsvRow(csvRow)).toList();
  }

  static List<StudentEntity> fromCsvString(String csvString) =>
      StudentEntity.fromCsvTable(const CsvToListConverter().convert(csvString));
}