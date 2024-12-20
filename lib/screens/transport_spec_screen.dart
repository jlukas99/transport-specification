import 'package:flutter/material.dart';
import '../services/document_scanner_service.dart';
import '../services/supabase_service.dart';
import '../models/transport_spec.dart';

class TransportSpecScreen extends StatefulWidget {
  final SupabaseService supabaseService;
  final DocumentScannerService scannerService;

  const TransportSpecScreen({
    Key? key,
    required this.supabaseService,
    required this.scannerService,
  }) : super(key: key);

  @override
  _TransportSpecScreenState createState() => _TransportSpecScreenState();
}

class _TransportSpecScreenState extends State<TransportSpecScreen> {
  List<TransportSpec> specs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSpecs();
  }

  Future<void> _loadSpecs() async {
    try {
      setState(() => isLoading = true);
      final loadedSpecs = await widget.supabaseService.getTransportSpecs();
      setState(() {
        specs = loadedSpecs;
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading specifications: $e')),
      );
      setState(() => isLoading = false);
    }
  }

  Future<void> _scanDocument() async {
    try {
      final scannedSpec = await widget.scannerService.scanDocument();
      if (scannedSpec != null) {
        await widget.supabaseService.createTransportSpec(scannedSpec);
        await _loadSpecs();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error scanning document: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transport Specifications'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: specs.length,
              itemBuilder: (context, index) {
                final spec = specs[index];
                return ListTile(
                  title: Text(spec.specNumber),
                  subtitle: Text(
                    '${spec.loadingLocation} → ${spec.unloadingLocation}\n'
                    'Rate: ${spec.rate} PLN',
                  ),
                  trailing: Text(
                    '${spec.loadingDate.toLocal().toString().split(' ')[0]}\n'
                    '${spec.unloadingDate.toLocal().toString().split(' ')[0]}',
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanDocument,
        child: const Icon(Icons.document_scanner),
      ),
    );
  }
}
