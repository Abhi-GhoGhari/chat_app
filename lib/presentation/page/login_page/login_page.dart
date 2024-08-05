import '../../../heders.dart';
import '../../../helper/authhelper.dart';
import '../../../helper/firestore_helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/bg_image/bg_img.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 250),
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: GlassContainer(
                    height: size.height * 0.65,
                    width: double.infinity,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: Colors.white12,
                    blur: 50,
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              label: const Text("Enter Email"),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              label: const Text("Enter Password"),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  User? user =
                                      await AuthHelper.instance.register(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  if (user != null) {
                                    await FirestoreHelper.instance
                                        .addUser(user: user);
                                    await FirestoreHelper.instance.getUser();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Register Successfully"),
                                        backgroundColor: Colors.green,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                  // else {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(
                                  //       content: Text("Register Failed!!!"),
                                  //       backgroundColor: Colors.red,
                                  //       behavior: SnackBarBehavior.floating,
                                  //     ),
                                  //   );
                                  // }
                                },
                                child: const Text("Register"),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  User? user = await AuthHelper.instance.signIn(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );

                                  if (user != null) {
                                    FirestoreHelper.instance.getUser();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("SignIn Successfully"),
                                        backgroundColor: Colors.green,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                    Navigator.pushReplacementNamed(
                                        context, AppRoutes.instance.homepage);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("SignIn Failed!!!"),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                },
                                child: const Text("Sign In"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 35),
                          Column(
                            children: [
                              Container(
                                height: size.height * 0.055,
                                width: size.width * 0.6,
                                decoration: const BoxDecoration(
                                  // color: Color(0xffBB9AB1),
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                child: Align(
                                  alignment: const Alignment(0, -0.1),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          UserCredential credential =
                                              await AuthHelper.instance
                                                  .signInWithGoogle();

                                          User? user = credential.user;

                                          if (user != null) {
                                            try {
                                              await FirestoreHelper.instance
                                                  .addUser(user: user);
                                              await FirestoreHelper.instance
                                                  .getUser();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "SignIn Successfully"),
                                                  backgroundColor: Colors.green,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                ),
                                              );
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  AppRoutes.instance.homepage);
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text("Error: $e"),
                                                  backgroundColor: Colors.red,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                ),
                                              );
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text("LogIn Failed!!!"),
                                                backgroundColor: Colors.red,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                          }
                                          // if (user != null) {
                                          //   await FirestoreHelper.instance
                                          //       .addUser(user: user);
                                          //   await FirestoreHelper.instance
                                          //       .getUser();
                                          //   ScaffoldMessenger.of(context)
                                          //       .showSnackBar(
                                          //     const SnackBar(
                                          //       content:
                                          //           Text("SignIn Successfully"),
                                          //       backgroundColor: Colors.green,
                                          //       behavior:
                                          //           SnackBarBehavior.floating,
                                          //     ),
                                          //   );
                                          //   Navigator.pushReplacementNamed(
                                          //       context,
                                          //       AppRoutes.instance.homepage);
                                          // } else {
                                          //   ScaffoldMessenger.of(context)
                                          //       .showSnackBar(
                                          //     const SnackBar(
                                          //       content:
                                          //           Text("LogIn Failed!!!"),
                                          //       backgroundColor: Colors.red,
                                          //       behavior:
                                          //           SnackBarBehavior.floating,
                                          //     ),
                                          //   );
                                          // }
                                        },
                                        child: Container(
                                          height: size.height * 0.03,
                                          width: size.width * 0.08,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "lib/assets/logo/google_logo.png"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "Login With Google",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: size.height * 0.055,
                                width: size.width * 0.6,
                                decoration: const BoxDecoration(
                                  // color: Color(0xffBB9AB1),
                                  color: Colors.white54,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                child: Align(
                                  alignment: const Alignment(0, -0.1),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: size.height * 0.045,
                                          width: size.width * 0.08,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "lib/assets/logo/facebook_logo.png"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "Login With Facebook",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.instance.signuppage,
                                  );
                                },
                                child: Container(
                                  height: size.height * 0.055,
                                  width: size.width * 0.6,
                                  decoration: const BoxDecoration(
                                    // color: Color(0xffBB9AB1),
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  child: const Align(
                                    alignment: Alignment(0, -0.1),
                                    child: Text(
                                      "Create a New Account",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Sorry Dont'v an account"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.instance.signuppage,
                                  );
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
