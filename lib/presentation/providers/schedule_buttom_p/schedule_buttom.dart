import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_buttom.g.dart';

enum DayOfWeek {monday, tuesday, wednesday, thursday, friday, saturday, sunday}

final List<(DayOfWeek, String)> dayOfWeekOptions = <(DayOfWeek, String)>[
  (DayOfWeek.monday, 'Lu'),
  (DayOfWeek.tuesday, 'Ma'),
  (DayOfWeek.wednesday, 'Mi'),
  (DayOfWeek.thursday, 'Ju'),
  (DayOfWeek.friday, 'Vi'),
  (DayOfWeek.saturday, 'Sá'),
  (DayOfWeek.sunday, 'Do'),
];

@riverpod
class ToggleSchedule extends _$ToggleSchedule {

  final toggleButtonsSelection = DayOfWeek.values.map((DayOfWeek e) => e != DayOfWeek.saturday && e != DayOfWeek.sunday).toList();

  @override
  List<bool> build() => toggleButtonsSelection;
  
  void onPressToggle(int i) {
    state[i] = !state[i];
    ref.notifyListeners();
  }
}