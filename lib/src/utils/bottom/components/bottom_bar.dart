// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
import 'package:airmid/src/constant/color.dart';
import 'package:airmid/src/constant/const.dart';
import 'package:airmid/src/constant/image.dart';
import 'package:airmid/src/utils/bottom/components/item_navigation_view.dart';
import 'package:airmid/src/utils/bottom/components/navigation_view.dart';
import 'package:airmid/src/view/admitted_patient.dart';
import 'package:airmid/src/view/dashboard/dashboard.dart';
import 'package:airmid/src/view/hospital_summry/hospital_summry.dart';
import 'package:airmid/src/view/op_list/opd_list.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> pages = [
    const Dashboard(),
    HospitalSummry(),
    const OpdList(),
    const AdmittedPatient(),
  ];
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    currentTab.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTab,
      builder: (context, value, child) => PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (currentTab.value == 0) {
            return;
          }
          currentTab.value = 0;
          currentTab.notifyListeners();
        },
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0.9),
          key: scaffoldKey,
          body: pages[value],
          bottomNavigationBar: SizedBox(
            height: 90,
            child: ValueListenableBuilder<int>(
              valueListenable: currentTab,
              builder: (context, value, child) => NavigationView(
                onChangePage: (index) {
                  currentTab.value = index;
                  currentTab.notifyListeners();
                },
                curve: Curves.ease,
                backgroundColor: ConstColor.white,
                durationAnimation: const Duration(milliseconds: 400),
                items: [
                  ItemNavigationView(
                    childAfter:
                        _childAfter(icon: Images.dashboardFill, title: "HOME"),
                    childBefore:
                        _childBefore(icon: Images.dashboard, title: "HOME"),
                  ),
                  ItemNavigationView(
                    childAfter: _childAfter(
                        icon: Images.dashboardFill, title: "DASHBORD"),
                    childBefore: _childBefore(
                        icon: Images.dashboard, title: "COLLECTION"),
                  ),
                  ItemNavigationView(
                    childAfter: _childAfter(
                        icon: Images.opdListFill,
                        title: "OPD List".toUpperCase()),
                    childBefore: _childBefore(
                        icon: Images.opdList, title: "OPD  List".toUpperCase()),
                  ),
                  ItemNavigationView(
                    childAfter: _childAfter(
                        icon: Images.admissionFill,
                        title: "Admission List".toUpperCase()),
                    childBefore: _childBefore(
                        icon: Images.admission,
                        title: "Admission List".toUpperCase()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _childAfter({
    required String icon,
    required String title,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            fit: BoxFit.contain,
            icon,
            height: 28.0.sp,
            width: 28.0.sp,
          ),
          FxBox.h4,
          Text(
            title,
            style: TextStyle(
              color: ConstColor.black,
              // fontWeight: FontWeight.w100,
              fontSize: 12.0.sp,
            ),
          )
        ],
      ),
    );
  }

  Widget _childBefore({
    required String icon,
    required String title,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            fit: BoxFit.contain,
            icon,
            height: 24.0.sp,
            width: 24.0.sp,
            color: Colors.black,
          ),
          FxBox.h4,
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ConstColor.black,
                  // fontWeight: FontWeight.w100,
                  fontSize: 10.0.sp,
                ),
          )
        ],
      ),
    );
  }
}
