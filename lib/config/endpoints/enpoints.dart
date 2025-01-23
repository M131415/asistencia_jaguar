class Enpoints {
  static const String baseApiURL     = 'http://10.0.2.2:8081';
  static const String refreshToken   = "$baseApiURL/api/token/refresh/";
  static const String login          = "$baseApiURL/login/";
  static const String logout         = "$baseApiURL/logout/";
  static const String careersAPI     = "$baseApiURL/users/careers/";
  static const String usersAPI       = "$baseApiURL/users/users/";
  static const String schoolRoomsAPI = "$baseApiURL/courses/school_rooms/";
  static const String subjectsAPI    = "$baseApiURL/courses/subjects/";
  static const String departments    = "$baseApiURL/courses/departments/";
  static const String periodsAPI     = "$baseApiURL/courses/periods/";
  static const String schedulesAPI   = "$baseApiURL/courses/schedules/";
  static const String groupsAPI      = "$baseApiURL/courses/groups/";
  static const String coursesAPI     = "$baseApiURL/courses/courses/";
  static const String attendanceAPI  = "$baseApiURL/attendance/attendances/";
  static const String enrollmentsAPI = "$baseApiURL/attendance/enrollments/";
}
