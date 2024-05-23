import 'package:flutter/material.dart';

import 'package:clover/common/constants.dart';
import 'package:clover/common/widgets/custom_button.dart';
import 'package:clover/common/widgets/text_title.dart';
import 'package:clover/views/session/widgets/text_secondary.dart';

class TopUsersModal extends StatelessWidget {
  const TopUsersModal({super.key});

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
            const Column(
              children: [
                TextTitle(text: "Folhas?"),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextSecondary(
                    text:
                        "Cada vez que voce interage com a Clover assistindo a um anuncio, adicionando mais trevos ou participando de sorteios, voce ganha Folhas; uma medida de pontuacao.",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextSecondary(
                    text:
                        "O usuario com maior quantidade de folhas ganhara um premio em dinheiro ao fim do tempo. Utilize qualquer um dos metodos para pontuar.",
                  ),
                ),

                //
                SizedBox(height: 30),
              ],
            ),
            CustomButton(
              text: "Entendido!",
              onTap: () => Navigator.pop(context),
              borderRadiusStyle: BorderRadiusStyles.bottomRightBottomLeft.apply(),
              color: ColorConstants.mainGreen,
            )
          ],
        ),
      ),
    );
  }
}
