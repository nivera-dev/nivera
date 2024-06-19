import 'package:flutter/material.dart';
import 'package:niveraapp/authentication/auth_screen.dart';
import 'package:niveraapp/constants.dart';
import 'package:niveraapp/global/global.dart';
import 'package:niveraapp/widgets/setting_tile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  late Image image1;
  @override
  void initState() {
    super.initState();
    image1 = Image.asset("assets/avatar.png", width: 80, height: 80,);
  }


  void didChangeDependecies() {
    precacheImage(image1.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.whiteFloor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 31, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25.0,),
                avatarCard(),
                const SizedBox(height: 20,),
                const Divider(),
                const SizedBox(height: 20,),
                SettingTile(title: "Log Out", route: () {firebaseAuth.signOut().then((value) {Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const AuthScreen()));});}, icon: Icons.exit_to_app),
                const SizedBox(height: 20,),
                const Divider(),
                const SizedBox(height: 20,),
                SettingTile(title: "FAQ", route: () {}, icon: Icons.info_outline),
                SettingTile(title: "Our Team", route: () {}, icon: Icons.people_rounded),
                const SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xffEDEFFE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.support_agent, size: 50, color: Color(0xff9CA2FF),),
                      Text("We are ready to help. Contact with us!.", style: mRobotoMedium.copyWith(
                        color: const Color(0xff9CA2FF),
                      ),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget avatarCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image1,
        const SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sharedPreferences!.getString("name")!,
              style: mRobotoBold.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20
              ),
            ),
            Text(
              sharedPreferences!.getString("email")!,
              style: mRobotoMedium.copyWith(
                  color: Colors.grey,
                  fontSize: 13
              ),
            ),
            Text(
              sharedPreferences!.getString("phone")!,
              style: mRobotoMedium.copyWith(
                  color: Colors.grey,
                  fontSize: 13
              ),
            ),
          ],
        ),
      ],
    );
  }

}
