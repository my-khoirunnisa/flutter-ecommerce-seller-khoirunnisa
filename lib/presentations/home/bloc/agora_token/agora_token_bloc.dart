import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ecommerce_seller_app/data/datasources/agora_remote_datasource.dart';

part 'agora_token_bloc.freezed.dart';
part 'agora_token_event.dart';
part 'agora_token_state.dart';

class AgoraTokenBloc extends Bloc<AgoraTokenEvent, AgoraTokenState> {
  final AgoraRemoteDatasource datasource;
  AgoraTokenBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_GetToken>((event, emit) async {
      emit(const _Loading());
      final result =
          await datasource.getToken(event.channel, event.uid, event.role);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(event.channel, event.uid, r)),
      );
    });
  }
}
