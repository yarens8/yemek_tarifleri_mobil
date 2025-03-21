import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class ApiService {
  // Fiziksel cihaz için gerçek IP adresi
  static const String baseUrl = 'http://192.168.1.103:5000';
  final _logger = Logger('ApiService');

  // Kategorileri getir
  Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      _logger.info('Kategoriler için API isteği yapılıyor...');
      final response = await http.get(Uri.parse('$baseUrl/api/categories'));
      _logger.info('API yanıtı alındı. Status code: ${response.statusCode}');
      _logger.info('API yanıt body: ${response.body}');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _logger.info('Dönüştürülen veri: $data');
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Kategoriler yüklenirken hata: ${response.statusCode}');
      }
    } catch (e) {
      _logger.severe('Kategoriler yüklenirken hata oluştu: $e');
      rethrow;
    }
  }

  // Tarifleri getir
  Future<List<Map<String, dynamic>>> getRecipes() async {
    try {
      _logger.info('Tarifler için API isteği yapılıyor...');
      final response = await http.get(
        Uri.parse('$baseUrl/api/recipes'),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('API yanıt vermedi');
        },
      );
      
      _logger.info('API yanıtı alındı. Status code: ${response.statusCode}');
      _logger.info('API yanıt body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _logger.info('Dönüştürülen veri: $data');
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Tarifler yüklenirken hata: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      _logger.severe('Tarifler yüklenirken hata oluştu: $e');
      rethrow;
    }
  }

  // Kategoriye göre tarifleri getir
  Future<List<Map<String, dynamic>>> getRecipesByCategory(int categoryId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/recipes/category/$categoryId'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Tarifler yüklenirken hata: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Tarifler yüklenirken hata: $e');
    }
  }

  // Tarif detayını getir
  Future<Map<String, dynamic>> getRecipeDetail(int recipeId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/recipes/$recipeId'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Tarif detayı yüklenirken hata: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Tarif detayı yüklenirken hata: $e');
    }
  }

  // Tarif ara
  Future<List<Map<String, dynamic>>> searchRecipes(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/recipes/search?q=$query'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Arama yapılırken hata: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Arama yapılırken hata: $e');
    }
  }
} 