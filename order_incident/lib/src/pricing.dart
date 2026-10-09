import 'models.dart';
import 'app_logger.dart';
double calculateTotal(List<Item> items) {
  double total = 0;
  for (final item in items) {
    final discount = item.discount.getDiscount(item.price);
    final contribution = (item.price - discount) * item.quantity;
    log.fine('INC-1: позиция=${item.name}, цена=${item.price}, '
        'количество=${item.quantity}, скидка=$discount, вклад=$contribution');
    total += contribution;
  }
  log.info('INC-1: итоговая сумма=$total');
  return total;
}
/// Заказы на сумму от 5000 включительно доставляются бесплатно.
const double freeShippingThreshold = 5000;
double shippingCost(double total) {
  log.fine('INC-5: сумма=$total, порог=$freeShippingThreshold');
  if (total >= freeShippingThreshold) {
    log.info('INC-5: доставка бесплатная для суммы $total');
    return 0;
  }
  log.info('INC-5: доставка платная (500) для суммы $total');
  return 500;
}
