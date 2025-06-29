import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medical/core/api/endpoints.dart';
import '../models/address_model.dart';

class AddressServiceApi {
  final Dio dio;

  AddressServiceApi(this.dio);

  final String baseUrl = "${Endpoints.baseUrl}/addresses";

  Future<List<AddressModel>> getAddresses() async {
    try {
      final response = await dio.get(baseUrl);
      log('API Response Status Code: ${response.statusCode}');
      debugPrint('API Response Data: ${response.data}');

      if (response.statusCode == 200) {
        // Handle both cases: data wrapped in 'data' key or direct array
        List<dynamic> data;

        if (response.data is Map && response.data.containsKey('data')) {
          data = response.data['data'] as List;
        } else if (response.data is List) {
          data = response.data as List;
        } else {
          throw Exception('Unexpected API response format');
        }

        debugPrint('Parsed data length: ${data.length}');

        List<AddressModel> addresses = [];
        for (var item in data) {
          try {
            debugPrint('Processing item: $item');
            final address = AddressModel.fromJson(item as Map<String, dynamic>);
            debugPrint('Created address: $address');
            addresses.add(address);
          } catch (e) {
            debugPrint('Error parsing address item: $e');
            debugPrint('Problematic item: $item');
            rethrow;
          }
        }

        return addresses;
      } else {
        throw Exception('Failed to load addresses: ${response.statusCode}');
      }
    } on DioException catch (e) {
      debugPrint('DioException: ${e.message}');
      debugPrint('DioException response: ${e.response?.data}');
      throw Exception('Failed to load addresses: ${e.message}');
    } catch (e) {
      debugPrint('General Exception: $e');
      rethrow;
    }
  }

  Future<void> addAddress(AddressModel address) async {
    try {
      // Use the toCreateJson method to ensure proper formatting
      final requestData = address.toCreateJson();
      debugPrint('Adding address with data: $requestData');

      final response = await dio.post(baseUrl, data: requestData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Address added successfully');
        debugPrint('Response: ${response.data}');
      }
    } catch (e) {
      debugPrint('Error adding address: $e');
      if (e is DioException && e.response != null) {
        debugPrint('Error response: ${e.response!.data}');
      }
      rethrow;
    }
  }

  Future<void> updateAddress(int id, AddressModel address) async {
    try {
      // Use the new toUpdateJson method to ensure all fields are properly set
      final body = address.toUpdateJson();
      debugPrint('Updating address $id with data: $body');

      final response = await dio.put('$baseUrl/$id', data: body);
      debugPrint('Update address response: ${response.data}');
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint('Response status: ${e.response?.statusCode}');
        debugPrint('Error body: ${e.response?.data}');
      }
      debugPrint('Error updating address: ${e.message}');
      rethrow;
    }
  }

  Future<void> deleteAddress(int id) async {
    try {
      debugPrint('Deleting address $id');
      final response = await dio.delete('$baseUrl/$id');
      debugPrint('Delete address response: ${response.data}');
    } on DioException catch (e) {
      debugPrint('Error deleting address: ${e.message}');
      debugPrint('Error response: ${e.response?.data}');
      rethrow;
    }
  }
}
