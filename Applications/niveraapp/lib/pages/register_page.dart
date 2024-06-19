import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:niveraapp/authentication/auth_screen.dart';
import 'package:niveraapp/constants.dart';
import 'package:niveraapp/global/global.dart';
import 'package:niveraapp/widgets/custom_text_form_field.dart';
import 'package:niveraapp/widgets/error_dialog.dart';
import 'package:niveraapp/widgets/loading_dialog.dart';
import 'package:niveraapp/widgets/rounded_button.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  // FORM TEXT FIELD CONTROLLERS ----------------------------------------
  final _registerFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final bool status = false;


  // FORM VALIDATION AND SIGN UP ----------------------------------------
  Future<void> formValidation() async {
    if(nameController.text.isEmpty || passwordController.text.isEmpty  || phoneController.text.isEmpty || emailController.text.isEmpty){
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Please fill all the fields!",
            );
          }
      );
    }else{
      showDialog(
          context: context,
          builder: (c) {
            return const LoadingDialog(
              message: "Registering. Please wait...",
            );
          }
      );
      authenticateSellerAndSignUp();
    }
  }


  // FIREBASE AUTH ----------------------------------------
  void authenticateSellerAndSignUp() async{

    User? currentUser;
    await firebaseAuth.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim()).then((auth) {
      currentUser = auth.user;
    });

    if(currentUser != null) {
      savedDataToFirestore(currentUser!).then((value) {
        Navigator.pop(context);
        // send user to homepage
        //Route newRoute = MaterialPageRoute(builder: (c) => const HomePage());
        //Navigator.pushReplacement(context, newRoute);
        showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: "Succesfully Registered! Please log in.",
              );
            }
        ).then((value) {
          Route newRoute = MaterialPageRoute(builder: (c) => const AuthScreen());
          Navigator.pushReplacement(context, newRoute);
        });

      }).catchError((error) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: error.message.toString(),
              );
            }
        );
      });
    }
  }



  // FIREBASE FIRESTORE SAVING DATA ----------------------------------------
  Future savedDataToFirestore(User currentuser) async {
    FirebaseFirestore.instance.collection("").doc(currentuser.uid).set(
        {
          "": currentuser.uid,
          "": currentuser.email,
          "": nameController.text.trim(),
          "": phoneController.text.trim(),
        });

    // saving data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("", currentuser.uid);
    await sharedPreferences!.setString("", nameController.text.trim());
    await sharedPreferences!.setString("", currentuser.email.toString());
  }





  // DESIGN PART ----------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.whiteFloor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blackSizeHorizontal! * 60,
              width: double.infinity,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Image.asset(
                      "assets/welcome.gif",
                      //height: SizeConfig.blackSizeVertical! * 36,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
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
                        color: Color.fromARGB(30, 20, 61, 89),
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
                        "Registering",
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
                  "new era new episode!",
                  style: mRobotoSemiBold.copyWith(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),



            Form(
              key: _registerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 34),
                    child: Text(
                      "Name-Surname",
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
                      textInputType: TextInputType.name,
                      controller: nameController,
                      hintText: "Your full name",
                      obscureText: false,
                    ),
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
                      controller: emailController,
                      textInputType: TextInputType.text,
                      hintText: "Your e-mail address",
                      obscureText: false,
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.only(left: 34),
                    child: Text(
                      "Phone",
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
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      hintText: "Your phone number",
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
                      controller: passwordController,
                      textInputType: TextInputType.text,
                      hintText: "Password",
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),


            registerButton(),


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
                      "Register with Google.",
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
                    "new era new episode!.",
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

  // REGISTER BUTTON WIDGET ----------------------------------------
  Widget registerButton() {
    return Container(
      padding: const EdgeInsets.only(
          left: 34, right: 34, top: 8.0, bottom: 8.0),
      child: RoundedButton(
          name: "Register",
          height: 50,
          width: 500,
          onPressed: () async {
            formValidation();
          }
      ),
    );
  }
}

