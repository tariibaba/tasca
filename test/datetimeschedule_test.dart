import 'package:tasca/models/index.dart';
import 'package:test/test.dart';
import 'package:dart_date/dart_date.dart';

void main() {
  test('returns start date if no repeat', () {
    final startDate = DateTime.now().addDays(2);
    final start = TaskDateTime()..date = startDate;
    final schedule = DateTimeSchedule()..start = start;
    expect(schedule.getNextFutureTime()!.dateTime!.isAtSameMomentAs(startDate),
        true);
  });

  test('repeats until future if repeating', () {
    final now = DateTime.now();
    final startDate = now.subDays(5);
    final start = TaskDateTime()..date = startDate;
    final dayRepeat = DayRepeat()
      ..value = 3
      ..interval = DayRepeatInterval.day;
    final repeat = TaskRepeat()..day = dayRepeat;
    final schedule = DateTimeSchedule()
      ..start = start
      ..repeat = repeat;
    expect(
        schedule
            .getNextFutureTime()!
            .dateTime!
            .startOfDay
            .differenceInDays(now.startOfDay),
        1);
  });
}
