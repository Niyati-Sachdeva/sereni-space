import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> _fallbackPrompts = [
  'What made you smile today? 🌸',
  'What felt heavy today, and why?',
  'What are you grateful for right now?',
  'What would you tell your younger self today?',
  'What emotion stayed with you the most today?',
  'Where did you feel most like yourself today?',
  'What do you need to let go of today?',
  'What small moment brought you peace today?',
];

const String _geminiApiKey = 'YOUR_GEMINI_API_KEY_HERE';

const String _geminiUrl =
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_geminiApiKey';

Future<String> fetchJournalPrompt() async {
  if (_geminiApiKey == 'YOUR_GEMINI_API_KEY_HERE') {
    return _getRandomFallback();
  }

  try {
    final response = await http
        .post(
          Uri.parse(_geminiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'contents': [
              {
                'parts': [
                  {
                    'text':
                        'Give me one short, calming, reflective journal prompt for a wellness app user. Maximum 12 words. No quotes, no intro text.',
                  }
                ]
              }
            ]
          }),
        )
        .timeout(const Duration(seconds: 6));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final text =
          json['candidates'][0]['content']['parts'][0]['text'] as String;

      return text.trim();
    }

    return _getRandomFallback();
  } catch (_) {
    return _getRandomFallback();
  }
}

String _getRandomFallback() {
  final index = DateTime.now().second % _fallbackPrompts.length;
  return _fallbackPrompts[index];
}