import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../src/routing/routes.dart';
import '../../../../../src/themes/app_colors.dart';
import '../../../../../src/themes/app_theme.dart';
import '../../../auth/presentation/widgets/login_widgets/login_button.dart';
import '../../../auth/presentation/widgets/login_widgets/signup_button.dart';
import '../widgets/circle_images_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var textGradient = LinearGradient(
      colors: [
        AppColors.primary,
        AppColors.secondary,
      ],
      begin: Alignment.centerLeft,
      end: Alignment.bottomCenter,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleImagesWidget(),
                SizedBox(height: size.height * 0.04),
                ShaderMask(
                  shaderCallback: (bounds) => textGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: Text.rich(
                    TextSpan(
                      style: textTheme.displayMedium!.copyWith(),
                      children: const [
                        TextSpan(
                            text: 'Welcome To Our ',
                            style: TextStyle(color: Color(0xFF01031A))),
                        TextSpan(
                            text: 'Best Fashion Store In',
                            style: TextStyle(color: Colors.white)),
                        TextSpan(
                            text: ' The World',
                            style: TextStyle(color: Color(0xFF01031A))),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: size.height * 0.025),
                // SignupButton(
                //   onPressed: () {
                //     // Navigator.of(context).push(
                //     //   MaterialPageRoute(builder: (_) => RegisterScreen()),
                //     // );
                //   },
                //   text: "Signup",
                // ),
                SizedBox(height: size.height * 0.018),
                LoginButton(
                  onPressed: () {
                    context.push(Routes.login);
                  },
                  text: "Login",
                ),
                SizedBox(height: size.height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
