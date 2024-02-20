import 'package:LTL_HRM/providers/share_provider.dart';
import 'package:LTL_HRM/routes/custome_router.dart';
import 'package:LTL_HRM/routes/route_names.dart';
import 'package:LTL_HRM/src/screens/home/components/leave_balance_card.dart';
import 'package:LTL_HRM/src/screens/home/components/mini_profile.dart';
import 'package:LTL_HRM/utils/utils.dart';
import 'package:flutter/material.dart';
import 'home_grid.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (context.read<ShareProvider>().permissions == null) {
      _isLoading = true;
    }
  }

  List<Widget> getChildren(BuildContext context) {
    List<Widget> list = [];

    if (UtilsHRM.getPermissionObject(context, 'My Request')?.app_view == '1') {
      list.add(HomeGrid(
          "MyRequest",
          "lib/assets/images/homeGrid/newMyReq.png",
          myRequestRoute,
          UtilsHRM.getPermissionObject(context, 'My Request')?.countItem ??
              '0'));
    }

    if (UtilsHRM.getPermissionObject(context, 'Emp Request')?.app_view == '1') {
      list.add(HomeGrid(
          "EmpRequest",
          "lib/assets/images/homeGrid/newEmpReq.png",
          CustomRouter.empRequestsScreen,
          UtilsHRM.getPermissionObject(context, 'Emp Request')?.countItem ??
              '0'));
    }

    if (UtilsHRM.getPermissionObject(context, 'Delegates')?.app_view == '1') {
      list.add(HomeGrid(
          "Delegates",
          "lib/assets/images/homeGrid/newDelegates.png",
          delegateRoute,
          UtilsHRM.getPermissionObject(context, 'Delegates')?.countItem ??
              '0'));
    }

    // list.add(HomeGrid("WorkFromHome", "lib/assets/images/homeGrid/newMyReq.png",
    //     CustomRouter.workFromHome, '0'));

    // list.add(HomeGrid(
    //     "EmpWFHRequests",
    //     "lib/assets/images/homeGrid/newEmpReq.png",
    //     CustomRouter.empWorkFromHome,
    //     '0'));

    //  if (UtilsHRM.getPermissionObject(context, 'Payslip')?.app_view == '1') {
    list.add(HomeGrid(
        "Payslip",
        "lib/assets/images/homeGrid/newPayslip.png",
        CustomRouter.payslipRoute,
        UtilsHRM.getPermissionObject(context, 'Payslip')?.countItem ?? '0'));

    list.add(HomeGrid("Leave Balance", "lib/assets/images/homeGrid/newAttendance.png",
        CustomRouter.leaveAllRoute, 
         UtilsHRM.getPermissionObject(context, 'Leave Balance')?.countItem ?? '0'));
    // }

    // if (UtilsHRM.getPermissionObject(context, 'Task')?.app_view == '1') {
    //   list.add(HomeGrid(
    //       "Tasks",
    //       "lib/assets/images/homeGrid/newTask.png",
    //       taskRoute,
    //       UtilsHRM.getPermissionObject(context, 'Tasks')?.countItem ?? '0'));
    // }

    // if (UtilsHRM.getPermissionObject(context, 'Attendance')?.app_view == '1') {
    //   list.add(HomeGrid(
    //       "Attendance",
    //       "lib/assets/images/homeGrid/newAttendance.png",
    //       attendanceRoute,
    //       null));
    // }

    // if (UtilsHRM.getPermissionObject(context, 'Holiday')?.app_view == '1') {
    //   list.add(HomeGrid(
    //       "Holidays",
    //       "lib/assets/images/homeGrid/newholidays.png",
    //       calendarViewRoute,
    //       null));
    // }

    // if (UtilsHRM.getPermissionObject(context, 'Insurance')?.app_view == '1') {
    //   list.add(HomeGrid("Insurance",
    //       "lib/assets/images/homeGrid/newInsurance.png", insuranceRoute, null));
    // }

    // if (UtilsHRM.getPermissionObject(context, 'Loans')?.app_view == '1') {
    //   list.add(HomeGrid(
    //       "Loans", "lib/assets/images/homeGrid/newLoan.png", loansRoute, null));
    // }

    // if (UtilsHRM.getPermissionObject(context, 'News')?.app_view == '1') {
    //   list.add(HomeGrid(
    //       "News",
    //       "lib/assets/images/homeGrid/newNews.png",
    //       newsList,
    //       UtilsHRM.getPermissionObject(context, 'News')?.countItem ?? '0'));
    // }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final permissions = context.read<ShareProvider>().permissions;
    print('Build HomeBody');

    // print('size ${size.width}');
    return Container(
      height: size.height,
      child: ListView(shrinkWrap: true, children: [
        Card(
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            children: [
              MiniProfile(),
              Divider(
                color: Colors.white,
              ),
              LeaveBalanceCard(),
            ],
          ),
        ),
        // Divider(),
        SizedBox(height: 8),
        permissions != null
            ? GridView.count(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                primary: false,
                padding: const EdgeInsets.all(6),
                // crossAxisSpacing: 2,
                // mainAxisSpacing: 1,
                crossAxisCount: 3,
                // crossAxisCount: size.width < 350 ? 2 : 3,
                // crossAxisSpacing: size.width < 350 ? 6 : 10,
                // mainAxisSpacing: size.width < 350 ? 6 : 15,
                // crossAxisCount: size.width < 350 ? 2 : 3,
                children: getChildren(context),
              )
            : Container(),
        SizedBox(
          height: 150,
        )
      ]),
    );
  }
}
