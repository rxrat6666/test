import 'dart:io';
import 'package:logging/logging.dart';
final Logger log = Logger('order_incident');
void setupLogging({String filePath = 'app.log'}) {
  Logger.root.level = Level.ALL;
  final file = File(filePath);
  if (file.existsSync()) file.deleteSync();
  void emit(String line) {
    print(line);
    file.writeAsStringSync('$line\n', mode: FileMode.append);
  }
  Logger.root.onRecord.listen((record) {
    emit('${record.time.toIso8601String()} [${record.level.name}] '
        '${record.loggerName}: ${record.message}');
    if (record.error != null) emit('    причина: ${record.error}');
  });
}
