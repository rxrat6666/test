import 'package:order_incident/order_incident.dart';
int passed = 0;
int totalChecks = 0;
void check(String name, Object? expected, Object? actual) {
  totalChecks++;
  if (expected == actual) passed++;
  print('${expected == actual ? "[OK]" : "[ОШИБКА]"} $name: ожидалось $expected, получено $actual');
}
Future<void> main() async {
  setupLogging();
  log.info('=== Запуск сценария рабочего дня ===');
  final a = Order('A-1', 'Тестовый клиент', [Item('Ноутбук', 1000, 3, PercentDiscount(10))]);
  check('INC-1: сумма', 2700.0, OrderService(OrderRepository()).placeOrder(a).total);
  final repo = OrderRepository(capacity: 3);
  final service = OrderService(repo);
  OrderResult? last;
  for (var i = 1; i <= 4; i++) {
    last = service.placeOrder(Order('B-$i', 'Тестовый клиент', [Item('Книга', 100, 1, NoDiscount())]));
  }
  check('INC-2: success соответствует сохранению', false, last!.success);
  final writer = ReportWriter();
  try { generateReport(writer, ['A-1', '', 'A-3']); } catch (_) {}
  var secondOk = true;
  try { generateReport(writer, ['A-1', 'A-3']); } catch (_) { secondOk = false; }
  check('INC-3: второй отчёт', true, secondOk);
  check('INC-4: история', 3, (await loadOrderHistory('Тестовый клиент')).length);
  check('INC-5: доставка', 0.0, shippingCost(5000));
  print('Итого: $passed из $totalChecks проверок пройдено');
}
