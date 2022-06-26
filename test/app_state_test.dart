import 'package:clock/clock.dart';
import 'package:fake_async/fake_async.dart';
import 'package:mockito/mockito.dart';
import 'package:tasca/models/app_state.dart';
import 'package:tasca/models/index.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('Notifies for a non-recurring reminder only one time', () {
    final appState = AppState();
    final observer = MockFunction<void, Task>();
    appState.taskReminderDue.listen(observer.call);
    final newTask = Task()..id = Uuid().v4();
    newTask.schedules.add(
        DateTimeSchedule()..start = TaskDateTime.fromDateTime(clock.now()));
    newTask.reminders.add(TaskReminder.whenDue);

    appState.createTask(newTask);
    fakeAsync((async) {
      appState.startTaskReminderDueCheck();
      expect(newTask.isReminderDue(), true);
      async.elapse(const Duration(seconds: 60));
      verify(observer.call(any)).called(1);
      expect(newTask.isReminderDue(), false);
      async.elapse(const Duration(seconds: 60));
      verify(observer.call(any)).called(1);
    });
  });
}

class MockFunction<R, P1> extends Mock {
  R? call(P1? param);
}
