import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ecommerce_seller_app/presentations/home/bloc/set_livestreaming/set_livestreaming_bloc.dart';
import 'package:flutter_ecommerce_seller_app/presentations/home/pages/main_page.dart';

import '../../../core/core.dart';

class EndStreamingConfirmDialog extends StatelessWidget {
  final RtcEngine engine;
  final String title;
  const EndStreamingConfirmDialog({
    super.key,
    required this.engine,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Hentikan live stream?',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close),
                color: AppColors.gray,
              ),
            ],
          ),
          const SpaceHeight(10.0),
          const Text(
            'Apakah anda yakin untuk menyelesaikan live stream produk kali ini',
            style: TextStyle(
              color: AppColors.gray,
            ),
          ),
          const SpaceHeight(38.0),
          Row(
            children: [
              Flexible(
                child: Button.outlined(
                  onPressed: () => context.pop(),
                  label: 'Cancel',
                ),
              ),
              const SpaceWidth(10.0),
              Flexible(
                child: Button.filled(
                  onPressed: () {
                    engine.leaveChannel();
                    context
                        .read<SetLivestreamingBloc>()
                        .add(const SetLivestreamingEvent.setLivestreaming(
                          '',
                          false,
                        ));
                    context.pushReplacement(const MainPage());
                  },
                  label: 'Confirm',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
