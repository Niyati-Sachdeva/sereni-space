import 'package:hive/hive.dart';

import 'journal_entry.dart';

class JournalRepository {
  static const _boxName = 'journal_entries';

  Box<JournalEntry> get _box =>
      Hive.box<JournalEntry>(_boxName);

  List<JournalEntry> getEntries() {
    return _box.values.toList().reversed.toList();
  }

  Future<void> saveEntry(
    JournalEntry entry,
  ) async {
    await _box.add(entry);
  }

  Future<void> deleteEntry(
    int index,
  ) async {
    await _box.deleteAt(index);
  }
}