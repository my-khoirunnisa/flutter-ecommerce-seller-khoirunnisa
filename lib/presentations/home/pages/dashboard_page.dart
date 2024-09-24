import 'package:flutter/material.dart';

import '../../../core/assets/assets.dart';
import '../../../core/core.dart';
import 'live_streaming_create_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardpageState();
}

class _DashboardpageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(40.0),
          Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
              ),
              const SpaceWidth(8.0),
              const Expanded(
                child: Text(
                  'Updated at May 9, 2024',
                  style: TextStyle(
                    color: AppColors.gray,
                  ),
                ),
              ),
              const Text('Live Stream'),
              const SpaceWidth(4.0),
              IconButton(
                onPressed: () {
                  context.push(const LiveStreamingCreatePage());
                },
                icon: Assets.icons.liveStream.svg(),
              ),
            ],
          ),
          const SpaceHeight(10.0),
          const Text(
            'General dashboard',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SpaceHeight(80.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: AppColors.stroke),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Assets.icons.chart.svg(),
                    const SpaceWidth(8.0),
                    const Text('Total Product'),
                  ],
                ),
                const SpaceHeight(16.0),
                const Text(
                  '60',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SpaceHeight(22.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: AppColors.stroke),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total item orders'),
                SpaceHeight(16.0),
                Text(
                  '120',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
