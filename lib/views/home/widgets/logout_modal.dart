import 'package:flutter/material.dart';

import 'package:clover/common/constants.dart';
import 'package:clover/common/widgets/custom_button.dart';
import 'package:clover/common/widgets/text_title.dart';
import 'package:clover/views/session/widgets/text_secondary.dart';

class LogoutModal extends StatelessWidget {
  final VoidCallback onTapLogout;

  const LogoutModal({super.key, required this.onTapLogout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const TextTitle(text: "Precisa de ajuda?"),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: TextSecondary(
                    text: "Contate-nos por um dos meios abaixo",
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ColorConstants.mainGreen),
                        ),
                        child: const Image(
                          image: AssetConstants.whatsppLogo,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ColorConstants.mainGreen),
                        ),
                        child: const Image(
                          image: AssetConstants.gmailLogo,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            CustomButton(
              text: "Sair da conta",
              onTap: onTapLogout,
              borderRadiusStyle: BorderRadiusStyles.bottomRightBottomLeft.apply(),
              color: ColorConstants.mainGreen,
            )
          ],
        ),
      ),
    );
  }
}
