import 'package:test/test.dart';
import 'package:order_incident/order_incident.dart';
void main() {
  test('INC-2: результат совпадает с сохранением', () {
    final repo = OrderRepository(capacity: 1);
    final service = OrderService(repo);
    expect(service.placeOrder(Order('B-1', 'Тест', [Item('Книга', 100, 1, NoDiscount())])).success, isTrue);
    expect(repo.find('B-1'), isNotNull);
    expect(service.placeOrder(Order('B-2', 'Тест', [Item('Книга', 100, 1, NoDiscount())])).success, isFalse);
    expect(repo.find('B-2'), isNull);
  });
}
