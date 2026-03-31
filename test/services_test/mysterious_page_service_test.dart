import 'package:musicplayer/src/services/settings/mysterious_page_service.dart';
import 'package:test/test.dart';

void main() {
  group('MysteriousPageService', () {
    late MysteriousPageService service;

    setUp(() {
      service = MysteriousPageService();
    });

    test('Opens page on seventh reset attempt', () {
      for (var i = 0; i < 6; i++) {
        service.registerResetAttempt();
      }

      expect(service.shouldOpenMysteriousPage, false);

      service.registerResetAttempt();

      expect(service.shouldOpenMysteriousPage, true);
    });

    test('resetCounter clears progress', () {
      for (var i = 0; i < 7; i++) {
        service.registerResetAttempt();
      }

      expect(service.shouldOpenMysteriousPage, true);

      service.resetCounter();

      expect(service.shouldOpenMysteriousPage, false);
    });
  });
}