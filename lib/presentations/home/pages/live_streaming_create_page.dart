import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_seller_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/bloc/agora_token/agora_token_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/bloc/set_livestreaming/set_livestreaming_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/pages/live_streaming_on_page.dart';

import '../../../core/core.dart';

class LiveStreamingCreatePage extends StatefulWidget {
  const LiveStreamingCreatePage({super.key});

  @override
  State<LiveStreamingCreatePage> createState() =>
      _LiveStreamingCreatePageState();
}

class _LiveStreamingCreatePageState extends State<LiveStreamingCreatePage> {
  final titleLiveStreamController = TextEditingController();

  @override
  void dispose() {
    titleLiveStreamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Live Streaming'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CustomTextField(
            controller: titleLiveStreamController,
            label: 'Judul',
            hintText: 'Masukkan judul live stream',
            onChanged: (value) {
              setState(() {});
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AgoraTokenBloc, AgoraTokenState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (channel, uid, data) {
                context.pushReplacement(
                  LiveStreamingOnPage(
                    channel: channel,
                    uid: uid,
                    token: data,
                  ),
                );
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Button.filled(
                  disabled: titleLiveStreamController.text.isEmpty,
                  onPressed: () async {
                    final authData = await AuthLocalDatasource().getAuthData();
                    // ignore: use_build_context_synchronously
                    context.read<SetLivestreamingBloc>().add(
                          SetLivestreamingEvent.setLivestreaming(
                            titleLiveStreamController.text,
                            true,
                          ),
                        );
                    // ignore: use_build_context_synchronously
                    context.read<AgoraTokenBloc>().add(
                          AgoraTokenEvent.getToken(
                              authData.data!.user!.name!
                                  .trim()
                                  .replaceAll(' ', ''),
                              authData.data!.user!.id!.toString(),
                              'RolePublisher'),
                        );
                  },
                  label: 'Lanjut',
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
