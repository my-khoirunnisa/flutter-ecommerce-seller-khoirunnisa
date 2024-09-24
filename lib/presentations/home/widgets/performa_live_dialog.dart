import 'package:flutter/material.dart';

import '../../../core/assets/assets.dart';
import '../../../core/core.dart';

class PerformaLiveDialog extends StatelessWidget {
  const PerformaLiveDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Assets.icons.performa.svg(),
              const SpaceWidth(12.0),
              const Text(
                'Performa Live',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close),
                color: AppColors.gray,
              ),
            ],
          ),
          const SpaceHeight(30.0),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Assets.icons.totalPenonton.svg(),
                    const SpaceHeight(20.0),
                    const Text(
                      '200',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const Text(
                      'Total Penonton',
                      style: TextStyle(
                        color: AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
              const SpaceWidth(10.0),
              Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Assets.icons.durasiLive.svg(),
                    const SpaceHeight(20.0),
                    const Text(
                      '00:03:25',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const Text(
                      'Durasi Live',
                      style: TextStyle(
                        color: AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
