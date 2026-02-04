import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api_client.dart';

class ResumeRepository {
  Future<List<Map<String, dynamic>>> fetchResumes() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];
    final token = await user.getIdToken();
    final client = ApiClient(token: token);
    final response = await client.get('/resumes');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body) as List<dynamic>;
      return data.cast<Map<String, dynamic>>();
    }
    throw Exception('Falha ao carregar currículos');
  }
}

final resumeRepositoryProvider = Provider((ref) => ResumeRepository());

final resumesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return ref.read(resumeRepositoryProvider).fetchResumes();
});
