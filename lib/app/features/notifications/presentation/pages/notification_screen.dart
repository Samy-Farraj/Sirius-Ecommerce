import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/src/components/custom_app_bar/custom_app_bar.dart';
import 'package:sirius/src/themes/app_colors.dart';
import 'package:sirius/src/themes/app_sizes.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final List<Map<String, String>> todayNotifications = [
    {
      'title': 'New feature alert A',
      'description':
          'We\'re pleased to introduce the latest enhancements in our templating experience.',
      'date': '3:30PM - 10/2024',
    },
    {
      'title': 'New feature alert B',
      'description':
          'We\'re pleased to introduce the latest enhancements in our templating experience.',
      'date': '3:30PM - 12/2024',
    },
  ];

  final List<Map<String, String>> versionsNotifications = [
    {
      'title': 'New feature alert A',
      'description':
          'We\'re pleased to introduce the latest enhancements in our templating experience.',
      'date': '3:30PM - 12/2024',
    },
    {
      'title': 'New feature alert A',
      'description': 'We\'re pleased to introduce the latest',
      'date': '3:30PM - 12/2024',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        hideAction: true,
        title: "notifications".tr(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.cardRadius)),
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                'Today',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final notification = todayNotifications[index];
                  return _buildNotificationCard(notification, context);
                },
                childCount: todayNotifications.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                'Versions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final notification = versionsNotifications[index];
                  return _buildNotificationCard(notification, context);
                },
                childCount: versionsNotifications.length,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 40),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildNotificationCard(
    Map<String, String> notification, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 17.h),
    margin: EdgeInsets.symmetric(vertical: 16.h),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        border: Border.all(color: AppColors.whiteBorder)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['title']!,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  notification['description']!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      notification['date']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
