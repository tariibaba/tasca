import 'package:clock/clock.dart';
import 'package:fake_async/fake_async.dart';
import 'package:mockito/mockito.dart';
import 'package:tasca/app_values.dart';
import 'package:tasca/models/app_state.dart';
import 'package:tasca/models/index.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('Notifies for a non-recurring reminder only one time', () {
    final appState = AppState();
    final observer = MockFunction0<void>();
    appState.taskReminderDue.listen((task) {
      observer.call();
    });
    final newTask = Task()..id = Uuid().v4();
    newTask.schedules.add(
        DateTimeSchedule()..start = TaskDateTime.fromDateTime(clock.now()));
    newTask.reminders.add(TaskReminder.whenDue);

    appState.createTask(newTask);
    fakeAsync((async) {
      appState.startTaskReminderDueCheck();
      expect(newTask.isReminderDue(), true);
      async.elapse(const Duration(seconds: 10 + 1));
      verify(observer.call()).called(1);
      expect(newTask.isReminderDue(), false);
      async.elapse(const Duration(seconds: 10 + 1));
      verifyNever(observer.call());
    });
  });

  test('Reminds again after snooze duration', () {
    final appState = AppState();
    final observer = MockFunction0<void>();
    appState.taskReminderDue.listen((task) {
      observer.call();
    });
    final newTask = Task()..id = Uuid().v4();
    newTask.schedules.add(
        DateTimeSchedule()..start = TaskDateTime.fromDateTime(clock.now()));
    newTask.reminders.add(TaskReminder.whenDue);
    appState.createTask(newTask);
    fakeAsync((async) {
      appState.startTaskReminderDueCheck();
      async.elapse(const Duration(seconds: devReminderDueCheckInterval + 1));
      verify(observer.call()).called(1);
      appState.snoozeTaskReminder(newTask.id!);
      async.elapse(const Duration(minutes: snoozeDuration + 1));
      verify(observer.call()).called(1);
      appState.snoozeTaskReminder(newTask.id!);
      async.elapse(const Duration(minutes: snoozeDuration + 1));
      verify(observer.call()).called(1);
    });
  });
}

class MockFunction<R, P1> extends Mock {
  R? call(P1? param);
}

class MockFunction0<R> extends Mock {
  R? call();
}
