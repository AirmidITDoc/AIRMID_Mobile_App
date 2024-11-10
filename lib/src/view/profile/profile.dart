import 'package:airmid/src/constant/color.dart';
import 'package:airmid/src/constant/image.dart';
import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/utils/hive/hive.dart';
import 'package:airmid/src/view/auth/signin.dart';
import 'package:airmid/src/widget/button.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  void initState() {
    _firstController.text = HiveUtils.get(HiveKeys.firstName) ?? "";
    _lastController.text = HiveUtils.get(HiveKeys.lastName) ?? "";
    _userNameController.text = HiveUtils.get(HiveKeys.userName) ?? "";
    _emailController.text = HiveUtils.get(HiveKeys.email) ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.indigo,
        foregroundColor: Colors.indigo,
        shadowColor: Colors.indigo,
        backgroundColor: Colors.indigo,
        leading: BackButton(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              HiveUtils.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignIn(),
                  ),
                  (route) => false);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          )
        ],
        title: Text(
          "Profile",
          style: TextStyle(
            color: ConstColor.white,
            fontWeight: FontWeight.w400,
            fontSize: 20.0.sp,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 120.h,
                width: 120.w,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage(Images.dammyImage)),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                  color: ConstColor.buttonColor,
                ),
              ),
            ),
            FxBox.h40,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      label: Text(
                        ConstString.firstName,
                      ),
                    ),
                    controller: _firstController,
                  ),
                ),
                FxBox.w20,
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      label: Text(
                        ConstString.lastName,
                      ),
                    ),
                    controller: _lastController,
                  ),
                ),
              ],
            ),
            FxBox.h24,
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                label: Text(
                  ConstString.userName,
                ),
              ),
              controller: _userNameController,
            ),
            FxBox.h24,
            TextFormField(
              readOnly: true,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(0.1),
                label: const Text(
                  ConstString.email,
                ),
              ),
              controller: _emailController,
            ),
            FxBox.h40,
            FxButton(
              buttonName: ConstString.save,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
