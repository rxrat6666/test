import 'package:test/test.dart';
import 'package:order_incident/order_incident.dart';
void main() {
  test('INC-5: граничные значения', () {
    expect(shippingCost(4999), 500.0);
    expect(shippingCost(5000), 0.0);
    expect(shippingCost(5001), 0.0);
  });
}
