import 'package:flutter/material.dart';
import '../journal_repository.dart';
import '../journal_entry.dart';
import '../widgets/journal_input.dart';
import '../widgets/prompt_card.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';
class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController _textController =
      TextEditingController();

  

  String _currentPrompt = '';
  bool _isSaving = false;

 
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _saveEntry() async {
    final content = _textController.text.trim();

    if (content.isEmpty) return;

    setState(() {
      _isSaving = true;
    });

    final entry = JournalEntry(
      prompt: _currentPrompt,
      content: content,
      date: DateTime.now(),
    );
    await context
    .read<JournalProvider>()
    .saveEntry(entry);

setState(() {
  _isSaving = false;
});
    _textController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reflection saved 🌸'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
final journalProvider =
    context.watch<JournalProvider>();

final entries = journalProvider.entries;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Reflection 🌸",
                style: theme.textTheme.headlineMedium,
              ),

              const SizedBox(height: 6),

              Text(
                "Take a moment and write what is on your mind.",
                style: theme.textTheme.bodyMedium,
              ),

              const SizedBox(height: 24),

              PromptCard(
                onPromptLoaded: (prompt) {
                  _currentPrompt = prompt;
                },
              ),

              const SizedBox(height: 20),

              JournalInput(
                controller: _textController,
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      _isSaving ? null : _saveEntry,
                  child: Text(
                    _isSaving
                        ? 'Saving...'
                        : 'Save Reflection',
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Text(
                'Recent Reflections',
                style: theme.textTheme.titleMedium,
              ),

              const SizedBox(height: 12),

              if (entries.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:
                        theme.colorScheme.surface,
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: Text(
                    'No reflections yet. Start writing 🌿',
                    style: theme.textTheme.bodyMedium,
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: entries.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final entry = entries[index];

                    return Container(
                      padding:
                          const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            theme.colorScheme.surface,
                        borderRadius:
                            BorderRadius.circular(
                                16),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Text(
                            entry.prompt,
                            style: theme
                                .textTheme.bodyMedium
                                ?.copyWith(
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          Text(
                            entry.content,
                            style: theme
                                .textTheme.bodyMedium,
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          Text(
                            entry.date
                                .toString()
                                .split('.')
                                .first,
                            style: theme
                                .textTheme.labelSmall,
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}