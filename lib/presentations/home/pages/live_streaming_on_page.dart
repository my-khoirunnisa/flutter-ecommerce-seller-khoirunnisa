import 'dart:math';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_seller_app/core/constants/variables.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/core.dart';
import '../models/chat_model.dart';
import '../models/product_model.dart';
import '../widgets/end_streaming_confirm_dialog.dart';
import '../widgets/performa_live_dialog.dart';
import '../widgets/product_showing.dart';

class LiveStreamingOnPage extends StatefulWidget {
  final String channel;
  final String uid;
  final String token;
  const LiveStreamingOnPage({
    super.key,
    required this.channel,
    required this.uid,
    required this.token,
  });

  @override
  State<LiveStreamingOnPage> createState() => _LiveStreamingOnPageState();
}

class _LiveStreamingOnPageState extends State<LiveStreamingOnPage> {
  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: Variables.agoraAppId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        // onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        //   debugPrint("remote user $remoteUid joined");
        //   setState(() {
        //     _remoteUid = remoteUid;
        //   });
        // },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
        onError: (err, msg) {
          debugPrint('onError $err, $msg');
        },
        onExtensionError: (provider, extension, error, message) {
          debugPrint(
              'onExtensionError $provider, $extension, $error, $message');
        },
        onPermissionError: (permissionType) {
          debugPrint('onPermissionError $permissionType');
        },
        onEncryptionError: (connection, errorType) {
          debugPrint('onEncryptionError $connection, $errorType');
        },
        onStreamMessageError:
            (connection, remoteUid, streamId, code, missed, cached) {
          debugPrint(
              'onStreamMessageError $connection, $remoteUid, $streamId, $code, $missed, $cached');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await _engine.joinChannel(
      token: widget.token,
      channelId: widget.channel,
      uid: int.parse(widget.uid),
      options: const ChannelMediaOptions(),
    );
    await _engine.enableAudio();
    await _engine.enableVideo();
    await _engine.startPreview();
  }

  Widget _remoteVideo() {
    if (_localUserJoined) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: widget.channel),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          !_localUserJoined
              ? const SizedBox()
              : Center(
                  child: AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: _engine,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SpaceHeight(50.0),
                const Text(
                  'Promo Spesial Live',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SpaceHeight(17.0),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: AppColors.black.withOpacity(0.32),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.white,
                              ),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://www.greenscene.co.id/wp-content/uploads/2021/06/Kaiju-2.jpg',
                                width: 24.0,
                                height: 24.0,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                          const SpaceWidth(7.0),
                          const Text(
                            'cwbcollection',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                          const SpaceWidth(7.0),
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => const PerformaLiveDialog(),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: AppColors.black.withOpacity(0.32),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SpaceWidth(5.0),
                            Icon(
                              Icons.visibility_outlined,
                              color: AppColors.white,
                            ),
                            SpaceWidth(7.0),
                            Text(
                              '0',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ),
                            SpaceWidth(16.0),
                          ],
                        ),
                      ),
                    ),
                    const SpaceWidth(10.0),
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: AppColors.black.withOpacity(0.32),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => EndStreamingConfirmDialog(
                              title: widget.channel,
                              engine: _engine,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.highlight_off,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(14.0),
                ProductShowing(
                  products: products,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              AppColors.black.withOpacity(0.46),
              AppColors.black,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 180.0,
              child: SingleChildScrollView(
                child: Column(
                  children: chats
                      .map(
                        (item) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              width: 40.0,
                              height: 40.0,
                              fit: BoxFit.cover,
                              imageUrl: item.imageUrl,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                            ),
                          ),
                          title: RichText(
                            text: TextSpan(
                              text: '${item.name} ',
                              children: [
                                TextSpan(
                                  text: item.message,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SpaceHeight(11.0),
            Row(
              children: ['Hello!!', 'Selamat Bergabung kak !', '🙂']
                  .map(
                    (item) => GestureDetector(
                      onTap: () => messageController.text = item,
                      child: Container(
                        margin: const EdgeInsets.only(right: 5.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: AppColors.black.withOpacity(0.42),
                        ),
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SpaceHeight(17.0),
            MessageTextField(
              controller: messageController,
              hintText: 'Type here...',
              sendTap: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
