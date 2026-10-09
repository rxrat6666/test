import 'app_logger.dart';
class ReportWriter {
  bool isOpen = false;
  final List<String> lines = [];
  void open() {
    log.fine('INC-3: writer.open() до вызова, isOpen=$isOpen');
    if (isOpen) throw StateError('Отчёт уже открыт другим процессом');
    isOpen = true;
    log.fine('INC-3: отчёт открыт, isOpen=$isOpen');
  }
  void write(String line) {
    if (!isOpen) throw StateError('Отчёт не открыт');
    if (line.trim().isEmpty) throw ArgumentError('Нельзя записать пустую строку');
    lines.add(line);
  }
  void close() {
    isOpen = false;
    log.fine('INC-3: отчёт закрыт, isOpen=$isOpen');
  }
}
void generateReport(ReportWriter writer, List<String> rows) {
  log.info('INC-3: начало формирования отчёта, строк=${rows.length}');
  writer.open();
  try {
    for (final row in rows) {
      writer.write(row);
    }
  } finally {
    writer.close();
    log.info('INC-3: формирование завершено, isOpen=${writer.isOpen}');
  }
}
