import 'package:test/test.dart';
import 'package:order_incident/order_incident.dart';
void main() {
  test('INC-3: закрытие ресурса после ошибки', () {
    final writer = ReportWriter();
    expect(() => generateReport(writer, ['Строка', '']), throwsArgumentError);
    expect(writer.isOpen, isFalse);
    expect(() => generateReport(writer, ['Строка']), returnsNormally);
    expect(writer.isOpen, isFalse);
  });
}
