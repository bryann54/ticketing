// lib/features/home/presentation/widgets/home_shimmer_loading_state.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerLoadingState extends StatelessWidget {
  const HomeShimmerLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mimic Featured / Hero Section
            _buildFeaturedShimmer(),
            const SizedBox(height: 24),
            // Mimic Your events section
            _buildSectionShimmer(),
            const SizedBox(height: 24),
            // Mimic Explore Top Venues section
            _buildSectionShimmer(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildSectionShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 24,
            width: 150,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: 3, // Display a few shimmer cards
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: _buildCardShimmer(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCardShimmer() {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
