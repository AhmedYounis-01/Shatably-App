import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shatably_app/core/injection/injection_container.dart';
import 'package:shatably_app/feature/booking%20process/ui/screens/book_screen.dart';
import 'package:shatably_app/feature/maintenance%20work/data/repository/maintenance_work_repository.dart';
import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_cubit.dart';
import 'package:shatably_app/feature/maintenance%20work/logic/cubit/maintenance_work_state.dart';
import 'package:shatably_app/feature/maintenance work/ui/widgets/shimmer_loading.dart';
import 'package:shatably_app/feature/maintenance work/ui/widgets/header_image.dart';
import 'package:shatably_app/feature/maintenance work/ui/widgets/content_section.dart';

class MaintenanceWorkScreen extends StatelessWidget {
  final String serviceId;
  const MaintenanceWorkScreen({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
      ),
      body: BlocProvider(
        create:
            (context) =>
                MaintenanceWorkCubit(sl<MaintenanceWorkRepository>())
                  ..getMaintenanceWork(id: serviceId),
        child: BlocBuilder<MaintenanceWorkCubit, MaintenanceWorkState>(
          builder: (context, state) {
            // Check if the status is loading and show shimmer effect
            if (state.status == ServicesStatus.loading) {
              return const MaintenanceShimmerLoading();
            }
            if (state.status == ServicesStatus.error) {
              return Center(child: Text(state.errorMessage ?? ''));
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  MaintenanceHeaderImage(
                    imageUrl: state.maintenanceServiceModel?.imageUrl ?? '',
                    title: state.maintenanceServiceModel?.name ?? '',
                    onBack: () => Navigator.of(context).pop(),
                  ),
                  MaintenanceContentSection(
                    parentContext: context,
                    description:
                        state.maintenanceServiceModel?.description ?? '',
                    details: state.maintenanceServiceModel?.details ?? '',
                    averageRating:
                        state.maintenanceServiceModel?.averageRating.round(),
                    reviewCount: state.maintenanceServiceModel?.reviewCount,
                    priceText:
                        state.maintenanceServiceModel?.price != null
                            ? state.maintenanceServiceModel!.price.toString()
                            : '',
                    onBook: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => BookingScreen(
                                id: serviceId,
                                image:
                                    state.maintenanceServiceModel?.imageUrl ??
                                    '',
                                serviceType: "Maintenance",
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
