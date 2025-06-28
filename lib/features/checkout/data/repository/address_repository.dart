import 'package:medical/features/checkout/data/api/address_api_services.dart';

import '../models/address_model.dart';

class AddressRepository {
  final AddressServiceApi addressApi;

  AddressRepository(this.addressApi);

  Future<List<AddressModel>> fetchAddresses() => addressApi.getAddresses();

  Future<void> addNewAddress(AddressModel address) =>
      addressApi.addAddress(address);

  Future<void> editAddress(int id, AddressModel address) =>
      addressApi.updateAddress(id, address);

  Future<void> deleteAddress(int id) => addressApi.deleteAddress(id);
}
