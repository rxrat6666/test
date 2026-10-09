abstract class DiscountStrategy {
  double getDiscount(double price);
}
class NoDiscount implements DiscountStrategy {
  @override
  double getDiscount(double price) => 0;
}
class PercentDiscount implements DiscountStrategy {
  final double percent;
  PercentDiscount(this.percent);
  @override
  double getDiscount(double price) {
    if (percent < 0 || percent > 100) {
      throw ArgumentError('Процент скидки должен быть от 0 до 100');
    }
    return price * percent / 100;
  }
}
class Item {
  final String name;
  final double price;
  final int quantity;
  final DiscountStrategy discount;
  Item(this.name, this.price, this.quantity, this.discount);
}
class Order {
  final String id;
  final String customer;
  final List<Item> items;
  Order(this.id, this.customer, this.items);
}
