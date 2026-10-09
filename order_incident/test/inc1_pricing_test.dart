import 'package:test/test.dart';
import 'package:order_incident/order_incident.dart';
void main() {
  test('INC-1: количество товара', () {
    expect(calculateTotal([Item('Ноутбук', 1000, 3, PercentDiscount(10))]), 2700.0);
    expect(calculateTotal([Item('Ноутбук', 1000, 1, PercentDiscount(10))]), 900.0);
  });
}
