import 'app_logger.dart';
Future<List<String>> fetchOrderIds(String customer) async {
  await Future.delayed(const Duration(milliseconds: 100));
  return ['A-1', 'A-2', 'A-3'];
}
Future<List<String>> loadOrderHistory(String customer) async {
  log.info('INC-4: начали загружать историю');
  final history = <String>[];
  final ids = await fetchOrderIds(customer);
  log.info('INC-4: получили идентификаторы, количество=${ids.length}');
  for (final id in ids) {
    history.add('Заказ $id');
  }
  log.info('INC-4: возвращаем историю, количество=${history.length}');
  return history;
}
