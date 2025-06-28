import 'dart:developer';

import 'package:dio/dio.dart';
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
      print('API Response Data: ${response.data}');

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

        print('Parsed data length: ${data.length}');

        List<AddressModel> addresses = [];
        for (var item in data) {
          try {
            print('Processing item: $item');
            final address = AddressModel.fromJson(item as Map<String, dynamic>);
            print('Created address: $address');
            addresses.add(address);
          } catch (e) {
            print('Error parsing address item: $e');
            print('Problematic item: $item');
            rethrow;
          }
        }

        return addresses;
      } else {
        throw Exception('Failed to load addresses: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('DioException response: ${e.response?.data}');
      throw Exception('Failed to load addresses: ${e.message}');
    } catch (e) {
      print('General Exception: $e');
      rethrow;
    }
  }

  Future<void> addAddress(AddressModel address) async {
    try {
      final response = await dio.post(
        baseUrl, // Your API endpoint
        data: {
          'title': address.title,
          'address_line1': address.addressLine1, // Note: snake_case
          'address_line2': address.addressLine2, // Note: snake_case
          'is_default': address.isDefault ? 1 : 0,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Address added successfully');
      }
    } catch (e) {
      print('Error adding address: $e');
      if (e is DioException && e.response != null) {
        print('Error response: ${e.response!.data}');
      }
      rethrow;
    }
  }

  Future<void> updateAddress(int id, AddressModel address) async {
    try {
      print('Updating address $id: ${address.toCreateJson()}');
      final response = await dio.put(
        '$baseUrl/$id',
        data: address.toCreateJson(),
      );
      print('Update address response: ${response.data}');
    } on DioException catch (e) {
      print('Error updating address: ${e.message}');
      print('Error response: ${e.response?.data}');
      rethrow;
    }
  }

  Future<void> deleteAddress(int id) async {
    try {
      print('Deleting address $id');
      final response = await dio.delete('$baseUrl/$id');
      print('Delete address response: ${response.data}');
    } on DioException catch (e) {
      print('Error deleting address: ${e.message}');
      print('Error response: ${e.response?.data}');
      rethrow;
    }
  }
}
