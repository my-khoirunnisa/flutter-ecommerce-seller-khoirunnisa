import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/assets.dart';
import '../../../core/core.dart';
import '../models/product_model.dart';
import '../widgets/product_showing.dart';
import '../widgets/product_showing_bottom_sheet.dart';

class LiveStreamingPage extends StatelessWidget {
  const LiveStreamingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Assets.images.livestreamDummy.image(
            width: context.deviceWidth,
            height: context.deviceHeight,
            fit: BoxFit.cover,
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
                    Container(
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Button.filled(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (context) => const ProductShowingBottomSheet(),
            );
          },
          label: 'Mulai Livestream',
        ),
      ),
    );
  }
}
