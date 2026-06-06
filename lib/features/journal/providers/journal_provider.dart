import 'package:flutter/material.dart';

import '../journal_entry.dart';
import '../journal_repository.dart';

class JournalProvider extends ChangeNotifier {
  final JournalRepository _repository =
      JournalRepository();

  List<JournalEntry> _entries = [];

  List<JournalEntry> get entries => _entries;

  void loadEntries() {
    _entries = _repository.getEntries();
    notifyListeners();
  }

  Future<void> saveEntry(
    JournalEntry entry,
  ) async {
    await _repository.saveEntry(entry);

    _entries = _repository.getEntries();

    notifyListeners();
  }
}