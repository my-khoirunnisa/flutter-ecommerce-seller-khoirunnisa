import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ecommerce_seller_app/data/datasources/auth_remote_datasource.dart';

part 'set_livestreaming_bloc.freezed.dart';
part 'set_livestreaming_event.dart';
part 'set_livestreaming_state.dart';

class SetLivestreamingBloc
    extends Bloc<SetLivestreamingEvent, SetLivestreamingState> {
  final AuthRemoteDatasource authRemoteDatasource;
  SetLivestreamingBloc(
    this.authRemoteDatasource,
  ) : super(const _Initial()) {
    on<_SetLivestreaming>((event, emit) async {
      emit(const _Loading());
      final result = await authRemoteDatasource.setLiveStreaming(
          event.title, event.isActive);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Loaded()),
      );
    });
  }
}
