import 'dart:async';
import 'package:order_incident/order_incident.dart';

/// Учебная демонстрация: специально неисправная версия и рабочая версия.
/// Боевые функции в lib/src/ не меняются.
typedef Demo = Future<Object?> Function(bool fixed);

Future<Object?> inc1(bool fixed) async {
  final items = [Item('Ноутбук', 1000, 3, PercentDiscount(10))];
  if (fixed) return calculateTotal(items);
  // БЫЛО: цена со скидкой добавлялась только один раз.
  var total = 0.0;
  for (final item in items) {
    total += item.price - item.discount.getDiscount(item.price);
  }
  return total;
}

Future<Object?> inc2(bool fixed) async {
  final repo = OrderRepository(capacity: 1);
  final first = Order('B-1', 'demo', [Item('Книга', 100, 1, NoDiscount())]);
  final second = Order('B-2', 'demo', [Item('Книга', 100, 1, NoDiscount())]);
  repo.save(first);
  if (fixed) return OrderService(repo).placeOrder(second).success;
  // БЫЛО: ошибка ловилась, но success всё равно возвращался true.
  try {
    repo.save(second);
  } catch (_) {
    // Ошибка сохранения проигнорирована.
  }
  return true;
}

Future<Object?> inc3(bool fixed) async {
  final writer = ReportWriter();
  try {
    if (fixed) {
      generateReport(writer, ['Нормальная строка', '']);
    } else {
      // БЫЛО: после исключения writer.close() не выполнялся.
      writer.open();
      for (final row in ['Нормальная строка', '']) {
        writer.write(row);
      }
      writer.close();
    }
  } catch (_) {
    // Первый отчёт ожидаемо содержит пустую строку.
  }
  // Проверяем, удалось ли освободить ресурс и создать второй отчёт.
  try {
    generateReport(writer, ['Корректная строка']);
    return true;
  } catch (_) {
    return false;
  }
}

Future<Object?> inc4(bool fixed) async {
  if (fixed) return (await loadOrderHistory('demo')).length;
  // БЫЛО: асинхронный ответ не ожидался.
  final history = <String>[];
  unawaited(fetchOrderIds('demo').then((ids) {
    for (final id in ids) {
      history.add('Заказ $id');
    }
  }));
  return history.length;
}

Future<Object?> inc5(bool fixed) async {
  if (fixed) return shippingCost(5000);
  // БЫЛО: строгое > вместо >=.
  return 5000 > freeShippingThreshold ? 0.0 : 500.0;
}

Future<void> runCase(String id, Demo demo, Object expected) async {
  print('\n=== $id ===');
  final before = await demo(false);
  print('${before == expected ? "[OK]" : "[ОШИБКА]"} БЫЛО: ожидалось $expected, получено $before');
  final after = await demo(true);
  print('${after == expected ? "[OK]" : "[ОШИБКА]"} СТАЛО: ожидалось $expected, получено $after');
}

Future<void> main(List<String> args) async {
  final cases = <String, (Demo, Object)>{
    'INC-1': (inc1, 2700.0),
    'INC-2': (inc2, false),
    'INC-3': (inc3, true),
    'INC-4': (inc4, 3),
    'INC-5': (inc5, 0.0),
  };
  if (args.isNotEmpty && !cases.containsKey(args.first)) {
    print('Использование: dart run bin/demo.dart [INC-1|INC-2|INC-3|INC-4|INC-5]');
    return;
  }
  final selected = args.isEmpty ? cases.keys : [args.first];
  for (final id in selected) {
    final (demo, expected) = cases[id]!;
    await runCase(id, demo, expected);
  }
  print('\nБЫЛО — намеренно воспроизведённый дефект; СТАЛО — рабочий код из lib/src/.');
}
