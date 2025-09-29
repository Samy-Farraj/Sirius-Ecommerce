import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirius/src/components/custom_app_bar/custom_app_bar.dart';
import '../../../../../src/di/services_locator.dart';
import '../bloc/dash_board_bloc.dart';
import '../widgets/build_dashboard_content.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _selectedPeriod = 'weekly';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<DashBoardBloc>()
        ..add(GetAllStatisticsEvent(period: _selectedPeriod)),
      child: Scaffold(
        appBar: CustomAppBar(
          showLogoImage: true,
        ),
        body: BlocConsumer<DashBoardBloc, DashBoardState>(
          listener: (context, state) {
            if (state is ErrorGetStatisticsState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingGetStatisticsState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DoneGetStatisticsState) {
              return BuildDashboardContent(
                context,
                state.statistics,
                _selectedPeriod,
                onPeriodChanged: (newPeriod) {
                  setState(() {
                    _selectedPeriod = newPeriod;
                  });
                  context.read<DashBoardBloc>().add(
                        GetAllStatisticsEvent(period: newPeriod),
                      );
                },
              );
            } else if (state is ErrorGetStatisticsState) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message),
                      ElevatedButton(
                        onPressed: () {
                          context.read<DashBoardBloc>().add(
                                GetAllStatisticsEvent(period: _selectedPeriod),
                              );
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<DashBoardBloc>().add(
                      GetAllStatisticsEvent(period: _selectedPeriod),
                    );
              });
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
