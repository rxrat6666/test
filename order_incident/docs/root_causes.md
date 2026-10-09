# Первопричины
| Инцидент | Тип дефекта | Файл / функция | Доказательство |
|---|---|---|---|
| INC-1 | Логическая ошибка | pricing.dart / calculateTotal | Вклад позиции 900 при количестве 3 |
| INC-2 | Обработка ошибок | order_service.dart / placeOrder | StorageException при заполнении хранилища |
| INC-3 | Управление ресурсом | reports.dart / generateReport | После open не выполняется close |
| INC-4 | Асинхронность | history.dart / loadOrderHistory | return с 0 раньше получения 3 ID |
| INC-5 | Граничное условие | pricing.dart / shippingCost | total=5000 ошибочно даёт 500 |
