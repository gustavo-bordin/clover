import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

import 'package:clover/bloc/session.bloc.dart';
import 'package:clover/common/bloc_handlers.dart';
import 'package:clover/common/constants.dart';
import 'package:clover/common/router.dart';
import 'package:clover/common/widgets/custom_button.dart';
import 'package:clover/common/widgets/loading_layer.dart';
import 'package:clover/common/widgets/text_title.dart';
import 'package:clover/views/session/widgets/bottom_progress.dart';
import 'package:clover/views/session/widgets/text_secondary.dart';
import 'package:clover/views/session/widgets/text_welcome.dart';

class AskOtpCode extends StatefulWidget {
  final String phoneNumber;
  final String userId;

  const AskOtpCode({
    super.key,
    required this.phoneNumber,
    required this.userId,
  });

  @override
  State<AskOtpCode> createState() => _AskOtpCodeState();
}

class _AskOtpCodeState extends State<AskOtpCode> {
  TextEditingController otpCodeController = TextEditingController();

  void _handleConfirmPhoneSessionSuccess(ConfirmPhoneSessionSuccess state) {
    context.read<SessionCubit>().get();
  }

  void _confirmPhoneSession() {
    context.read<SessionCubit>().confirmPhoneSession(widget.userId, otpCodeController.text);
  }

  void _returnToAskPhoneNumber() {
    Routing(context).askPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionCubit, SessionState>(
      listener: (context, state) {
        switch (state) {
          case SessionFailure _:
            handleFailure(context, state.failure);
          case ConfirmPhoneSessionSuccess _:
            _handleConfirmPhoneSessionSuccess(state);
        }
      },
      builder: (context, state) {
        return LoadingLayer(
          isLoading: state is SessionLoading,
          child: Scaffold(
            bottomNavigationBar: const LoginProgress(pages: 3, currentPage: 2),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      // Clove logo
                      const Image(
                        width: 150,
                        image: AssetConstants.cloverFullLogoGreen,
                      ),
                      const SizedBox(height: 30),

                      // Motivational sentence
                      const TextWelcome(text: "Voce esta mais perto de ser um grande vencedor!"),
                      const SizedBox(height: 100),

                      // Instructions
                      const TextTitle(text: "Insira o codigo recebido"),
                      const SizedBox(height: 10),
                      TextSecondary(
                        text:
                            "Enviamos um codigo de 6 digitos via SMS para ${widget.phoneNumber}. Insira-o no campo abaixo para confirmar seu numero e continuar.",
                      ),
                      const SizedBox(height: 10),

                      PinCodeFields(
                        controller: otpCodeController,
                        length: 6,
                        onComplete: (output) => {},
                        textStyle: TextStyle(
                          color: ColorConstants.mainText,
                        ),
                        fieldHeight: 50,
                        activeBorderColor: ColorConstants.mainGreen,
                      ),
                      const SizedBox(height: 10),

                      // Button confirm
                      CustomButton(
                        text: "Confirmar",
                        onTap: _confirmPhoneSession,
                        borderRadiusStyle: BorderRadiusStyles.bottomRightBottomLeft.apply(),
                        color: ColorConstants.mainWhite,
                      ),
                      const SizedBox(height: 30),

                      GestureDetector(
                        onTap: _returnToAskPhoneNumber,
                        child: Text(
                          'Alterar numero ou reenviar codigo',
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorConstants.secondaryText,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
