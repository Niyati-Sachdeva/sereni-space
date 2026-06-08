import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    _model = GenerativeModel(
      model: 'gemini-3.5-flash',
      apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
    );
  }

  Future<String> generateReflection(
    String journalText,
  ) async {
    try {
      final prompt = '''
You are a calm and supportive wellness coach.

Analyze this journal entry and provide:
1. A brief emotional insight
2. One practical suggestion

Journal Entry:
$journalText
''';

      final response = await _model.generateContent(
        [Content.text(prompt)],
      );

      return response.text ??
          'No reflection generated.';
    } catch (e) {
      return 'ERROR: $e';
    }
  }
}