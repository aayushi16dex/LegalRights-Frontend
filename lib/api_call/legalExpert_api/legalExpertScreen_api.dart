import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/TokenManager.dart';
import '../../core/config.dart';

class LegalExpertScreenApiCall {
  static Future<Map<String, int>> fetchQueriesCountApi(
      BuildContext context) async {
    try {
      final String fetchQueriesCountUrl = AppConfig.fetchQueriesCount;
      final String authToken = await TokenManager.getAuthToken();

      final response = await http.get(
        Uri.parse(fetchQueriesCountUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final int totalQueries = data['totalQueryCount'] ?? 0;
        final int unansweredQueries = data['unansweredQueryCount'] ?? 0;
        final int answeredQueries = data['answeredQueryCount'] ?? 0;

        return {
          'totalQueries': totalQueries,
          'unansweredQueries': unansweredQueries,
          'answeredQueries': answeredQueries,
        };
      } else {
        throw Exception('Failed to fetch queries count');
      }
    } catch (error, stackTrace) {
      print('Error fetching queries count: $error');
      print(stackTrace);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching queries count: $error'),
        duration: const Duration(seconds: 2),
      ));
      return {};
    }
  }

  static Future<List<Map<String, dynamic>>> fetchUnansweredQueriesApi(
      BuildContext context) async {
    try {
      final String fetchUnansweredQueriesUrl = AppConfig.fetchUnansweredQueries;
      final String authToken = await TokenManager.getAuthToken();

      final response = await http.get(
        Uri.parse(fetchUnansweredQueriesUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> queryList = data['queryList'];

        final List<Map<String, dynamic>> unansweredQueries =
            queryList.map((query) {
          return {
            '_id': query['_id'].toString(),
            'query': query['query'].toString(),
            'createdAt': query['createdAt'].toString(),
            'askedBy':
                "${query['userId']['firstName']} ${query['userId']['lastName']}"
          };
        }).toList();

        return unansweredQueries;
      } else {
        throw Exception('Failed to fetch unanswered queries');
      }
    } catch (error, stackTrace) {
      print('Error fetching unanswered queries: $error');
      print(stackTrace);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching unanswered queries: $error'),
        duration: const Duration(seconds: 2),
      ));
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> fetchAnsweredQueriesApi(
      BuildContext context) async {
    try {
      final String fetchAnsweredQueriesUrl = AppConfig.fetchAnsweredQueries;
      final String authToken = await TokenManager.getAuthToken();

      final response = await http.get(
        Uri.parse(fetchAnsweredQueriesUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> queryList = data['queryList'];

        final List<Map<String, dynamic>> answeredQueries =
            queryList.map((query) {
          return {
            'query': query['query'].toString(),
            'response': query['response'].toString(),
            'createdAt': query['createdAt'].toString(),
            'updatedAt': query['updatedAt'].toString(),
            'askedBy': query['userId']['firstName'].toString() +
                query['userId']['lastName'].toString()
          };
        }).toList();

        return answeredQueries;
      } else {
        throw Exception('Failed to fetch answered queries');
      }
    } catch (error, stackTrace) {
      print('Error fetching answered queries: $error');
      print(stackTrace);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching answered queries: $error'),
        duration: const Duration(seconds: 2),
      ));
      return [];
    }
  }

  static Future<bool> answerQueryApi(
      BuildContext context, String queryId, String responseText) async {
    try {
      final String answerQueryUrl = AppConfig.answerQuery;
      final String authToken = await TokenManager.getAuthToken();
      final httpResponse = await http.patch(
        Uri.parse('$answerQueryUrl/$queryId'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'response': responseText,
        }),
      );

      if (httpResponse.statusCode == 200) {
        return true; // Indicates success
      } else {
        throw Exception('Failed to answer the query');
      }
    } catch (error, stackTrace) {
      print('Error answering the query: $error');
      print(stackTrace);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error answering the query: $error'),
        duration: const Duration(seconds: 2),
      ));
      return false; // Indicates failure
    }
  }
}
