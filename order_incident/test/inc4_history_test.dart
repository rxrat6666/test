import 'package:test/test.dart';
import 'package:order_incident/order_incident.dart';
void main() {
  test('INC-4: ожидание ответа', () async {
    final history = await loadOrderHistory('Тест');
    expect(history, hasLength(3));
    expect(history.first, 'Заказ A-1');
  });
}
