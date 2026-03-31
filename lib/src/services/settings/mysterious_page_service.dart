// Управляет скрытой логикой открытия таинственной страницы.
class MysteriousPageService {
  int _counter = 0;

  bool get shouldOpenMysteriousPage => _counter == 7;

  void registerResetAttempt() {
    _counter++;
  }

  void resetCounter() {
    _counter = 0;
  }
}