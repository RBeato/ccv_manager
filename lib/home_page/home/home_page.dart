import 'package:ccv_manager/home_page/floating_action_button/floating_button.dart';
import 'package:ccv_manager/home_page/home/device_layout/mobile_home_page.dart';
import 'package:ccv_manager/home_page/home/device_layout/web_home_page.dart';
import 'package:ccv_manager/home_page/provider/employees_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/check_is_mobile.dart';
import 'background_image.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  //Adicionar users manualmente à firebase

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeesAsync = ref.watch(employeesProvider);
    return employeesAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.teal)),
        error: (err, stack) => Text('Error fetching employees: $err'),
        data: (employees) {
          print("Employees: $employees");
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Scaffold(
              body: Stack(
                children: [
                  BackgroundImage(),
                  isMobile(constraints)
                      ? const MobileVersion()
                      : const WebVersion(),
                ],
              ),
              floatingActionButton: const CustomFloatingButton(),
            );
          });
        });
  }
}
