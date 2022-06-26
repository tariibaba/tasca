import 'package:tasca/models/index.dart';
import 'package:test/test.dart';
import 'package:dart_date/dart_date.dart';
import 'package:clock/clock.dart';

void main() {
  test('Task getNextRemindTime() method', () {
    final task = Task();
    final futureTime = DateTime.now().addMinutes(20);
    task.schedules.add(
        DateTimeSchedule()..start = (TaskDateTime.fromDateTime(futureTime)));
    task.reminders.add(TaskReminder.whenDue);
    expect(task.getNextRemindTime()!.isSameMinute(futureTime), true);
  });

  test('Task isReminderDue() method', () {
    final task = Task();
    final futureTime = DateTime.now().addMinutes(20);
    task.schedules.add(
        DateTimeSchedule()..start = (TaskDateTime.fromDateTime(futureTime)));
    task.reminders.add(TaskReminder.whenDue);
    expect(task.isReminderDue(), false);
    withClock(Clock.fixed(futureTime), () {
      expect(task.isReminderDue(), true);
    });
  });
}
