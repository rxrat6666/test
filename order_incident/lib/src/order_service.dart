import 'models.dart';
import 'pricing.dart';
import 'app_logger.dart';
class StorageException implements Exception {
  final String message;
  StorageException(this.message);
  @override
  String toString() => 'StorageException: $message';
}
class OrderRepository {
  final Map<String, Order> _storage = {};
  final int capacity;
  OrderRepository({this.capacity = 3});
  void save(Order order) {
    if (_storage.length >= capacity && !_storage.containsKey(order.id)) {
      throw StorageException('Хранилище заполнено (лимит $capacity)');
    }
    _storage[order.id] = order;
  }
  Order? find(String id) => _storage[id];
}
class OrderResult {
  final bool success;
  final double total;
  final double shipping;
  OrderResult(this.success, this.total, this.shipping);
}
class OrderService {
  final OrderRepository repository;
  OrderService(this.repository);
  OrderResult placeOrder(Order order) {
    final total = calculateTotal(order.items);
    final shipping = shippingCost(total);
    log.info('INC-2: начинаем сохранение заказа ${order.id}, сумма=$total');
    try {
      repository.save(order);
      log.info('INC-2: заказ ${order.id} успешно сохранён');
      return OrderResult(true, total, shipping);
    } catch (e, stackTrace) {
      log.severe('INC-2: не удалось сохранить заказ ${order.id}', e, stackTrace);
      return OrderResult(false, total, shipping);
    }
  }
}
