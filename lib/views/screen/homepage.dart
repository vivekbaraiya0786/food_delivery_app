import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/helper/firebase_auth.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> signinKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupKey = GlobalKey<FormState>();


  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();

  final TextEditingController signupUserNameController =
  TextEditingController();
  final TextEditingController signupEmailController = TextEditingController();
  final TextEditingController signupPasswordController =
  TextEditingController();


  String? Email;
  String? Password;

  String? signupUserName = "Vivek";

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(Get.height * 0.025),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("WELCOME !",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  )),
              SizedBox(
                height: Get.width * 0.01,
              ),
              const Text("Sign up or Login to your Account",
                  style: TextStyle(
                    color: Colors.grey,
                  )),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActionChip(
                        label: Text("Login"),
                        onPressed: () {
                          setState(() {
                            index = 0;
                          });
                        },
                      ),
                      ActionChip(
                        label: Text("Sign Up"),
                        onPressed: () {
                          setState(() {
                            index = 1;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              IndexedStack(
                index: index,
                children: [

                  Container(
                    child: Form(
                      key: signinKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.1,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.person_outline),
                              SizedBox(
                                width: Get.height * 0.01,
                              ),
                              Text(
                                "Your Email/User Name",
                                style: TextStyle(
                                  fontSize: Get.height * 0.015,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              Email = newValue;
                            },
                            validator: (value) => (value!.isEmpty)
                                ? "Enter a Email"
                                : null,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                              hintText: "Enter your Email",
                            ),
                            controller: EmailController,
                          ),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.lock_outline_rounded),
                              SizedBox(
                                width: Get.height * 0.01,
                              ),
                              Text(
                                "Password",
                                style: TextStyle(
                                  fontSize: Get.height * 0.015,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          TextFormField(
                            controller: PasswordController,
                            onSaved: (newValue) {
                              Password = newValue;
                            },
                            validator: (value) => (value!.isEmpty)
                                ? "Enter a Password"
                                : null,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                              hintText: "Enter Your Password",
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    index = 2;
                                  });
                                },
                                child: const Text("Forgot Password?"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.2,
                          ),
                          SizedBox(
                            height: Get.height * 0.07,
                            width: Get.width * 0.9,
                            child: OutlinedButtonTheme(
                              data: OutlinedButtonThemeData(
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueAccent
                                          .withOpacity(0.5),
                                      // spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.blueAccent),
                                  ),
                                  onPressed: () async {
                                    if (signinKey.currentState !=
                                        null) {
                                      if (signinKey.currentState!
                                          .validate()) {
                                        signinKey.currentState!.save();
                                      }
                                      LoginWithEmailPassword();
                                      }
                                  },
                                  child: const Text(
                                    "Login",
                                    style:
                                    TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),

                  Container(
                    child: Form(
                      key: signupKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.09,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.person_outline),
                              SizedBox(
                                width: Get.height * 0.01,
                              ),
                              Text(
                                "Your FullName",
                                style: TextStyle(
                                  fontSize: Get.height * 0.015,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              signupUserName = newValue;
                            },
                            validator: (value) => (value!.isEmpty)
                                ? "Enter a Name"
                                : null,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                              hintText: "Enter your Name",
                            ),
                            controller: signupUserNameController,
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.email_outlined),
                              SizedBox(
                                width: Get.height * 0.01,
                              ),
                              Text(
                                "Your Email",
                                style: TextStyle(
                                  fontSize: Get.height * 0.015,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              Email = newValue;
                            },
                            validator: (value) => (value!.isEmpty)
                                ? "Enter a Email"
                                : null,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                              hintText: "Enter your Email",
                            ),
                            controller: EmailController,
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.lock_outline_rounded),
                              SizedBox(
                                width: Get.height * 0.01,
                              ),
                              Text(
                                "Password",
                                style: TextStyle(
                                  fontSize: Get.height * 0.015,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          TextFormField(
                            controller: PasswordController,
                            onSaved: (newValue) {
                              Password = newValue;
                            },
                            validator: (value) => (value!.isEmpty)
                                ? "Enter a Password"
                                : null,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                              hintText: "Enter Your Password",
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.1,
                          ),
                          SizedBox(
                            height: Get.height * 0.07,
                            width: Get.width * 0.9,
                            child: OutlinedButtonTheme(
                              data: OutlinedButtonThemeData(
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueAccent
                                          .withOpacity(0.5),
                                      // spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.blueAccent),
                                  ),
                                  onPressed: () {
                                    if (signupKey.currentState!
                                        .validate()) {
                                      signupKey.currentState!.save();
                                    }
                                    validateAndSignUp();
                                    setState(() {
                                      index = 0;
                                    });
                                  },
                                  child: const Text(
                                    "Sign Up",
                                    style:
                                    TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Text.rich(
                            TextSpan(
                              text: "Already User? ",
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        index = 0;
                                      });
                                    },
                                  text: "Login",
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> validateAndSignUp() async {
    if (signupKey.currentState!.validate()) {
      (signupKey.currentState!.save());

      SignInResponse data = await FirebaseAuthHelper.firebaseAuthHelper
          .signupWithEmailPassword(email: Email!, password: Password!,);

      if (data.user != null) {
        Get.snackbar(
          'Successfully',
          "Successfully Login",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );

        // Get.toNamed("/signup_Verification");
      } else {
        Get.snackbar(
          'Failed',
          data.msg!,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }


  Future<void> LoginWithEmailPassword() async {
    if (signupKey.currentState!.validate()) {
      (signupKey.currentState!.save());

      SignInResponse data = await FirebaseAuthHelper.firebaseAuthHelper
          .signinWithEmailPassword(email: Email!, password: Password!);

      if (data.user != null) {
        Get.snackbar(
          'Successfully',
          "Login Successfully",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        Get.offNamed("/MainPage", arguments: data.user);
      } else {
        Get.snackbar(
          'Failed',
          data.msg!,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }
}
