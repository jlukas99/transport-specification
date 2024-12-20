import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/transport_spec.dart';

class SupabaseService {
  final SupabaseClient _supabase;

  SupabaseService(this._supabase);

  Future<List<TransportSpec>> getTransportSpecs() async {
    final response = await _supabase
        .from('transport_specs')
        .select()
        .order('loading_date', ascending: true);

    return response.map((data) => TransportSpec.fromJson(data)).toList();
  }

  Future<TransportSpec> createTransportSpec(TransportSpec spec) async {
    final response = await _supabase
        .from('transport_specs')
        .insert(spec.toJson())
        .select()
        .single();

    return TransportSpec.fromJson(response);
  }

  Future<void> updateTransportSpec(TransportSpec spec) async {
    await _supabase
        .from('transport_specs')
        .update(spec.toJson())
        .eq('id', spec.id);
  }

  Future<void> deleteTransportSpec(String id) async {
    await _supabase.from('transport_specs').delete().eq('id', id);
  }
}
