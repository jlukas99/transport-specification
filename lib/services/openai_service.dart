import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String apiKey;
  final String model;
  final String endpoint = 'https://api.openai.com/v1/chat/completions';

  OpenAIService({
    required this.apiKey,
    this.model = 'gpt-4o',
  });

  Future<Map<String, dynamic>?> extractTransportData(String text) async {
    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': model,
          'messages': [
            {
              'role': 'system',
              'content':
                  '''You are a transport document parser. Extract the following information from the text:
                - ZLTC number (format: YYYY-ZLTC-XXX-XXXXXX)
                - Loading date (format: YYYY-MM-DD)
                - Loading location
                - Unloading date (format: YYYY-MM-DD)
                - Unloading location
                - Rate (in PLN)
                
                Return the data in JSON format with these exact keys:
                specNumber, loadingDate, loadingLocation, unloadingDate, unloadingLocation, rate'''
            },
            {
              'role': 'user',
              'content': text,
            }
          ],
          'temperature': 0,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices'][0]['message']['content'];
        return jsonDecode(content);
      }
      return null;
    } catch (e) {
      print('Error calling OpenAI API: $e');
      return null;
    }
  }
}
