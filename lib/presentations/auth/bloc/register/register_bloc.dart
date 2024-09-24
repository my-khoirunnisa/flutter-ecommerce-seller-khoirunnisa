import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ecommerce_seller_app/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_ecommerce_seller_app/data/models/request/register_request_model.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource authRemoteDatasource;
  RegisterBloc(
    this.authRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Register>((event, emit) async {
      emit(const _Loading());
      final result = await authRemoteDatasource.register(event.data);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(const _Loaded()),
      );
    });
  }
}
