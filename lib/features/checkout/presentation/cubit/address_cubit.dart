import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/features/checkout/data/models/address_model.dart';
import 'package:medical/features/checkout/data/repository/address_repository.dart';
import 'package:medical/features/checkout/presentation/cubit/address_states.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepository repository;

  AddressCubit(this.repository) : super(AddressInitial());

  Future<void> fetchAddresses() async {
    emit(AddressLoading());
    try {
      final addresses = await repository.fetchAddresses();
      emit(AddressLoaded(addresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> addAddress(AddressModel address) async {
    try {
      await repository.addNewAddress(address);
      fetchAddresses(); // Refresh the list
    } catch (e) {
      emit(AddressError('Failed to add address: $e'));
    }
  }

  Future<void> updateAddress(int id, AddressModel address) async {
    try {
      await repository.editAddress(id, address);
      fetchAddresses(); // Refresh the list
    } catch (e) {
      emit(AddressError('Failed to update address: $e'));
    }
  }
}
