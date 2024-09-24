part of 'agora_token_bloc.dart';

@freezed
class AgoraTokenEvent with _$AgoraTokenEvent {
  const factory AgoraTokenEvent.started() = _Started;
  const factory AgoraTokenEvent.getToken(String channel, String uid, String role) = _GetToken;
}