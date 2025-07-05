import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors/bloc/environment_cubit.dart';
import 'package:flutter_flavors/config/environment.dart';

import '../enum/status_cubit.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnvironmentCubit, EnvironmentState>(
      builder: (context, state) {
        if (state.status == Status.success) {
          if (state.environment?.environment != Environment.production) {
            return Banner(
              message: state.environment?.name ?? '',
              color: state.environment?.color ?? Colors.white,
              location: BannerLocation.topEnd,
              child: child,
            );
          }
          return child;
        }
        return const SizedBox.shrink();
      },
    );
  }
}