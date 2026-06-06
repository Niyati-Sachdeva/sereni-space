import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'journal_entry.g.dart';

@HiveType(typeId: 0)
class JournalEntry extends HiveObject {
  @HiveField(0)
  final String prompt;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final DateTime date;

  JournalEntry({
    required this.prompt,
    required this.content,
    required this.date,
  });
}