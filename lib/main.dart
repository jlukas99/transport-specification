import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/transport_spec_screen.dart';
import 'services/document_scanner_service.dart';
import 'services/supabase_service.dart';
import 'services/openai_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['VITE_SUPABASE_URL']!,
    anonKey: dotenv.env['VITE_SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final supabaseService = SupabaseService(supabase);
    final openAIService = OpenAIService(
      apiKey: dotenv.env['OPENAI_API_KEY']!,
    );
    final scannerService = DocumentScannerService(
      openAIService: openAIService,
    );

    return MaterialApp(
      title: 'Transport Spec App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: TransportSpecScreen(
        supabaseService: supabaseService,
        scannerService: scannerService,
      ),
    );
  }
}
