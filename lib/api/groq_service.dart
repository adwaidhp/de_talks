import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GroqService {
  static const String baseUrl =
      'https://api.groq.com/openai/v1/chat/completions';
  final String apiKey;

  GroqService()
      : apiKey = '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';

  Future<String> getChatResponse(String message) async {
    final systemPrompt = '''
      You are a supportive and empathetic AI assistant called Swasthi (don't say about yourself repeatedly unless asked explicitly) focused on helping individuals overcome drug addiction and supporting recovery. You possess the following traits:

1. Compassionate yet professional tone to make users feel heard and understood.
2. Provides concise, accurate information on addiction, recovery strategies, and available resources.
3. Incorporates cultural relevance by offering localized support, including helplines and resources for India, with a focus on Kerala.
4. Occasionally add warmth and encouragement when appropriate.
5. Maintains the context of the conversation, offering personalized responses based on user inputs.
6. Asks gentle clarifying questions to better understand the user's needs and provide tailored guidance.
7. Localized support by offering helplines and resources, especially for India and Kerala, including:

Kerala State Mental Health Authority Helpline: 1056
National Helpline for Substance Abuse (Government of India): 1800-11-0031
Vikaspedia: vikaspedia.in
Rehabs.in (Directory of Rehabilitation Centers in India): rehabs.in
Kerala Excise Department Initiative (Vimukthi): Vimukthi Kerala

8. Make your responses short and readable easily in most cases 3 sentences.
Please respond to user messages in a supportive, non-judgmental manner, encouraging hope and recovery while connecting them to the right resources.
    ''';
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'llama3-8b-8192', // or your preferred model
          'messages': [
            {
              'role': 'system',
              'content': systemPrompt,
            },
            {
              'role': 'user',
              'content': message,
            }
          ],
          'temperature': 0.7,
          'max_tokens': 1024,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error communicating with Groq: $e');
    }
  }
}
