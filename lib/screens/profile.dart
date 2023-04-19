import 'package:flutter/material.dart';
import 'package:planet_app/constants/constants.dart';

import '../widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            //profile Image
            Container(
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Constants.primary.withOpacity(0.5),
                  width: 5,
                ),
              ),
              child: const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            ),
            //end profile Image
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'پرهام بحرکاظمی',
                  style: TextStyle(
                    color: Constants.blackColor,
                    fontSize: 20,
                    fontFamily: Constants.vazirFont,
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: 20,
                  child: Image.asset('assets/images/verified.png'),
                ),
              ],
            ),
            //end profile name
            const SizedBox(height: 10),
            //profile email
            Text(
              'damon.bahrekazemi@gmail.com',
              style: TextStyle(
                color: Constants.blackColor.withOpacity(0.4),
                fontSize: 15,
                fontFamily: Constants.danaFont,
              ),
            ),
            //end profile email
            const SizedBox(height: 30),
            //profile option
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                //backButton

                BuildProfileOption(title: 'پروفایل من', icon: Icons.person),

                BuildProfileOption(title: 'تنظیمات', icon: Icons.settings),

                BuildProfileOption(
                    title: 'اطلاع رسانی ها', icon: Icons.notifications),

                BuildProfileOption(
                    title: 'شبکه های اجتماعی', icon: Icons.share),

                BuildProfileOption(title: 'خروج', icon: Icons.logout),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
