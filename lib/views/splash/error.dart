import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:clover/common/constants.dart';
import 'package:clover/common/router.dart';
import 'package:clover/common/widgets/custom_button.dart';

class ErrorSplash extends StatefulWidget {
  const ErrorSplash({super.key});

  @override
  State<StatefulWidget> createState() => _ErrorSplashState();
}

class _ErrorSplashState extends State<ErrorSplash> {
  void _restartApp() => Routing(context).entrypoint();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.mainGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetConstants.cloverSadWhite,
                      width: 60,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Que sorte, ocorreu um erro!",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cabin',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Tente novamente mais tarde.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Cabin',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: "Tentar novamente",
                onTap: _restartApp,
                borderRadiusStyle: BorderRadiusStyles.bottomRightBottomLeft.apply(),
                icon: FontAwesomeIcons.spinner,
                color: ColorConstants.mainWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
