import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:niveraapp/constants.dart';
import 'package:niveraapp/global/global.dart';
import 'package:niveraapp/pages/main_page.dart';
import 'package:niveraapp/pages/register_page.dart';
import 'package:niveraapp/widgets/custom_text_form_field.dart';
import 'package:niveraapp/widgets/error_dialog.dart';
import 'package:niveraapp/widgets/loading_dialog.dart';
import 'package:niveraapp/widgets/rounded_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, DeviceOrientation.portraitDown
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  // KEYS AND FORM TEXT FIELD CONTROLLERS ----------------------------------------
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // FORM VALIDATION AND LOGIN ----------------------------------------
  formValidation(){
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      //login
      loginNow();
    }else {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(message: "Please type your Email/password!");
          }
      );
    }
  }


  // FIREBASE AUTH LOGIN ----------------------------------------
  loginNow() async{

    showDialog(
        context: context,
        builder: (c) {
          return const LoadingDialog(message: "Checking your informations...");
        }
    );

    User? currentUser;
    await firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((auth) {
      currentUser = auth.user!;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(message: error.message.toString());
          }
      );
    });

    if(currentUser != null) {
      readDataAndSetDataLocally(currentUser!);
    }

  }



  // SAVING DATA LOCALLY ----------------------------------------
  Future readDataAndSetDataLocally(User currentUser) async{
    await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).get().then((snapshot) async{
      if(snapshot.exists){
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const HomePage()));

        await  sharedPreferences!.setString("", currentUser.uid);
        await  sharedPreferences!.setString("", snapshot.data()![""]);
        await  sharedPreferences!.setString("", snapshot.data()![""]);
        await  sharedPreferences!.setString("", snapshot.data()![""]);
      }else {
        firebaseAuth.signOut();
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const AuthScreen()));
        showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(message: "There is no user.",);
            }
        );
      }
    });
  }


  // DESIGN PART ----------------------------------------
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: ColorPalette.whiteFloor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blackSizeHorizontal! * 66,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    "assets/welcome.gif",
                    height: SizeConfig.blackSizeVertical! * 50,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 44,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(58),
                            topRight: Radius.circular(58)),
                        color: Color.fromARGB(52, 245, 157, 155),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 25,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(42),
                          topRight: Radius.circular(42),
                        ),
                        color: ColorPalette.whiteFloor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome!",
                        style: mRobotoBold.copyWith(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              height: 5.0,
              color: ColorPalette.whiteFloor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "If you don't have account ",
                  style: mRobotoSemiBold.copyWith(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()),)
                  },//Navigator.pushNamed(context, '/register'),
                  child: Text(
                    ' Register',
                    style: mRobotoBold.copyWith(
                        color: ColorPalette.subColor, fontSize: 16),
                  ),
                )
              ],
            ),
            Form(
              key: _loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(
                    height: 50,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 34),
                    child: Text(
                      "Email",
                      style: mRobotoBold.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, left: 34, right: 34, bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[100]!))),
                    child: CustomTextFormField(
                      textInputType: TextInputType.text,
                      controller: emailController,
                      hintText: "Email",
                      obscureText: false,
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 34),
                    child: Text(
                      "Password",
                      style: mRobotoBold.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 10, left: 34, right: 34, bottom: 10),
                    child: CustomTextFormField(
                      textInputType: TextInputType.text,
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 20.0),
                    alignment: Alignment.topRight,
                    child: Text(
                      "*reset password?",
                      style: mRobotoBold.copyWith(
                        fontSize: 14,
                        color: ColorPalette.subColor,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 34, right: 34, top: 8.0, bottom: 8.0),
              child: RoundedButton(
                name: "Login",
                height: 50,
                width: 500,
                onPressed: () {
                  formValidation();
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: const Divider(
                      color: ColorPalette.subColor,
                      height: 50,
                    ),
                  ),
                ),
                const Text(
                  "or",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: const Divider(
                      color: ColorPalette.subColor,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 15.0,
              color: Colors.transparent,
            ),
            SizedBox(
              height: 30,
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/google.png"),
                    Text(
                      "Log in with Google",
                      style: mRobotoMedium.copyWith(
                          fontSize: 16,
                          color: ColorPalette.subColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "nivera",
                    style: mRobotoRegular.copyWith(
                      fontSize: 50.0,
                      color: ColorPalette.mainColor,
                    ),
                  ),
                  Text(
                    "new era new episode!",
                    style: mRobotoRegular.copyWith(
                      fontSize: 15.0,
                      color: ColorPalette.subColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
