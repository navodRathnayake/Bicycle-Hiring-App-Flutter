library routes;

import 'package:final_project/Logic/Bloc/Cycling/View/steps/bicycle_data_view.dart';
import 'package:final_project/Logic/Bloc/Cycling/View/steps/bicycle_package_view.dart';
import 'package:final_project/Logic/Bloc/Cycling/View/steps/bicycle_term_and_condition_view.dart';
import 'package:final_project/Logic/Bloc/Cycling/bloc/cycling_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/billing_details_page.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/recent_activity_route_page.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/view/recent_activity_view.dart';
import 'package:final_project/bottom_navigation_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static Route onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const BottomNavigationBarController(),
        );

      case '/recentActivity':
        return MaterialPageRoute(
          builder: (context) =>
              RecentActivityView(themeData: Theme.of(context), filter: const [
            [
              'Sun',
              05,
              false,
              [
                ['Peradeniya', 'Kandy', '9.00 am', '13.30 pm'],
                ['Peradeniya', 'Kandy', '9.00 am', '13.30 pm']
              ]
            ],
            [
              'Mon',
              06,
              false,
              [
                ['Peradeniya', 'Kandy', '9.00 am', '13.30 pm']
              ]
            ],
            ['Tue', 07, false, null],
            [
              'Wed',
              08,
              false,
              [
                ['Peradeniya', 'Kandy', '9.00 am', '13.30 pm'],
                ['Peradeniya', 'Kandy', '9.00 am', '13.30 pm'],
                ['Peradeniya', 'Kandy', '9.00 am', '13.30 pm']
              ]
            ],
            ['Thu', 09, true, null],
            ['Fri', 10, false, null],
            ['Sat', 11, false, null],
            ['Sun', 12, false, null],
            ['Mon', 13, false, null],
            ['Tue', 14, false, null],
            [
              'Wed',
              15,
              false,
              [
                ['Peradeniya', 'Kandy', '9.00 am', '13.30 pm']
              ]
            ],
            ['Thu', 16, false, null],
            ['Fri', 17, false, null],
            ['Sat', 18, false, null],
          ]),
        );

      case '/billing':
        return MaterialPageRoute(
            builder: (context) =>
                BillingDetailsPage(themeData: Theme.of(context)));

      case '/recentActivityRoute':
        return MaterialPageRoute(
            builder: (context) =>
                RecentActivityRoutePage(themeData: Theme.of(context)));

      case '/bicycleDataView':
        return MaterialPageRoute(
            builder: (context) =>
                BicycleDataView(themeData: Theme.of(context)));

      case '/bicyclePackageView':
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (_) => CyclingBloc(),
                  child: BicyclePackageView(themeData: Theme.of(context)),
                ));

      case '/bicycleTermAndCondition':
        return MaterialPageRoute(
            builder: (context) =>
                BicycleTermAndConditionView(themeData: Theme.of(context)));

      default:
        return MaterialPageRoute(
          builder: (context) => const BottomNavigationBarController(),
        );
    }
  }
}
